import 'package:app_tasking/infrastructure/models/agenda_model.dart';

class ResponseAgenda {
    bool success;
    int? statusCode;
    String? statusMessage;
    List<AgendaModel>? data;

    ResponseAgenda({
        required this.success,
        this.statusCode,
        this.statusMessage,
        this.data,
    });

    factory ResponseAgenda.fromJson(Map<String, dynamic> json) => ResponseAgenda(
        success: json["success"],
        statusCode: json["statusCode"],
        statusMessage: json["statusMessage"],
        data: json["data"] == null ? [] : List<AgendaModel>.from(json["data"]!.map((x) => AgendaModel.fromJson(x))),
    );

}

