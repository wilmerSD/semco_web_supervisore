import 'package:app_tasking/infrastructure/models/task_model.dart';

class RequestUpdateIndexModel {
    String? iCampanaId;
    String? iCompaniaId;
    String? iClienteId;
    // List<ISdtListTaskIndex>? iSdtListTaskIndex;
    List<TaskModel>? iSdtListTaskIndex;

    RequestUpdateIndexModel({
        this.iCampanaId,
        this.iCompaniaId,
        this.iClienteId,
        this.iSdtListTaskIndex,
    });

    Map<String, dynamic> toJson() => {
        "iCampanaId": iCampanaId,
        "iCompaniaId": iCompaniaId,
        "iClienteId": iClienteId,
        "iSdtListTaskIndex": iSdtListTaskIndex == null ? [] : List<dynamic>.from(iSdtListTaskIndex!.map((x) => x.toJson())),
    };
}

class ISdtListTaskIndex {
    String? ordenProduccionId;
    int? index;

    ISdtListTaskIndex({
        this.ordenProduccionId,
        this.index,
    });

    Map<String, dynamic> toJson() => {
        "OrdenProduccionId": ordenProduccionId,
        "index": index,
    };
}