import 'package:app_tasking/infrastructure/models/project_model.dart';

class ResponseListProyectsModel {
  bool? success;
  int? statusCode;
  String? statusMessage;
  List<ProjectModel>? data;

  ResponseListProyectsModel({
    this.success,
    this.statusCode,
    this.statusMessage,
    this.data,
  });

  factory ResponseListProyectsModel.fromJson(Map<String, dynamic> json) =>
      ResponseListProyectsModel(
        success: json["success"],
        statusCode: json["statusCode"],
        statusMessage: json["statusMessage"],
        data: json["data"] == null
            ? []
            : List<ProjectModel>.from(
                json["data"]!.map((x) => ProjectModel.fromJson(x))),
      );
}
