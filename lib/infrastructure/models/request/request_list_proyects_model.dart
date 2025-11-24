class RequestListProyectsModel {
  String? personalId;
  String? campanaId;
  String? clienteId;
  String? companiaId;
  String? supervisorId;
  String? responsable;
  int? anio;
  String? estado;
  String? fechaFin;
  String? buscar;

  RequestListProyectsModel({
    this.personalId,
    this.campanaId,
    this.clienteId,
    this.companiaId,
    this.supervisorId,
    this.responsable,
    this.anio,
    this.estado,
    this.fechaFin,
    this.buscar,
  });

  Map<String, dynamic> toJson() => {
        "Ipersonalid": personalId,
        "Icampanaid": campanaId,
        "Iclienteid": clienteId,
        "Icompaniaid": companiaId,
        "Isupervisorid": supervisorId,
        "Iresponsable": responsable,
        "Ianio": anio,
        "Iestado": estado,
        "Ifechafin": fechaFin,
        "Ibuscar": buscar,
      };
}
