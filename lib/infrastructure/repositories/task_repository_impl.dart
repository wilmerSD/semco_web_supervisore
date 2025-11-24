import 'package:app_tasking/domain/datasources/task_datasource.dart';
import 'package:app_tasking/domain/entities/task.dart';
import 'package:app_tasking/domain/repositories/task_repository.dart';
import 'package:app_tasking/infrastructure/models/request/request_list_sutask_model.dart';
import 'package:app_tasking/infrastructure/models/request/request_list_task_model.dart';
import 'package:app_tasking/infrastructure/models/request/request_update_index_model.dart';
import 'package:app_tasking/infrastructure/models/request/request_update_state_kanban.dart';

class TaskRepositoryImpl extends TaskRepository {
  final TaskDatasource taskDatasource;
  TaskRepositoryImpl(this.taskDatasource);

  @override
  Future<List<Task>> getListSubTaskByProject(RequestListSubtaskModel request) {
    return taskDatasource.getListSubTaskByProject(request);
  }

  @override
  Future<List<Task>> getListTaskByProject(RequestListTaskModel request) {
    return taskDatasource.getListTaskByProject(request);
  }

  @override
  Future<bool> updateIndexTaskSubTask(RequestUpdateIndexModel request) {
    return taskDatasource.updateIndexTaskSubTask(request);
  }

  @override
  Future<bool> updateStateSubTask(RequestUpdateStateKanban request) {
    return taskDatasource.updateStateSubTask(request);
  }
}
