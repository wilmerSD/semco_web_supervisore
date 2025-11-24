import 'package:app_tasking/core/network/dio_client.dart';
import 'package:app_tasking/core/network/dio_config.dart';
import 'package:app_tasking/domain/datasources/project_datasource.dart';
import 'package:app_tasking/domain/entities/project.dart';
import 'package:app_tasking/infrastructure/mappers/project_mapper.dart';
import 'package:app_tasking/infrastructure/models/project_model.dart';
import 'package:app_tasking/infrastructure/models/response/response_list_proyects_model.dart';

class ProjectdbDatasource extends ProjectDatasource {
  late DioClient dioClient;
  ProjectdbDatasource() {
    final dio = DioConfig.initialize();
    dioClient = DioClient(dio);
  }
  @override
  Future<List<Project>> getListProyects(ProjectModel request) async {
    final response = await dioClient.get(
        path: "/ApiProject/GetProcListProyect",
        queryParameters: request.toJson());
    final projectResponse = ResponseListProyectsModel.fromJson(response);
    if (projectResponse.data == null) {
      return [];
    }
    
    final projects = projectResponse.data!
        .map((element) => ProjectMapper.projectResponseToEntity(element))
        .toList();
    return projects;
  }
}
