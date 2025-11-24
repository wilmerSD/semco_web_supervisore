import 'package:app_tasking/core/network/dio_client.dart';
import 'package:app_tasking/core/network/dio_config.dart';
import 'package:app_tasking/domain/datasources/person_datasource.dart';
import 'package:app_tasking/domain/entities/person.dart';
import 'package:app_tasking/infrastructure/mappers/person_mapper.dart';
import 'package:app_tasking/infrastructure/models/response/response_person_model.dart';

class PersondbDatasource extends PersonDatasource {
  late DioClient dioClient;
  PersondbDatasource() {
    final dio = DioConfig.initialize();
    dioClient = DioClient(dio);
  }

  @override
  Future<Person?> getPersonById(String personId) async {
    try {} catch (e) {}
  }

  @override
  Future<List<Person>> getListPersons() async {
    final response =
        await dioClient.get(path: "/APITaskingv1/ProcGetListPersonal");
    final listPersonResponse = ResponsePersonModel.fromJson(response);
    if (listPersonResponse.data == null) {
      return [];
    }
    final listPeron = listPersonResponse.data!
        .map((resp) => PersonMapper.personResponseToEntity(resp))
        .toList();
    
    return listPeron;
  }
}
