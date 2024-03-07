class MessageModel {
  final String text;
  final String userId;
  final String chatRoomId;

  MessageModel({
    required this.text,
    required this.userId,
    required this.chatRoomId,
  });

  MessageModel.fromJson(Map<String, dynamic> json)
      : text = json['text'],
        userId = json['userId'],
        chatRoomId = json['chatRoomId'];

  Map<String, dynamic> toJson() {
    return {
      'text': text,
      'userId': userId,
      'chatRoomId': chatRoomId,
    };
  }
}
