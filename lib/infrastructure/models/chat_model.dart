class ChatModel {
    String? chatName;
    String? chatPhoto;
    String? chatLastMessage;

    ChatModel({
        this.chatName,
        this.chatPhoto,
        this.chatLastMessage,
    });

    factory ChatModel.fromJson(Map<String, dynamic> json) => ChatModel(
        chatName: json["ChatName"],
        chatPhoto: json["ChatPhoto"],
        chatLastMessage: json["ChatLastMessage"],
    );
}