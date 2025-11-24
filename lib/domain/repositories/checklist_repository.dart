import 'package:app_tasking/domain/entities/checklist.dart';

abstract class ChecklistRepository {
  Future<List<Checklist>> getChecklist({String? taskid, String? campanaId, String? clienteId, String? companiaId}); 
}