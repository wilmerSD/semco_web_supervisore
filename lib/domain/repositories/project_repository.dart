import 'package:app_tasking/domain/entities/project.dart';
import 'package:app_tasking/infrastructure/models/project_model.dart';

abstract class ProjectRepository {
    Future<List<Project>> getListProyects(
    ProjectModel request,
  );

}