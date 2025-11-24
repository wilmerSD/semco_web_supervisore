import 'package:app_tasking/core/network/dio_client.dart';
import 'package:app_tasking/core/network/dio_config.dart';
import 'package:app_tasking/domain/datasources/checklist_datasource.dart';
import 'package:app_tasking/domain/entities/checklist.dart';
import 'package:app_tasking/infrastructure/mappers/checklist_mapper.dart';
import 'package:app_tasking/infrastructure/models/response/response_checklist_model.dart';

class ChecklistdbDatasource extends ChecklistDatasource {
  late DioClient dioClient;

  ChecklistdbDatasource() {
    final dio = DioConfig.initialize();
    dioClient = DioClient(dio);
  }

  @override
  Future<List<Checklist>> getChecklist(
      {String? taskid,
      String? campanaId,
      String? clienteId,
      String? companiaId}) async {
    final response = await dioClient
        .get(path: "/APITaskingv1/GetProcGetCheckList", queryParameters: {
      "pOrdenProdId": taskid ?? '',
      "pCampanaId": campanaId ?? '',
      "pClienteId": clienteId ?? '',
      "pCompaniaId": companiaId ?? '',
    });
    final checkListResponse = ResponseChecklistModel.fromJson(response);
    final listChecklist = checkListResponse.pSdtCheckList
        .map((element) => ChecklistMapper.checklistResponseToEntity(element))
        .toList();

    return listChecklist;
  }
}
