import 'package:app_tasking/core/network/dio_client.dart';
import 'package:app_tasking/core/network/dio_config.dart';
import 'package:app_tasking/domain/datasources/auth_datasource.dart';
import 'package:app_tasking/domain/entities/person.dart';
import 'package:app_tasking/infrastructure/mappers/person_mapper.dart';
import 'package:app_tasking/infrastructure/models/response/response_person_model.dart';

class AuthdbDatasource extends AuthDatasource {
  late DioClient dioClient;
  AuthdbDatasource() {
    final dio = DioConfig.initialize();
    dioClient = DioClient(dio);
  }

  @override
  Future<Person?> login(String username, String password) async {
    try {
      final response = await dioClient.post(
        path: "/APITaskingv1/PostLogin",
        bodyRaw: {
          "username": username,
          "password": password,
        },
      );
      final personResponse = ResponsePersonModel.fromJson(response);
      if (!personResponse.success) {
        return null;
      }
      final person =
          PersonMapper.personResponseToEntity(personResponse.data![0]);
      return person;
    } catch (e) {}
  }

  @override
  Future<void> requestPasswordReset(String email) {
    // TODO: implement requestPasswordReset
    throw UnimplementedError();
  }

  @override
  Future<Person?> resetPassword(String email, String newPassword) {
    // TODO: implement resetPassword
    throw UnimplementedError();
  }

  @override
  Future<bool> verifyResetCode(String email, String code) {
    // TODO: implement verifyResetCode
    throw UnimplementedError();
  }
}
