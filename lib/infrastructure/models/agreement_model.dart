class AgreementModel {
    final String? reunionId;
    final int? agendaId;
    final String? agreementId;
    final String? agreement;
    final String? privacity;
    final String? type;
    final String? responsibleId;
    final String? responsibleFullNames;
    final String? dateCreation;
    final String? dateLimit;
    final String? projecAsociatedId;
    final String? taskAsociatedId;

    AgreementModel({
        this.agreement,
        this.type,
        this.responsibleId,
        this.responsibleFullNames,
        this.dateCreation,
        this.dateLimit,
        this.privacity,
        this.reunionId,
        this.agendaId,
        this.agreementId,
        this.projecAsociatedId,
        this.taskAsociatedId,
    });

    factory AgreementModel.fromJson(Map<String, dynamic> json) => AgreementModel(
        agreement: json["agreement"],
        type: json["type"],
        responsibleId: json["responsibleId"],
        responsibleFullNames: json["responsibleFullNames"],
        dateCreation: json["dateCreation"],
        dateLimit: json["dateLimit"],
        privacity: json["privacity"],
        reunionId: json["reunionId"],
        agendaId: json["agendaId"],
        agreementId: json["agreementId"],
    );

    Map<String, dynamic> toJson() => {
        "reunionId": reunionId,
        "agendaId": agendaId,
        "agreement": agreement,
        "type": type,
        "responsibleId": responsibleId,
        "responsibleFullNames": responsibleFullNames,
        "dateLimit": dateLimit,
        "privacity": privacity,
        "agreementId": agreementId,
    };
}