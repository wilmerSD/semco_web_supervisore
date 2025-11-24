import 'package:app_tasking/domain/datasources/project_datasource.dart';
import 'package:app_tasking/domain/entities/project.dart';
import 'package:app_tasking/domain/repositories/project_repository.dart';
import 'package:app_tasking/infrastructure/models/project_model.dart';

class ProjectRepositoryImpl extends ProjectRepository {
  final ProjectDatasource projectDatasource;
  ProjectRepositoryImpl(this.projectDatasource);

  @override
  Future<List<Project>> getListProyects(ProjectModel request) {
    return projectDatasource.getListProyects(request);
  }
}
