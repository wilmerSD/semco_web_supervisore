import 'package:app_tasking/domain/entities/person.dart';

abstract class AuthRepository {
  Future<Person?> login(String username, String password);

  //recuperar contraseña
  Future<void> requestPasswordReset(String email);
  Future<bool> verifyResetCode(String email, String code);
  Future<Person?> resetPassword(String email, String newPassword);
}