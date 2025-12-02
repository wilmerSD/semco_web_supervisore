import 'package:app_tasking/domain/entities/project.dart';
import 'package:app_tasking/infrastructure/datasources/projectdb_datasource.dart';
import 'package:app_tasking/infrastructure/models/project_model.dart';
import 'package:app_tasking/infrastructure/repositories/project_repository_impl.dart';
import 'package:flutter/material.dart';

class ProjectProviderP extends ChangeNotifier {
  final ProjectRepositoryImpl projectRepositoryImpl =
      ProjectRepositoryImpl(ProjectdbDatasource());

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

  Future<void> getListProjects(
      BuildContext context, ProjectModel project) async {
    isGettingListProjects = true;
    try {
      final response =
          await projectRepositoryImpl.getListProyects(ProjectModel());
      listProjectsBox.addAll(response);
      listProjects.addAll(response);
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      isGettingListProjects = false;
      notifyListeners();
    }
  }
}
