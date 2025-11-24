import 'package:app_tasking/domain/entities/task.dart';
import 'package:app_tasking/infrastructure/models/request/request_list_sutask_model.dart';
import 'package:app_tasking/infrastructure/models/request/request_list_task_model.dart';
import 'package:app_tasking/infrastructure/models/request/request_update_index_model.dart';
import 'package:app_tasking/infrastructure/models/request/request_update_state_kanban.dart';

abstract class TaskRepository {
    Future<List<Task>> getListTaskByProject(RequestListTaskModel request);
    Future<List<Task>> getListSubTaskByProject(RequestListSubtaskModel request);
    Future<bool> updateIndexTaskSubTask(RequestUpdateIndexModel request);
    Future<bool> updateStateSubTask(RequestUpdateStateKanban request);
}