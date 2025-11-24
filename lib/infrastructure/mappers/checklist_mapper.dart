import 'package:app_tasking/domain/entities/checklist.dart';
import 'package:app_tasking/infrastructure/models/checklist_model.dart';

class ChecklistMapper {
  static Checklist checklistResponseToEntity(ChecklistModel checklist) =>
      Checklist(
        taskCheckId: checklist.taskCheckId,
        taskCheckPersonalId: checklist.taskCheckPersonalId,
        taskCheckName: checklist.taskCheckName,
        taskCheckDate: checklist.taskCheckDate,
        taskCheckState: checklist.taskCheckState,
      );
}
