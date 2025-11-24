import 'package:app_tasking/infrastructure/models/chat_model.dart';

class ResponseListChatsModel {
    bool? succes;
    int? statusCode;
    String? statusMessage;
    List<ChatModel>? data;

    ResponseListChatsModel({
        this.succes,
        this.statusCode,
        this.statusMessage,
        this.data,
    });

    factory ResponseListChatsModel.fromJson(Map<String, dynamic> json) => ResponseListChatsModel(
        succes: json["succes"],
        statusCode: json["statusCode"],
        statusMessage: json["statusMessage"],
        data: json["data"] == null ? [] : List<ChatModel>.from(json["data"]!.map((x) => ChatModel.fromJson(x))),
    );
}
