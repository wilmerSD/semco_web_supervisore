class ChecklistModel {
    int? taskCheckId;
    String? taskCheckPersonalId;
    String? taskCheckName;
    DateTime? taskCheckDate;
    bool? taskCheckState;

    ChecklistModel({
        this.taskCheckId,
        this.taskCheckPersonalId,
        this.taskCheckName,
        this.taskCheckDate,
        this.taskCheckState,
    });

    factory ChecklistModel.fromJson(Map<String, dynamic> json) => ChecklistModel(
        taskCheckId: json["taskCheckId"],
        taskCheckPersonalId: json["taskCheckPersonalId"],
        taskCheckName: json["taskCheckName"],
        taskCheckDate: json["taskCheckDate"] == null ? null : DateTime.parse(json["taskCheckDate"]),
        taskCheckState: json["taskCheckState"],
    );

    Map<String, dynamic> toJson() => {
        "taskCheckId": taskCheckId,
        "taskCheckPersonalId": taskCheckPersonalId,
        "taskCheckName": taskCheckName,
        "taskCheckDate": "${taskCheckDate!.year.toString().padLeft(4, '0')}-${taskCheckDate!.month.toString().padLeft(2, '0')}-${taskCheckDate!.day.toString().padLeft(2, '0')}",
        "taskCheckState": taskCheckState,
    };
}