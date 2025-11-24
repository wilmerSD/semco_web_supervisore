class ProjectModel {
  String? id;
  String? personalId;
  String? campanaId;
  String? companiaId;
  String? clienteId;
  String? clienteNombre;
  String? campanaNombre;
  String? campanaEstado;
  String? responsibleId;
  String? responsableNombre;
  String? supervisorId;
  String? supervisorNombre;
  String? campanaFechaInicio;
  String? campanaFechaFin;
  String? campanaEstados;
  String? campanaAvance;
  int? numberNewTask;
  int? numberNewComments;
  int? numberNewNotes;
  int? numberNewReports;
  int? numberTask;
  String? firstParticipantId;
  String? secondParticipantId;
  String? firstParticipantFullName;
  String? secondParticipantFullName;
  String? responsablePhoto;
  String? supervisorPhoto;
  String? firstParticipantPhoto;
  String? secondParticipantPhoto;
  String? estado;
  int? anio;
  bool? state;
  String? search;

  ProjectModel({
    this.id,
    this.personalId,
    this.campanaId,
    this.companiaId,
    this.clienteId,
    this.clienteNombre,
    this.campanaNombre,
    this.campanaEstado,
    this.responsableNombre,
    this.supervisorId,
    this.supervisorNombre,
    this.campanaFechaInicio,
    this.campanaFechaFin,
    this.campanaEstados,
    this.campanaAvance,
    this.numberNewTask,
    this.numberNewComments,
    this.numberNewNotes,
    this.numberNewReports,
    this.numberTask,
    this.firstParticipantId,
    this.secondParticipantId,
    this.firstParticipantFullName,
    this.secondParticipantFullName,
    this.responsablePhoto,
    this.supervisorPhoto,
    this.firstParticipantPhoto,
    this.secondParticipantPhoto,
    this.anio,
    this.estado,
    this.state,
    this.search,
  });

  factory ProjectModel.fromJson(Map<String, dynamic> json) => ProjectModel(
        id: json["id"],
        campanaId: json["campanaid"],
        companiaId: json["companiaid"],
        clienteId: json["clienteid"],
        clienteNombre: json["ClienteNombre"],
        campanaNombre: json["CampanaNombre"],
        campanaEstado: json["CampanaEstado"],
        responsableNombre: json["ResponsableNombre"],
        supervisorNombre: json["SupervisorNombre"],
        campanaFechaInicio: json["CampanaFechaInicio"],
        campanaFechaFin: json["CampanaFechaFin"],
        campanaEstados: json["CampanaEstados"],
        campanaAvance: json["CampanaAvance"],
        numberNewTask: json["NumberNewTask"],
        numberNewComments: json["NumberNewComments"],
        numberNewNotes: json["NumberNewNotes"],
        numberNewReports: json["NumberNewReports"],
        numberTask: json["NumberTask"],
        firstParticipantId: json["FirstParticipantId"],
        secondParticipantId: json["SecondParticipantId"],
        firstParticipantFullName: json["FirstParticipantFullName"],
        secondParticipantFullName: json["SecondParticipantFullName"],
        responsablePhoto: json["ResponsablePhoto"],
        supervisorPhoto: json["SupervisorPhoto"],
        firstParticipantPhoto: json["FirstParticipantPhoto"],
        secondParticipantPhoto: json["SecondParticipantPhoto"],
      );

  Map<String, dynamic> toJson() => {
        "Ipersonalid": personalId,
        "IcampanaId": campanaId,
        "IclienteId": clienteId,
        "IcompaniaId": companiaId,
        "Isupervisorid": supervisorId,
        "Iresponsable": responsableNombre,
        "Ianio": anio,
        "Iestado": state,
        "Ifechafin": campanaFechaFin,
        "Ibuscar": search,
      };
}
