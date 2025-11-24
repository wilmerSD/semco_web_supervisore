import 'package:app_tasking/infrastructure/models/area_model.dart';

class ResponseAreaModel {
    bool success;
    int? statusCode;
    String? statusMessage;
    List<AreaModel>? data;

    ResponseAreaModel({
        required this.success,
        this.statusCode,
        this.statusMessage,
        this.data,
    });

    factory ResponseAreaModel.fromJson(Map<String, dynamic> json) => ResponseAreaModel(
        success: json["success"],
        statusCode: json["statusCode"],
        statusMessage: json["statusMessage"],
        data: json["data"] == null ? [] : List<AreaModel>.from(json["data"]!.map((x) => AreaModel.fromJson(x))),
    );

}

