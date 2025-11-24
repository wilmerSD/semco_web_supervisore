import 'package:app_tasking/core/network/dio_client.dart';
import 'package:app_tasking/core/network/dio_config.dart';
import 'package:app_tasking/domain/datasources/task_datasource.dart';
import 'package:app_tasking/domain/entities/task.dart';
import 'package:app_tasking/infrastructure/mappers/task_mapper.dart';
import 'package:app_tasking/infrastructure/models/request/request_list_sutask_model.dart';
import 'package:app_tasking/infrastructure/models/request/request_list_task_model.dart';
import 'package:app_tasking/infrastructure/models/request/request_update_index_model.dart';
import 'package:app_tasking/infrastructure/models/request/request_update_state_kanban.dart';
import 'package:app_tasking/infrastructure/models/response/response_general_model.dart';
import 'package:app_tasking/infrastructure/models/response/response_list_task_model.dart';

class TaskdbDatasource extends TaskDatasource {
  late DioClient dioClient;
  TaskdbDatasource() {
    final dio = DioConfig.initialize();
    dioClient = DioClient(dio);
  }

  @override
  Future<List<Task>> getListSubTaskByProject(RequestListSubtaskModel request) async {
    final response = await dioClient.get(
        path: "/APITask/GetProcListTaskAndSubTask", queryParameters: request.toJson());
    final taskResponse = ResponseListTaskModel.fromJson(response);
    if (taskResponse.data == null) return [];
    final tasks = taskResponse.data!
        .map((element) => TaskMapper.taskResponseToEntity(element))
        .toList();
    return tasks;
  }

  @override
  Future<List<Task>> getListTaskByProject(RequestListTaskModel request) async{
     final response = await dioClient.get(
        path: "/APITask/GetProcListTask", queryParameters: request.toJson());
    final taskResponse = ResponseListTaskModel.fromJson(response);
    if (taskResponse.data == null) return [];
    final tasks = taskResponse.data!
        .map((element) => TaskMapper.taskResponseToEntity(element))
        .toList();
    return tasks;
  }

  @override
  Future<bool> updateIndexTaskSubTask(RequestUpdateIndexModel request) async{
  final response = await dioClient.post(
    path: '/APITask/ProcUpdateIndexTask',
    bodyRaw: request.toJson(),
  );
  final responseUpdate = ResponseGeneralModel.fromJson(response);
  return responseUpdate.succes;
  }

  @override
  Future<bool> updateStateSubTask(RequestUpdateStateKanban request) async{
  final response = await dioClient.post(
    path: '/APITask/PostProcUpdateStateSubTask',
    bodyRaw: request.toJson(),
  );
  final responseUpdate = ResponseGeneralModel.fromJson(response);
  return responseUpdate.succes;
  }
}
