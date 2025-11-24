class RequestListSubtaskModel {
    String? pPersonalId;
    String? taskid;
    String? companaId;
    String? clienteId;
    String? companiaId;
    String? subTaskId;
    int? iIntervener;
    String? iEndDate;

    RequestListSubtaskModel({
        this.pPersonalId,
        this.taskid,
        this.companaId,
        this.clienteId,
        this.companiaId,
        this.subTaskId,
        this.iIntervener,
        this.iEndDate,
    });

    Map<String, dynamic> toJson() => {
        "Ipersonalid": pPersonalId,
        "Taskid": taskid,
        "Icampanaid": companaId,
        "Iclienteid": clienteId,
        "Icompaniaid": companiaId,
        "subTaskId": subTaskId,
        "Iintervener": iIntervener,
        "Ienddate": iEndDate
    };
}