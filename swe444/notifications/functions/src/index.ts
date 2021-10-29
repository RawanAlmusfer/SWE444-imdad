import * as functions from "firebase-functions";
import * as admin from "firebase-admin";
admin.initializeApp();

export const notifyMosqueManager = functions.firestore.document("requests/{requestID}").onCreate((snapshot, context) => {
  const data = snapshot.data();
  admin.firestore().collection("tokens").get().then(async (snapshots) => {
    const tokens = [];
    if (snapshots.empty) {
      console.log("No Device");
    } else {
      for (const token of snapshots.docs) {
        tokens.push(token.data().token);
      }
      const payloadData = {
        title: "تم اكتمال المبلغ",
        message: "لقد تم اكتمال طلبك:" + " " + data.title,
      };
      const payload = {
        data: payloadData,
      };
      return await admin.messaging().sendToDevice(tokens, payload).then((response) => {
        console.log("Pushed All Notifications");
      });
    }
  })
      .catch((err) => {
        console.log(err);
      });
});
