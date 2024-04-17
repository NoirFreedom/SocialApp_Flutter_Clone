
import * as functions from "firebase-functions"; // 파이어베이스 클라우드 함수
import * as admin from "firebase-admin"; // 파이어베이스 관리자

admin.initializeApp(); // 파이어베이스 관리자 초기화

// 비디오 생성시 썸네일 추출기능
export const onVideoCreated = functions.firestore // 파이어베이스 클라우드 함수 생성
.document("videos/{videoId}") // 비디오 컬렉션의 도큐먼트 생성시
.onCreate(async(snapshot,context) => { // 생성시 실행
    const spawn = require('child-process-promise').spawn; // 비디오 썸네일 추출을 위한 라이브러리
    const video = snapshot.data(); // 생성된 비디오 데이터
    await spawn("ffmpeg",[ // ffmpeg 명령어 실행
        "-i", // 입력 파일
        video.videoUrl, // 비디오 URL
        "-ss", // 스냅샷을 찍을 시간
        "00:00:01.000", // 1초부터
        "-vframes", // 비디오 프레임 추출
        "1", // 1프레임만 추출
        "-vf", // 비디오 필터
        "scale=150:-1", // 150픽셀로 줄임
        `/tmp/${snapshot.id}.jpg` // 임시저장 파일명(구글 클라우드 서버에서 코드가 동작할 동안 임시 파일 저장소 'tmp'에 저장됨)
    ]);
    const storage = admin.storage(); // 구글 클라우드 스토리지
    const [file, _] = await storage.bucket().upload(`/tmp/${snapshot.id}.jpg`, { // 임시저장 파일을 구글 클라우드 스토리지에 업로드
        destination: `thumbnails/${snapshot.id}.jpg`, // 썸네일 저장 경로
    });
    await file.makePublic(); // 썸네일 파일을 공개로 설정
    await snapshot.ref.update({thumbnailUrl: file.publicUrl()}); // 생성된 비디오 도큐먼트에 썸네일 URL 추가
    const db = admin.firestore();

    await db.collection("users") // 유저의 비디오 컬렉션에 썸네일 URL 추가
    .doc(video.creatorUid) // 유저의 UID
    .collection("videos") // 비디오 컬렉션
    .doc(snapshot.id) // 비디오 ID
    .set({
        thumbnailUrl: file.publicUrl(), 
        videoId: snapshot.id}); // 썸네일 URL과 비디오 ID 추가
});


// '좋아요'를 눌렀을 때(생성)
export const onLikedCreated = functions.firestore
.document("likes/{likeId}") // 'likes' 컬렉션의 도큐먼트 생성시
.onCreate(async(snapshot, context) => {
    const db = admin.firestore();
    const [videoId, userId] = snapshot.id.split("000"); // 좋아요 도큐먼트 ID에서 비디오 ID와 유저 ID 추출

    await db.collection("users").doc(userId).collection("likes").doc(videoId).set({liked:true}); // 좋아요한 비디오를 유저의 'likes' 컬렉션에 추가

    await db.collection("videos").doc(videoId).update({ // 비디오의 'likes' 필드를 1 증가
        likes:admin.firestore.FieldValue.increment(1)
    })
});

// '좋아요'를 눌렀을 때(삭제)
export const onLikedRemoved = functions.firestore
.document("likes/{likeId}") // 'likes' 컬렉션의 도큐먼트 삭제시
.onDelete(async(snapshot, context) => {
    const db = admin.firestore(); // 파이어베이스 관리자
    const [videoId, userId] = snapshot.id.split("000"); // 좋아요 도큐먼트 ID에서 비디오 ID와 유저 ID 추출

    await db.collection("users").doc(userId).collection("likes").doc(videoId).delete(); // 유저의 'likes' 컬렉션에서 좋아요한 비디오 삭제
    await db.collection("videos").doc(videoId).update({
        likes:admin.firestore.FieldValue.increment(-1) // 비디오의 'likes' 필드를 1 감소
    })
});