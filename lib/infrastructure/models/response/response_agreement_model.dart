import 'package:app_tasking/infrastructure/models/agreement_model.dart';

class ResponseAgreementModel {
    final bool? success;
    final int? statusCode;
    final String? statusMessage;
    final List<AgreementModel>? data;

    ResponseAgreementModel({
        this.success,
        this.statusCode,
        this.statusMessage,
        this.data,
    });

    factory ResponseAgreementModel.fromJson(Map<String, dynamic> json) => ResponseAgreementModel(
        success: json["success"],
        statusCode: json["statusCode"],
        statusMessage: json["statusMessage"],
        data: json["data"] == null ? [] : List<AgreementModel>.from(json["data"]!.map((x) => AgreementModel.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "statusCode": statusCode,
        "statusMessage": statusMessage,
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    };
}

