
class AgendaModel {
    final String? reunionId;
    final int? reunDetId;
    final String? reunDetTitulo;
    final String? reunDetTipo;
    final String? reunDetAsociado;
    final String? reunDetResponsableId;
    final String? reunDetResponsableNom;
    final DateTime? reunDetFecha;
    final int? reunDetNum01;
    final int? reunDetNum02;
    final String? reunDetText01;
    final String? reunDetText02;
    final String? reunDetText03;
    final String? reunDetText04;

    AgendaModel({
        this.reunionId,
        this.reunDetId,
        this.reunDetTitulo,
        this.reunDetTipo,
        this.reunDetAsociado,
        this.reunDetResponsableId,
        this.reunDetResponsableNom,
        this.reunDetFecha,
        this.reunDetNum01,
        this.reunDetNum02,
        this.reunDetText01,
        this.reunDetText02,
        this.reunDetText03,
        this.reunDetText04,
    });

    factory AgendaModel.fromJson(Map<String, dynamic> json) => AgendaModel(
        reunionId: json["reunionId"], //Revisar si viene asi
        reunDetId: json["agendaId"],
        reunDetTitulo: json["tittle"],
        reunDetTipo: json["type"],
        reunDetAsociado: json["associatedTypeName"],
        reunDetResponsableId: json["responsibleId"],
        reunDetResponsableNom: json["responsibleNames"],
        reunDetFecha: json["dateCreation"] == null ? null : DateTime.parse(json["dateCreation"]),
        reunDetNum01: json["ReunDetNum01"],
        reunDetNum02: json["ReunDetNum02"],
        reunDetText01: json["associatedTypeId"],
        reunDetText02: json["expectedResult"],
        reunDetText03: json["ReunDetText03"],
        reunDetText04: json["ReunDetText04"],
    );

    Map<String, dynamic> toJson() => {
        "ReunDetId": reunDetId,
        "ReunDetTitulo": reunDetTitulo,
        "ReunDetTipo": reunDetTipo,
        "ReunDetAsociado": reunDetAsociado,
        "ReunDetResponsableId": reunDetResponsableId,
        "ReunDetResponsableNom": reunDetResponsableNom,
        "ReunDetFecha": "${reunDetFecha!.year.toString().padLeft(4, '0')}-${reunDetFecha!.month.toString().padLeft(2, '0')}-${reunDetFecha!.day.toString().padLeft(2, '0')}",
        "ReunDetNum01": reunDetNum01,
        "ReunDetNum02": reunDetNum02,
        "ReunDetText01": reunDetText01,
        "ReunDetText02": reunDetText02,
        "ReunDetText03": reunDetText03,
        "ReunDetText04": reunDetText04,
    };
}