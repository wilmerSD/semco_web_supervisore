import 'package:app_tasking/domain/entities/project.dart';
import 'package:app_tasking/domain/entities/task.dart';
import 'package:app_tasking/infrastructure/datasources/taskdb_datasource.dart';
import 'package:app_tasking/infrastructure/models/request/request_list_task_model.dart';
import 'package:app_tasking/infrastructure/repositories/task_repository_impl.dart';
import 'package:flutter/material.dart';

class TaskProviderP extends ChangeNotifier {
  final TaskRepositoryImpl taskRepositoryImpl =
      TaskRepositoryImpl(TaskdbDatasource());

  bool isGettingListProjects = true;
  List<Project> listProjectsBox = [
    Project(
      id: '0',
      campanaNombre: 'Seleccionar',
    )
  ];

  Project currentProject = Project(
    id: '0',
    campanaNombre: 'Seleccionar',
  );

  List<Project> listProjects = [];
  int indexProjectSelectedH = 0;
  void proyectSelected(index) {
    indexProjectSelectedH = index;
    notifyListeners();
  }

  Future<List<Task>> getTasks({Project? project}) async {
    try {
      final response =
          await taskRepositoryImpl.getListTaskByProject(RequestListTaskModel(
        pPersonalId: '',
        campanaId: project?.campanaid,
        clienteId: project?.clienteid,
        companiaId: project?.companiaid,
        taskId: '',
      ));
      return response;
    } catch (e) {
      debugPrint('error ${e}');
      return [];
    } finally {
      notifyListeners();
    }
  }
}
