const {
  onDocumentCreated,
  onDocumentUpdated,
}=require("firebase-functions/v2/firestore");
const {initializeApp} = require("firebase-admin/app");
const {getMessaging}=require("firebase-admin/messaging");
const {getFirestore} = require("firebase-admin/firestore");
initializeApp();
const db=getFirestore();
// When a new note is created,
exports.notification=onDocumentCreated(
    "notes/{notesId}",
    async (event)=>{
      event.params.notesId;
      const note =event.data.data();
      const title=note.title;
      const userFcm= await db.collection("users").doc("users_1").get();
      const userData=userFcm.data();
      const fcmToken = userData.fcmToken;
      const msg={
        token: fcmToken,
        notification: {
          title: `New Note ${title}`,
        },
      };
      await getMessaging().send(msg);
    });
exports.update=onDocumentUpdated(
    "notes/{notesId}",
    async (event)=>{
      const note=event.data.after.data();
      const title =note.title;
      const userSnapshot=await db.collection("users").doc("users_1").get();
      const userData=userSnapshot.data();
      const token =userData.fcmToken;
      const msg={
        token: token,
        notification: {
          title: `${title} document updated`,
        },
      };
      await getMessaging().send(msg);
    });
