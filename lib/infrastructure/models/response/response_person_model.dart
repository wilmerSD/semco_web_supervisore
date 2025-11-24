import 'package:app_tasking/infrastructure/models/person_model.dart';

class ResponsePersonModel {
    bool success;
    int? statusCode;
    String? statusMessage;
    List<PersonModel>? data;

    ResponsePersonModel({
        required this.success,
        this.statusCode,
        this.statusMessage,
        this.data,
    });

    factory ResponsePersonModel.fromJson(Map<String, dynamic> json) => ResponsePersonModel(
        success: json["success"],
        statusCode: json["statusCode"],
        statusMessage: json["statusMessage"],
        data: json["data"] == null ? [] : List<PersonModel>.from(json["data"]!.map((x) => PersonModel.fromJson(x))),
    );
}
