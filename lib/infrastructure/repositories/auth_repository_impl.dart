import 'package:app_tasking/domain/datasources/auth_datasource.dart';
import 'package:app_tasking/domain/entities/person.dart';
import 'package:app_tasking/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl extends AuthRepository {
  final AuthDatasource authDatasource;
  AuthRepositoryImpl(this.authDatasource);
  @override
  Future<Person?> login(String username, String password) {
    return authDatasource.login(username, password);
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
