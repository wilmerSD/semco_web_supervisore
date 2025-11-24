class ParticipantsModel {
    final String? ordenProduccionId;
    final String? clienteId;
    final int? ordenAvaPor;
    final List<ListProSer>? listProSer;
    final List<ListaPer>? listaPer;

    ParticipantsModel({
        this.ordenProduccionId,
        this.clienteId,
        this.ordenAvaPor,
        this.listProSer,
        this.listaPer,
    });

    factory ParticipantsModel.fromJson(Map<String, dynamic> json) => ParticipantsModel(
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