import 'package:app_tasking/domain/entities/project.dart';
import 'package:app_tasking/domain/entities/task.dart';
import 'package:app_tasking/infrastructure/models/project_model.dart';
import 'package:app_tasking/infrastructure/models/response/response_list_proyects_model.dart';
import 'package:app_tasking/infrastructure/models/response/response_list_task_model.dart';

abstract class ProjectDatasource {

  Future<List<Project>> getListProyects(
    ProjectModel request,
  );

}



