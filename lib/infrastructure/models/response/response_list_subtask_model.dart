class ResponseListSubtaskModel {
  bool success;
  int? statusCode;
  String? statusMessage;
  List<DataListSubtask>? data;

  ResponseListSubtaskModel({
    required this.success,
    this.statusCode,
    this.statusMessage,
    this.data,
  });

  factory ResponseListSubtaskModel.fromJson(Map<String, dynamic> json) =>
      ResponseListSubtaskModel(
        success: json["success"],
        statusCode: json["statusCode"],
        statusMessage: json["statusMessage"],
        data: json["data"] == null
            ? []
            : List<DataListSubtask>.from(
                json["data"]!.map((x) => DataListSubtask.fromJson(x))),
      );
}

class DataListSubtask {
  String? ordenProduccionId;
  String? ordenProduccionTrabajoRealizar;
  String? ordenDetalle;
  String? ordenFechaInicio;
  String? ordenFechaFin;
  String? ordenFechaFinReal;
  String? ordenProdPersonaId;
  String? ordenLiderid;
  String? ordenSupervisorFullNames;
  String? ordenLiderFullNames;
  String? ordenProEstado;
  int? ordenAvance;

  DataListSubtask({
    this.ordenProduccionId,
    this.ordenProduccionTrabajoRealizar,
    this.ordenDetalle,
    this.ordenFechaInicio,
    this.ordenFechaFin,
    this.ordenFechaFinReal,
    this.ordenProdPersonaId,
    this.ordenLiderid,
    this.ordenSupervisorFullNames,
    this.ordenLiderFullNames,
    this.ordenAvance,
    this.ordenProEstado,
  });

  factory DataListSubtask.fromJson(
          Map<String, dynamic> json) =>
      DataListSubtask(
          ordenProduccionId: json["OrdenProduccionId"],
          ordenProduccionTrabajoRealizar:
              json["OrdenProduccionTrabajoRealizar"],
          ordenDetalle: json["OrdenDetalle"],
          ordenFechaInicio: json["OrdenFechaInicio"],
          ordenFechaFin: json["OrdenFechaFin"],
          ordenFechaFinReal: json["OrdenFechaFinReal"],
          ordenProdPersonaId: json["OrdenProdPersonaId"],
          ordenLiderid: json["OrdenLiderid"],
          ordenSupervisorFullNames: json["OrdenSupervisorFullNames"],
          ordenLiderFullNames: json["OrdenLiderFullNames"],
          ordenAvance: json["OrdenAvance"],
          ordenProEstado: json["OrdenProEstado"]);
}
