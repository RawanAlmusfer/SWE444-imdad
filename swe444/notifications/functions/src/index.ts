import * as functions from "firebase-functions";
import * as admin from "firebase-admin";
admin.initializeApp();

export const notifyMosqueManager = functions.firestore
 .document('requests/{requestID}')
    .onUpdate((snapshot, context) => {
    let data = snapshot.after.data;
   admin
    .firestore()
    .collection('tokens')
    .get()
    .then(async (snapshots) => {
      let tokens = [];
     if (snapshots.empty) {
       console.log('No Device');
     } else {
       for (let token of snapshots.docs) {
         tokens.push(token.data().token);
        }
     let  payloadData = {
      title: 'تم اكتمال المبلغ',
      message: 'لقد تم اكتمال طلبك:' + ' ' + data.name,
      };
      var payload = {
        data: payloadData,
      };
      return await admin
      .messaging()
      .sendToDevice(tokens, payload)
      .then((response) => {
        console.log('Pushed All Notifications'); 
      });
    }
  })
  .catch((err) => {
    console.log(err);
  });
});