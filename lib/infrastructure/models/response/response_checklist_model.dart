import 'package:app_tasking/infrastructure/models/checklist_model.dart';

class ResponseChecklistModel {
    List<ChecklistModel> pSdtCheckList;

    ResponseChecklistModel({
        required this.pSdtCheckList,
    });

    factory ResponseChecklistModel.fromJson(Map<String, dynamic> json) => ResponseChecklistModel(
        pSdtCheckList: json["pSdtCheckList"] == null ? [] : List<ChecklistModel>.from(json["pSdtCheckList"]!.map((x) => ChecklistModel.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "pSdtCheckList": pSdtCheckList == null ? [] : List<dynamic>.from(pSdtCheckList!.map((x) => x.toJson())),
    };
}

