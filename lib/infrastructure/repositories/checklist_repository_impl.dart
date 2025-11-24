import 'package:app_tasking/domain/datasources/checklist_datasource.dart';
import 'package:app_tasking/domain/entities/checklist.dart';
import 'package:app_tasking/domain/repositories/checklist_repository.dart';

class ChecklistRepositoryImpl extends ChecklistRepository {
  final ChecklistDatasource checklistDatasource;
  ChecklistRepositoryImpl(this.checklistDatasource);
  @override
  Future<List<Checklist>> getChecklist(
      {String? taskid,
      String? campanaId,
      String? clienteId,
      String? companiaId}) {
    return checklistDatasource.getChecklist(
        taskid: taskid,
        campanaId: campanaId,
        clienteId: clienteId,
        companiaId: companiaId);
  }
}
