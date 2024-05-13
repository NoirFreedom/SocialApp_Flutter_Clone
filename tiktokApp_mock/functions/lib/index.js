"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.onLikedRemoved = exports.onLikedCreated = exports.onVideoCreated = void 0;
const functions = require("firebase-functions"); // 파이어베이스 클라우드 함수
const admin = require("firebase-admin"); // 파이어베이스 관리자
admin.initializeApp(); // 파이어베이스 관리자 초기화
// 비디오 생성시 썸네일 추출기능
exports.onVideoCreated = functions.firestore // 파이어베이스 클라우드 함수 생성
    .document("videos/{videoId}") // 비디오 컬렉션의 도큐먼트 생성시
    .onCreate(async (snapshot, context) => {
    const spawn = require('child-process-promise').spawn; // 비디오 썸네일 추출을 위한 라이브러리
    const video = snapshot.data(); // 생성된 비디오 데이터
    await spawn("ffmpeg", [
        "-i",
        video.videoUrl,
        "-ss",
        "00:00:01.000",
        "-vframes",
        "1",
        "-vf",
        "scale=150:-1",
        `/tmp/${snapshot.id}.jpg` // 임시저장 파일명(구글 클라우드 서버에서 코드가 동작할 동안 임시 파일 저장소 'tmp'에 저장됨)
    ]);
    const storage = admin.storage(); // 구글 클라우드 스토리지
    const [file, _] = await storage.bucket().upload(`/tmp/${snapshot.id}.jpg`, {
        destination: `thumbnails/${snapshot.id}.jpg`, // 썸네일 저장 경로
    });
    await file.makePublic(); // 썸네일 파일을 공개로 설정
    await snapshot.ref.update({ thumbnailUrl: file.publicUrl() }); // 생성된 비디오 도큐먼트에 썸네일 URL 추가
    const db = admin.firestore();
    await db.collection("users") // 유저의 비디오 컬렉션에 썸네일 URL 추가
        .doc(video.creatorUid) // 유저의 UID
        .collection("videos") // 비디오 컬렉션
        .doc(snapshot.id) // 비디오 ID
        .set({
        thumbnailUrl: file.publicUrl(),
        videoId: snapshot.id
    }); // 썸네일 URL과 비디오 ID 추가
});
// '좋아요'를 눌렀을 때(생성)
exports.onLikedCreated = functions.firestore
    .document("likes/{likeId}") // 'likes' 컬렉션의 도큐먼트 생성시
    .onCreate(async (snapshot, context) => {
    const db = admin.firestore();
    const [videoId, userId] = snapshot.id.split("000"); // 좋아요 도큐먼트 ID에서 비디오 ID와 유저 ID 추출
    await db.collection("users").doc(userId).collection("likes").doc(videoId).set({ liked: true }); // 좋아요한 비디오를 유저의 'likes' 컬렉션에 추가
    await db.collection("videos").doc(videoId).update({
        likes: admin.firestore.FieldValue.increment(1)
    });
    const video = await (await db.collection("videos").doc(videoId).get()).data();
    if (video) {
        const creatorUid = video.creatorUid;
        const user = (await db.collection("users").doc(creatorUid).get()).data();
        if (user) {
            const token = user.token;
            admin.messaging().sendToDevice(token, {
                data: {
                    "screen": "123",
                },
                notification: {
                    title: "someone liked your video",
                    body: "check it out"
                }
            });
        }
    }
});
// '좋아요'를 눌렀을 때(삭제)
exports.onLikedRemoved = functions.firestore
    .document("likes/{likeId}") // 'likes' 컬렉션의 도큐먼트 삭제시
    .onDelete(async (snapshot, context) => {
    const db = admin.firestore(); // 파이어베이스 관리자
    const [videoId, userId] = snapshot.id.split("000"); // 좋아요 도큐먼트 ID에서 비디오 ID와 유저 ID 추출
    await db.collection("users").doc(userId).collection("likes").doc(videoId).delete(); // 유저의 'likes' 컬렉션에서 좋아요한 비디오 삭제
    await db.collection("videos").doc(videoId).update({
        likes: admin.firestore.FieldValue.increment(-1) // 비디오의 'likes' 필드를 1 감소
    });
});
//# sourceMappingURL=index.js.map