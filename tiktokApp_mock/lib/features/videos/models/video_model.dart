class VideoModel {
  final String title;
  final String description;
  final String videoUrl;
  final String thumbnailUrl;
  final int likes;
  final int comments;
  final String creatorUid;
  final String creator;
  final int creatorAt;

  VideoModel({
    required this.title,
    required this.description,
    required this.videoUrl,
    required this.thumbnailUrl,
    required this.likes,
    required this.comments,
    required this.creatorUid,
    required this.creatorAt,
    required this.creator,
  });

  Map<String, dynamic> toJson() {
    return {
      "title": title,
      "description": description,
      "videoUrl": videoUrl,
      "thumbnailUrl": thumbnailUrl,
      "likes": likes,
      "comments": comments,
      "creatorUid": creatorUid,
      "creatorAt": creatorAt,
      "creator": creator,
    };
  }
}
