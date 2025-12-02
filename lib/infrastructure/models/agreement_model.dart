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
  final String? projectId;
  final String? taskId;
  final String? areaId;
  final String? areaName;

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
    this.projectId,
    this.taskId,
    this.areaId,
    this.areaName,
  });

  factory AgreementModel.fromJson(Map<String, dynamic> json) => AgreementModel(
        agreementId: json["agreementId"],
        reunionId: json["reunionId"],
        agendaId: json["agendaId"],
        agreement: json["agreement"],
        type: json["type"],
        responsibleId: json["responsibleId"],
        responsibleFullNames: json["responsibleFullNames"],
        dateCreation: json["dateCreation"],
        dateLimit: json["dateLimit"],
        privacity: json["privacity"],
        projectId: json["projectId"],
        taskId: json["taskId"],
        areaId: json["areaId"],
        areaName: json["areaName"],
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
        "projectId": projectId,
        "taskId": taskId,
        "areaId": areaId,
        "areaName": areaName,
      };
}
