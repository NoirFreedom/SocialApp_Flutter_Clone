// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:TikTok/features/videos/models/video_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group("VideoModel Test", () {
    test("Constructor", () {
      final video = VideoModel(
          id: "id",
          title: "title",
          description: "description",
          videoUrl: "videoUrl",
          thumbnailUrl: "thumbnailUrl",
          likes: 1,
          comments: 1,
          creatorUid: "creatorUid",
          createdAt: 1,
          creator: "creator");
      expect(video.id, "id");
    });
    test(".fromJson Constructor", () {
      final video = VideoModel.fromJson(json: {
        "id": "id",
        "title": "title",
        "description": "description",
        "videoUrl": "videoUrl",
        "thumbnailUrl": "thumbnailUrl",
        "likes": 1,
        "comments": 1,
        "creatorUid": "creatorUid",
        "createdAt": 1,
        "creator": "creator"
      }, videoId: "videoId");
      expect(video.title, "title");
      expect(video.comments, isInstanceOf<int>());
    });

    test("toJson Method", () {
      final video = VideoModel(
          id: "id",
          title: "title",
          description: "description",
          videoUrl: "videoUrl",
          thumbnailUrl: "thumbnailUrl",
          likes: 1,
          comments: 1,
          creatorUid: "creatorUid",
          createdAt: 1,
          creator: "creator");
      final json = video.toJson();
      expect(json["id"], "id");
      expect(json["comments"], isInstanceOf<int>());
    });
  });
}
