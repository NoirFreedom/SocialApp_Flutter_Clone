
import * as functions from "firebase-functions";
import * as admin from "firebase-admin";

admin.initializeApp();

// 비디오 생성시 썸네일 추출기능
export const onVideoCreated = functions.firestore
.document("videos/{videoId}")
.onCreate(async(snapshot,context) => {
    const spawn = require('child-process-promise').spawn;
    const video = snapshot.data();
    await spawn("ffmpeg",[
        "-i", // 입력 파일
        video.videoUrl, // 비디오 URL
        "-ss", // 스냅샷을 찍을 시간
        "00:00:01.000", // 1초부터
        "-vframes", // 비디오 프레임 추출
        "1", // 1프레임만 추출
        "-vf", // 비디오 필터
        "scale=150:-1", // 150픽셀로 줄임
        `/tmp/${snapshot.id}.jpg` // 저장할 파일명
    ]);
    const storage = admin.storage();
    const [file, _] = await storage.bucket().upload(`/tmp/${snapshot.id}.jpg`, {
        destination: `thumbnails/${snapshot.id}.jpg`,
    });
    await file.makePublic();
    await snapshot.ref.update({thumbnailUrl: file.publicUrl()});
    const db = admin.firestore();

    await db.collection("users")
    .doc(video.creatorUid)
    .collection("videos")
    .doc(snapshot.id)
    .set({
        thumbnailUrl: file.publicUrl(), 
        videoId: snapshot.id});
});


// '좋아요'를 눌렀을 때(생성)
export const onLikedCreated = functions.firestore
.document("likes/{likeId}")
.onCreate(async(snapshot, context) => {
    const db = admin.firestore();
    const [videoId, userId] = snapshot.id.split("000");

    await db.collection("users").doc(userId).collection("likes").doc(videoId).set({liked:true});

    await db.collection("videos").doc(videoId).update({
        likes:admin.firestore.FieldValue.increment(1)
    })
});

// '좋아요'를 눌렀을 때(삭제)
export const onLikedRemoved = functions.firestore
.document("likes/{likeId}")
.onDelete(async(snapshot, context) => {
    const db = admin.firestore();
    const [videoId, userId] = snapshot.id.split("000");

    await db.collection("users").doc(userId).collection("likes").doc(videoId).delete();
    await db.collection("videos").doc(videoId).update({
        likes:admin.firestore.FieldValue.increment(-1)
    })
});