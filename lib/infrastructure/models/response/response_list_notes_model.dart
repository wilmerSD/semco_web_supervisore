import 'package:app_tasking/infrastructure/models/note_model.dart';

class ResponseListNotesModel {
    bool success;
    int? statusCode;
    String? statusMessage;
    List<NoteModel>? data;

    ResponseListNotesModel({
        required this.success,
        this.statusCode,
        this.statusMessage,
        this.data,
    });

    factory ResponseListNotesModel.fromJson(Map<String, dynamic> json) => ResponseListNotesModel(
        success: json["success"],
        statusCode: json["statusCode"],
        statusMessage: json["statusMessage"],
        data: json["data"] == null ? [] : List<NoteModel>.from(json["data"]!.map((x) => NoteModel.fromJson(x))),
    );
}
