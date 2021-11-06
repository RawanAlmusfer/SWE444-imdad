import * as functions from "firebase-functions";
import * as admin from "firebase-admin";
admin.initializeApp();

export const notifyMosqueManager = functions.firestore.document("requests/{requestID}").onUpdate(async (snapshot, context) => {
  const data = snapshot.after.data();
  if (data.amount == data.donated || data.amount_requested == data.donated) {
    const token = data.token;
    if (token.empty) {
      console.log("No Device");
    } else {
      const payloadData = {
        title: "تم اكتمال المبلغ",
        message: "لقد تم اكتمال طلبك:" + " " + data.title,
      };
      const payload = {
        data: payloadData,
      };
      return await admin.messaging().sendToDevice(token, payload).then((response) => {
        console.log("Pushed All Notifications");
      });
    }
  }
  console.log("Not completed yet");
});

export const notifysubscribedVolunteers = functions.firestore.document("requests/{requestID}").onCreate(async (snapshot, context) => {
  const data = snapshot.data();
    const token = data.token;
    if (token.empty) {
      console.log("No Device");
    } else {
      const payloadData = {
        title: "طلب جديد",
        message: "اصدر مسجد" + " " + data.title + "طلب جديد",
      };
      const payload = {
        data: payloadData,
      };
      return await admin.messaging().sendToDevice(token, payload).then((response) => {
        console.log("Pushed All Notifications");
      });
    }
});
