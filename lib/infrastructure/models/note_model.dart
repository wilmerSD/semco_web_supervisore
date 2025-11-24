class NoteModel {
    String? comeId;
    String? comeTareadId;
    String? comeClienteId;
    String? comeCompaniaId;
    String? comePersonalId;
    String? comePersonaFullNames;
    DateTime? comeDate;
    DateTime? comeTime;
    String? comeComentario;
    int? comeTipo;

    NoteModel({
        this.comeId,
        this.comeTareadId,
        this.comeClienteId,
        this.comeCompaniaId,
        this.comePersonalId,
        this.comePersonaFullNames,
        this.comeDate,
        this.comeTime,
        this.comeComentario,
        this.comeTipo,
    });

    factory NoteModel.fromJson(Map<String, dynamic> json) => NoteModel(
        comeId: json["comeId"],
        comeTareadId: json["ComeTareadId"],
        comeClienteId: json["ComeClienteId"],
        comeCompaniaId: json["ComeCompaniaId"],
        comePersonalId: json["ComePersonalId"],
        comePersonaFullNames: json["ComePersonaFullNames"],
        comeDate: json["ComeDate"] == null ? null : DateTime.parse(json["ComeDate"]),
        comeTime: json["ComeTime"] == null ? null : DateTime.parse(json["ComeTime"]),
        comeComentario: json["ComeComentario"],
        comeTipo: json["ComeTipo"],
    );
}