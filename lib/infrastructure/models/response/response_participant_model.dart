import 'package:app_tasking/infrastructure/models/participant_model.dart';

class ResponseParticipantModel {
    final bool? success;
    final int? statusCode;
    final String? statusMessage;
    final List<ParticipantModel>? data;

    ResponseParticipantModel({
        this.success,
        this.statusCode,
        this.statusMessage,
        this.data,
    });

    factory ResponseParticipantModel.fromJson(Map<String, dynamic> json) => ResponseParticipantModel(
        success: json["success"],
        statusCode: json["statusCode"],
        statusMessage: json["statusMessage"],
        data: json["data"] == null ? [] : List<ParticipantModel>.from(json["data"]!.map((x) => ParticipantModel.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "statusCode": statusCode,
        "statusMessage": statusMessage,
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    };
}
