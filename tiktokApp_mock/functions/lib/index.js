"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.onLikedRemoved = exports.onLikedCreated = exports.onVideoCreated = void 0;
const functions = require("firebase-functions");
const admin = require("firebase-admin");
admin.initializeApp();
exports.onVideoCreated = functions.firestore
    .document("videos/{videoId}")
    .onCreate(async (snapshot, context) => {
    const spawn = require('child-process-promise').spawn;
    const video = snapshot.data();
    await spawn("ffmpeg", [
        "-i",
        video.videoUrl,
        "-ss",
        "00:00:01.000",
        "-vframes",
        "1",
        "-vf",
        "scale=150:-1",
        `/tmp/${snapshot.id}.jpg`
    ]);
    const storage = admin.storage();
    const [file, _] = await storage.bucket().upload(`/tmp/${snapshot.id}.jpg`, {
        destination: `thumbnails/${snapshot.id}.jpg`,
    });
    await file.makePublic();
    await snapshot.ref.update({ thumbnailUrl: file.publicUrl() });
    const db = admin.firestore();
    await db.collection("users")
        .doc(video.creatorUid)
        .collection("videos")
        .doc(snapshot.id)
        .set({
        thumbnailUrl: file.publicUrl(),
        videoId: snapshot.id
    });
});
// '좋아요'를 눌렀을 때
exports.onLikedCreated = functions.firestore
    .document("likes/{likeId}")
    .onCreate(async (snapshot, context) => {
    const db = admin.firestore();
    const [videoId, _] = snapshot.id.split("000");
    await db.collection("videos").doc(videoId).update({
        likes: admin.firestore.FieldValue.increment(1)
    });
});
exports.onLikedRemoved = functions.firestore
    .document("likes/{likeId}")
    .onDelete(async (snapshot, context) => {
    const db = admin.firestore();
    const [videoId, _] = snapshot.id.split("000");
    await db.collection("videos").doc(videoId).update({
        likes: admin.firestore.FieldValue.increment(-1)
    });
});
//# sourceMappingURL=index.js.map