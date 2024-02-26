class VideoModel {
  final String id;
  final String title;
  final String description;
  final String videoUrl;
  final String thumbnailUrl;
  final int likes;
  final int comments;
  final String creatorUid;
  final String creator;
  final int createdAt;

  VideoModel({
    required this.id,
    required this.title,
    required this.description,
    required this.videoUrl,
    required this.thumbnailUrl,
    required this.likes,
    required this.comments,
    required this.creatorUid,
    required this.createdAt,
    required this.creator,
  });

  VideoModel.fromJson(
      {required Map<String, dynamic> json, required String videoId})
      : id = videoId,
        title = json['title'],
        description = json['description'],
        videoUrl = json['videoUrl'],
        thumbnailUrl = json['thumbnailUrl'],
        likes = json['likes'],
        comments = json['comments'],
        creatorUid = json['creatorUid'],
        createdAt = json['createdAt'],
        creator = json['creator'];

  Map<String, dynamic> toJson() {
    return {
      "id": id, // "id": "1
      "title": title,
      "description": description,
      "videoUrl": videoUrl,
      "thumbnailUrl": thumbnailUrl,
      "likes": likes,
      "comments": comments,
      "creatorUid": creatorUid,
      "createdAt": createdAt,
      "creator": creator,
    };
  }
}
