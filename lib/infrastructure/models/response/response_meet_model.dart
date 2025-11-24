import 'package:app_tasking/infrastructure/models/meet_model.dart';

class ResponseMeetModel {
    final bool? success;
    final int? statusCode;
    final String? statusMessage;
    final List<MeetModel>? data;

    ResponseMeetModel({
        this.success,
        this.statusCode,
        this.statusMessage,
        this.data,
    });

    factory ResponseMeetModel.fromJson(Map<String, dynamic> json) => ResponseMeetModel(
        success: json["success"],
        statusCode: json["statusCode"],
        statusMessage: json["statusMessage"],
        data: json["data"] == null ? [] : List<MeetModel>.from(json["data"]!.map((x) => MeetModel.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "statusCode": statusCode,
        "statusMessage": statusMessage,
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    };
}

