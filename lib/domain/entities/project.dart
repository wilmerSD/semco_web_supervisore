
class Project {
  String? id;
  String? campanaid;
  String? companiaid;
  String? clienteid;
  String? clienteNombre;
  String? campanaNombre;
  String? campanaEstado;
  String? responsableNombre;
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

  Project({
    this.id,
    this.campanaid,
    this.companiaid,
    this.clienteid,
    this.clienteNombre,
    this.campanaNombre,
    this.campanaEstado,
    this.responsableNombre,
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
  });

  factory Project.fromJson(Map<String, dynamic> json) => Project(
        id: json["id"],
        campanaid: json["campanaid"],
        companiaid: json["companiaid"],
        clienteid: json["clienteid"],
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
}