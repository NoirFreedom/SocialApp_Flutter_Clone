class MessageModel {
  final String text;
  final String userId;
  final String chatRoomId;
  final int createdAt;

  MessageModel({
    required this.text,
    required this.userId,
    required this.chatRoomId,
    required this.createdAt,
  });

  MessageModel.fromJson(Map<String, dynamic> json)
      : text = json['text'],
        userId = json['userId'],
        chatRoomId = json['chatRoomId'],
        createdAt = json['createdAt'];

  Map<String, dynamic> toJson() {
    return {
      'text': text,
      'userId': userId,
      'chatRoomId': chatRoomId,
      'createdAt': createdAt,
    };
  }
}
