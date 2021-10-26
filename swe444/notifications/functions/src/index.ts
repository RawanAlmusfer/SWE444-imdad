import * as functions from "firebase-functions";
import * as admin from "firebase-admin";

admin.initializeApp();

const db = admin.firestore();

// const fcm = admin.messaging();

// Start writing Firebase Functions
// https://firebase.google.com/docs/functions/typescript

export const helloWorld = functions.https.onRequest((request, response) => {
  functions.logger.info("Hello logs!", {structuredData: true});
  response.send("Hello from Firebase!");
});

export const notifyUsers = (functions.firestore.document("requests/{requestID}").onCreate(async ( snapshot ) => {
  const querySnapshot = await (db.collection("tokens").get());
  querySnapshot.forEach(async (tokenDoc) => {
    console.log(tokenDoc.data().token);
  });
}));
