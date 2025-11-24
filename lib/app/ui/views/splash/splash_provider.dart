import 'package:app_tasking/core/routes/app_routes_name.dart';
import 'package:app_tasking/infrastructure/datasources/authdb_datasource.dart';
import 'package:app_tasking/core/helpers/keys.dart';
import 'package:app_tasking/infrastructure/repositories/auth_repository_impl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:go_router/go_router.dart';

class SplashProvider with ChangeNotifier {
  String username = '';
  String password = '';
  String personalId = '';
  String srememberPass = '';
  String fullName = '';
  String names = '';
  String lastName = '';

  bool isInitialized = false;

  final FlutterSecureStorage secureStorage = const FlutterSecureStorage();
  final AuthRepositoryImpl authRepositoryImpl =
      AuthRepositoryImpl(AuthdbDatasource());

  Future<void> initialize(BuildContext context) async {
    if (isInitialized) return;
    try {
      username = await secureStorage.read(key: 'kUserName') ?? '';
      password = await secureStorage.read(key: 'kPassword') ?? '';
      personalId = await secureStorage.read(key: 'kIdUser') ?? '';
      srememberPass = await secureStorage.read(key: 'kRemenberPass') ?? '';

      notifyListeners();
      if (username.isNotEmpty && password.isNotEmpty) {
        final response = await authRepositoryImpl.login(username, password);
        if (response == null) {
          context.go(AppRoutesName.LOGIN);
          return;
        }

        await secureStorage.write(key: Keys.kPassword, value: password);
        await secureStorage.write(
            key: Keys.kIdUser, value: response.personalId);
        await secureStorage.write(
            key: Keys.kIdRole, value: response.personalRol);
        await secureStorage.write(
            key: Keys.kNameUser, value: response.personalNombreCompleto);
        await secureStorage.write(
            key: Keys.kEmail, value: response.personalCorreo);
        names = response.personalNombres ?? '';
        lastName = response.personalApellidos ?? '';
        context.go(AppRoutesName.HOME);
        return;
      }
      context.go(AppRoutesName.LOGIN);
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      isInitialized = true;
      notifyListeners();
    }
  }
}
