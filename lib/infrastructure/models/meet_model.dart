import 'package:app_tasking/infrastructure/models/agenda_model.dart';
import 'package:app_tasking/infrastructure/models/participants_model.dart';

class MeetModel {
  final String? reunionId;
  final String? reunionTitulo;
  final String? reunionAsunto;
  final String? reunionModalidad;
  final String? reunionLugar;
  final String? reunionClase;
  final String? reunionGrupoPro;
  final String? reuniomAreaConoci;
  final String? reunionClienteId;
  final String? reunionClienteNombre;
  final String? reunionProyectoId;
  final String? reunionProyectoNombre;
  final DateTime? reunionFecha;
  final String? reunionHoraIni;
  final int? reunionTotalHoras;
  final int? reunionMinutos;
  final String? reunionConvocanteId;
  final String? reunionConvocanteNom;
  final String? reunionParticipantes;
  final int? reunionCampoNum01;
  final int? reunionCampoNum02;
  final String? reunionFec01;
  final String? reunionFec02;
  final String? reunionText01;
  final String? reunionText02;
  final String? reunionText03;
  final String? reunionText04;
  final String? reunionText05;
  final String? reunionText06;
  final String? reunionText07;
  final String? reunionFec03;
  final ParticipantsModel? reunionesSdtListPerProSer;
  final int? datefilter;
  final int? reunionQuantityChildrend;
  final List<AgendaModel>? renDet;
  final String? reunionOldestDate;
  final String? reunionNewestDate;
  final String? reunionStateMeet;
  final bool? reunionStateGen;
  final String? personalId;
  final String? reunionMainId;

  MeetModel({
    this.reunionId,
    this.reunionTitulo,
    this.reunionAsunto,
    this.reunionModalidad,
    this.reunionLugar,
    this.reunionClase,
    this.reunionGrupoPro,
    this.reuniomAreaConoci,
    this.reunionClienteId,
    this.reunionClienteNombre,
    this.reunionProyectoId,
    this.reunionProyectoNombre,
    this.reunionFecha,
    this.reunionHoraIni,
    this.reunionTotalHoras,
    this.reunionMinutos,
    this.reunionConvocanteId,
    this.reunionConvocanteNom,
    this.reunionParticipantes,
    this.reunionCampoNum01,
    this.reunionCampoNum02,
    this.reunionFec01,
    this.reunionFec02,
    this.reunionText01,
    this.reunionText02,
    this.reunionText03,
    this.reunionText04,
    this.reunionText05,
    this.reunionText06,
    this.reunionText07,
    this.reunionFec03,
    this.reunionesSdtListPerProSer,
    this.datefilter,
    this.renDet,
    this.reunionQuantityChildrend,
    this.reunionOldestDate,
    this.reunionNewestDate,
    this.reunionStateMeet,
    this.reunionStateGen,
    this.personalId,
    this.reunionMainId
  });

  factory MeetModel.fromJson(Map<String, dynamic> json) => MeetModel(
        reunionId: json["ReunionId"],
        reunionTitulo: json["ReunionTitulo"],
        reunionAsunto: json["ReunionAsunto"],
        reunionModalidad: json["ReunionModalidad"],
        reunionLugar: json["ReunionLugar"],
        reunionClase: json["ReunionClase"],
        reunionGrupoPro: json["ReunionGrupoPro"],
        reuniomAreaConoci: json["ReuniomAreaConoci"],
        reunionClienteId: json["ReunionClienteId"],
        reunionClienteNombre: json["ReunionClienteNombre"],
        reunionProyectoId: json["ReunionProyectoId"],
        reunionProyectoNombre: json["ReunionProyectoNombre"],
        reunionFecha: json["ReunionFecha"] == null
            ? null
            : DateTime.parse(json["ReunionFecha"]),
        reunionHoraIni: json["ReunionHoraIni"],
        reunionTotalHoras: json["ReunionTotalHoras"],
        reunionMinutos: json["ReunionMinutos"],
        reunionConvocanteId: json["ReunionConvocanteId"],
        reunionConvocanteNom: json["ReunionConvocanteNom"],
        reunionParticipantes: json["ReunionParticipantes"],
        reunionCampoNum01: json["ReunionCampoNum01"],
        reunionCampoNum02: json["ReunionCampoNum02"],
        reunionFec01: json["ReunionFec01"],
        reunionFec02: json["ReunionFec02"],
        reunionText01: json["ReunionText01"],
        reunionText02: json["ReunionText02"],
        reunionText03: json["ReunionText03"],
        reunionText04: json["ReunionText04"],
        reunionText05: json["ReunionText05"],
        reunionText06: json["ReunionText06"],
        reunionText07: json["ReunionText07"],
        reunionFec03: json["ReunionFec03"],
        reunionQuantityChildrend: json["ReunionQuantityChildrend"],
        reunionesSdtListPerProSer: json["ReunionesSDTListPerProSer"] == null
            ? null
            : ParticipantsModel.fromJson(json["ReunionesSDTListPerProSer"]),
        renDet: json["RenDet"] == null
            ? []
            : List<AgendaModel>.from(
                json["RenDet"]!.map((x) => AgendaModel.fromJson(x))),
        reunionOldestDate: json["ReunionOldestDate"],
        reunionNewestDate: json["ReunionNewestDate"],
        reunionStateMeet: json["ReunionStateMeet"],
        reunionStateGen: json["ReunionState"],
        reunionMainId: json["ReunionMainId"],
      );

  Map<String, dynamic> toJson() => {
        "ReunionId": reunionId,
        "ReunionTitulo": reunionTitulo,
        "ReunionAsunto": reunionAsunto,
        "ReunionModalidad": reunionModalidad,
        "ReunionLugar": reunionLugar,
        "ReunionClase": reunionClase,
        "ReunionGrupoPro": reunionGrupoPro,
        "ReuniomAreaConoci": reuniomAreaConoci,
        "ReunionClienteId": reunionClienteId,
        "ReunionClienteNombre": reunionClienteNombre,
        "ReunionProyectoId": reunionProyectoId,
        "ReunionProyectoNombre": reunionProyectoNombre,
        "ReunionFecha": reunionFecha == null
            ? null
            : "${reunionFecha!.year.toString().padLeft(4, '0')}-${reunionFecha!.month.toString().padLeft(2, '0')}-${reunionFecha!.day.toString().padLeft(2, '0')}",
        "ReunionHoraIni": reunionHoraIni,
        "ReunionTotalHoras": reunionTotalHoras,
        "ReunionMinutos": reunionMinutos,
        "ReunionConvocanteId": reunionConvocanteId,
        "ReunionConvocanteNom": reunionConvocanteNom,
        "ReunionParticipantes": reunionParticipantes,
        "ReunionCampoNum01": reunionCampoNum01,
        "ReunionCampoNum02": reunionCampoNum02,
        "ReunionFec01": reunionFec01,
        "ReunionFec02": reunionFec02,
        "ReunionText01": reunionText01,
        "ReunionText02": reunionText02,
        "ReunionText03": reunionText03,
        "ReunionText04": reunionText04,
        "ReunionText05": reunionText05,
        "ReunionText06": reunionText06,
        "ReunionText07": reunionText07,
        "ReunionFec03": reunionFec03,
        "ReunionesSDTListPerProSer": reunionesSdtListPerProSer?.toJson(),
        "datefilter": datefilter,
        "RenDet": renDet == null
            ? []
            : List<dynamic>.from(renDet!.map((x) => x.toJson())),
        "PersonalId": personalId
      };
}
