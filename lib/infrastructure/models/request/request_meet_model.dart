import 'package:app_tasking/infrastructure/models/agenda_model.dart';
import 'package:app_tasking/infrastructure/models/meet_model.dart';

class RequestMeetModel {
    final MeetModel? iSdtReuniones;

    RequestMeetModel({
        this.iSdtReuniones,
    });

    factory RequestMeetModel.fromJson(Map<String, dynamic> json) => RequestMeetModel(
        iSdtReuniones: json["iSdtReuniones"] == null ? null : MeetModel.fromJson(json["iSdtReuniones"]),
    );

    Map<String, dynamic> toJson() => {
        "iSdtReuniones": iSdtReuniones?.toJson(),
    };
}

class ISdtReuniones {
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
    final ReunionesSdtListPerProSer? reunionesSdtListPerProSer;
    final List<AgendaModel>? renDet;

    ISdtReuniones({
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
        this.renDet,
    });

    factory ISdtReuniones.fromJson(Map<String, dynamic> json) => ISdtReuniones(
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
        reunionFecha: json["ReunionFecha"] == null ? null : DateTime.parse(json["ReunionFecha"]),
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
        reunionesSdtListPerProSer: json["ReunionesSDTListPerProSer"] == null ? null : ReunionesSdtListPerProSer.fromJson(json["ReunionesSDTListPerProSer"]),
        renDet: json["RenDet"] == null ? [] : List<AgendaModel>.from(json["RenDet"]!.map((x) => AgendaModel.fromJson(x))),
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
        "ReunionFecha": "${reunionFecha!.year.toString().padLeft(4, '0')}-${reunionFecha!.month.toString().padLeft(2, '0')}-${reunionFecha!.day.toString().padLeft(2, '0')}",
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
        "RenDet": renDet == null ? [] : List<dynamic>.from(renDet!.map((x) => x.toJson())),
    };
}


class ReunionesSdtListPerProSer {
    final String? ordenProduccionId;
    final String? clienteId;
    final int? ordenAvaPor;
    final List<ListProSer>? listProSer;
    final List<ListaPer>? listaPer;

    ReunionesSdtListPerProSer({
        this.ordenProduccionId,
        this.clienteId,
        this.ordenAvaPor,
        this.listProSer,
        this.listaPer,
    });

    factory ReunionesSdtListPerProSer.fromJson(Map<String, dynamic> json) => ReunionesSdtListPerProSer(
        ordenProduccionId: json["OrdenProduccionId"],
        clienteId: json["ClienteId"],
        ordenAvaPor: json["OrdenAvaPor"],
        listProSer: json["ListProSer"] == null ? [] : List<ListProSer>.from(json["ListProSer"]!.map((x) => ListProSer.fromJson(x))),
        listaPer: json["ListaPer"] == null ? [] : List<ListaPer>.from(json["ListaPer"]!.map((x) => ListaPer.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "OrdenProduccionId": ordenProduccionId,
        "ClienteId": clienteId,
        "OrdenAvaPor": ordenAvaPor,
        "ListProSer": listProSer == null ? [] : List<dynamic>.from(listProSer!.map((x) => x.toJson())),
        "ListaPer": listaPer == null ? [] : List<dynamic>.from(listaPer!.map((x) => x.toJson())),
    };
}

class ListProSer {
    final int? numb;
    final String? tipoProductoServicioId;
    final String? tipoProductoServicioNombre;
    final String? tipoFecha;
    final int? tipCheck;

    ListProSer({
        this.numb,
        this.tipoProductoServicioId,
        this.tipoProductoServicioNombre,
        this.tipoFecha,
        this.tipCheck,
    });

    factory ListProSer.fromJson(Map<String, dynamic> json) => ListProSer(
        numb: json["Numb"],
        tipoProductoServicioId: json["TipoProductoServicioId"],
        tipoProductoServicioNombre: json["TipoProductoServicioNombre"],
        tipoFecha: json["TipoFecha"],
        tipCheck: json["TipCheck"],
    );

    Map<String, dynamic> toJson() => {
        "Numb": numb,
        "TipoProductoServicioId": tipoProductoServicioId,
        "TipoProductoServicioNombre": tipoProductoServicioNombre,
        "TipoFecha": tipoFecha,
        "TipCheck": tipCheck,
    };
}

class ListaPer {
    final int? numa;
    final String? personalId;
    final String? personalNombres;
    final int? siEmail;
    final int? viato;
    final String? campo01;
    final String? campo02;
    final String? campo03;

    ListaPer({
        this.numa,
        this.personalId,
        this.personalNombres,
        this.siEmail,
        this.viato,
        this.campo01,
        this.campo02,
        this.campo03,
    });

    factory ListaPer.fromJson(Map<String, dynamic> json) => ListaPer(
        numa: json["Numa"],
        personalId: json["PersonalId"],
        personalNombres: json["PersonalNombres"],
        siEmail: json["siEmail"],
        viato: json["Viato"],
        campo01: json["Campo01"],
        campo02: json["Campo02"],
        campo03: json["Campo03"],
    );

    Map<String, dynamic> toJson() => {
        "Numa": numa,
        "PersonalId": personalId,
        "PersonalNombres": personalNombres,
        "siEmail": siEmail,
        "Viato": viato,
        "Campo01": campo01,
        "Campo02": campo02,
        "Campo03": campo03,
    };
}