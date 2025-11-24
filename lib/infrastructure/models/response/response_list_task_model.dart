import 'package:app_tasking/infrastructure/models/task_model.dart';

class ResponseListTaskModel {
  bool success;
  int? statusCode;
  String? statusMessage;
  List<TaskModel>? data;

  ResponseListTaskModel({
    required this.success,
    this.statusCode,
    this.statusMessage,
    this.data,
  });

  factory ResponseListTaskModel.fromJson(Map<String, dynamic> json) =>
      ResponseListTaskModel(
        success: json["success"],
        statusCode: json["statusCode"],
        statusMessage: json["statusMessage"],
        data: json["data"] == null
            ? []
            : List<TaskModel>.from(
                json["data"]!.map((x) => TaskModel.fromJson(x))),
      );
}
/* 
class DataListTask {
  String? id;
  String? ordenProduccionId;
  String? campanaId;
  String? companiaId;
  String? clienteId;
  String? ordenProduccionTrabajoRealizar;
  String? ordenProdCampanaName;
  String? ordenDetalle;
  String? ordenFechaInicio;
  String? ordenFechaFin;
  String? ordenFechaFinReal;
  String? ordenSupervisorId;
  String? ordenResponsableId;
  String? ordenSupervisorFullNames;
  String? ordenResponsableFullNames;
  int? ordenAvance;
  String? ordenProEstado;
  String? ordenCampo3;
  String? ordenPrioridad;
  String? ordenClientName;
  int? ordenNumberNewComment;
  String? ordenFirstParticipantId;
  String? ordenFirstParticipantFullName;
  String? ordenSecondParticipantId;
  String? ordenSecondParticipantFullName;
  String? ordenResponsablePhoto;
  String? ordenSupervisorPhoto;
  String? ordenFirstParticipantPhoto;
  String? ordenSecondParticipantPhoto;
  int? ordenIndex;


  DataListTask({
    this.id,
    this.ordenProduccionId,
    this.campanaId,
    this.companiaId,
    this.clienteId,
    this.ordenProduccionTrabajoRealizar,
    this.ordenProdCampanaName,
    this.ordenDetalle,
    this.ordenFechaInicio,
    this.ordenFechaFin,
    this.ordenFechaFinReal,
    this.ordenSupervisorId,
    this.ordenResponsableId,
    this.ordenSupervisorFullNames,
    this.ordenResponsableFullNames,
    this.ordenAvance,
    this.ordenProEstado,
    this.ordenCampo3,
    this.ordenPrioridad,
    this.ordenClientName,
    this.ordenNumberNewComment,
    this.ordenFirstParticipantId,
    this.ordenFirstParticipantFullName,
    this.ordenSecondParticipantId,
    this.ordenSecondParticipantFullName,
    this.ordenResponsablePhoto,
    this.ordenSupervisorPhoto,
    this.ordenFirstParticipantPhoto,
    this.ordenSecondParticipantPhoto,
    this.ordenIndex,
  });

  factory DataListTask.fromJson(Map<String, dynamic> json) => DataListTask(
        id: json["id"],
        ordenProduccionId: json["OrdenProduccionId"],
        campanaId: json["CampanaId"],
        companiaId: json["CompaniaId"],
        clienteId: json["ClienteId"],
        ordenProduccionTrabajoRealizar: json["OrdenProduccionTrabajoRealizar"],
        ordenProdCampanaName: json["OrdenProdCampanaName"],
        ordenDetalle: json["OrdenDetalle"],
        ordenFechaInicio: json["OrdenFechaInicio"],
        ordenFechaFin: json["OrdenFechaFin"],
        ordenFechaFinReal: json["OrdenFechaFinReal"],
        ordenSupervisorId: json["OrdenSupervisorId"],
        ordenResponsableId: json["OrdenResponsableId"],
        ordenSupervisorFullNames: json["OrdenSupervisorFullNames"],
        ordenResponsableFullNames: json["OrdenResponsableFullNames"],
        ordenAvance: json["OrdenAvance"],
        ordenProEstado: json["OrdenProEstado"],
        ordenCampo3: json["OrdenCampo3"],
        ordenPrioridad: json["OrdenPrioridad"],
        ordenClientName: json["OrdenClientName"],
        ordenNumberNewComment: json["OrdenNumberNewComment"],
        ordenFirstParticipantId: json["OrdenFirstParticipantId"],
        ordenFirstParticipantFullName: json["OrdenFirstParticipantFullName"],
        ordenSecondParticipantId: json["OrdenSecondParticipantId"],
        ordenSecondParticipantFullName: json["OrdenSecondParticipantFullName"],
        ordenResponsablePhoto: json["OrdenResponsablePhoto"],
        ordenSupervisorPhoto: json["OrdenSupervisorPhoto"],
        ordenFirstParticipantPhoto: json["OrdenFirstParticipantPhoto"],
        ordenSecondParticipantPhoto: json["OrdenSecondParticipantPhoto"],
        ordenIndex: json["OrdenIndex"],
      );
  Map<String, dynamic> toJson() => {
        "OrdenProduccionId": ordenProduccionId,
        "index": ordenIndex,
      };
}
 */