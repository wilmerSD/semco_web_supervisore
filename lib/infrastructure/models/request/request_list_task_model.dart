class RequestListTaskModel {
    String? pPersonalId;
    String? campanaId;
    String? clienteId;
    String? companiaId;
    String? taskId;

    RequestListTaskModel({
        this.pPersonalId,
        this.campanaId,
        this.clienteId,
        this.companiaId,
        this.taskId,
    });

    Map<String, dynamic> toJson() => {
        "Ipersonalid": pPersonalId,
        "Icampanaid": campanaId,
        "Iclienteid": clienteId,
        "Icompaniaid": companiaId,
        "Itaskid": taskId,
    };
}