class AreaModel {
    String? clienteId;
    String? companiaId;
    String? clienteNombre;
    String? clienteRazonSocial;
    String? clienteRuc;
    String? clienteCorreo;

    AreaModel({
        this.clienteId,
        this.companiaId,
        this.clienteNombre,
        this.clienteRazonSocial,
        this.clienteRuc,
        this.clienteCorreo,
    });

    factory AreaModel.fromJson(Map<String, dynamic> json) => AreaModel(
        clienteId: json["ClienteId"],
        companiaId: json["CompaniaId"],
        clienteNombre: json["ClienteNombre"],
        clienteRazonSocial: json["ClienteRazonSocial"],
        clienteRuc: json["ClienteRuc"],
        clienteCorreo: json["ClienteCorreo"],
    );
}