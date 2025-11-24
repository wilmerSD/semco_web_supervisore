import "package:app_tasking/app/ui/components/toast/toast.dart";
import "package:app_tasking/domain/entities/person.dart";
import "package:app_tasking/infrastructure/datasources/authdb_datasource.dart";
import "package:app_tasking/core/helpers/custom_snackbar.dart";
import "package:app_tasking/core/helpers/keys.dart";
import "package:app_tasking/core/routes/app_routes_name.dart";
import "package:app_tasking/infrastructure/repositories/auth_repository_impl.dart";
import "package:flutter/material.dart";
import "package:flutter_secure_storage/flutter_secure_storage.dart";
import "package:url_launcher/url_launcher.dart";
import 'package:go_router/go_router.dart';

class LoginProvider with ChangeNotifier {
  //INSTANCES
  final FlutterSecureStorage secureStorage = const FlutterSecureStorage();
  final AuthRepositoryImpl authRepositoryImpl =
      AuthRepositoryImpl(AuthdbDatasource());
  // final UserProvider userProvider = UserProvider();

  //VARIABLES
  int counter = 0;
  TextEditingController ctrluserText =
      TextEditingController(text: 'desarrollosw2@semco.com.pe'); //
  TextEditingController ctrlPasswordText =
      TextEditingController(text: 'jsanchez'); //
  bool isVisibleIcon = false;
  bool isLoading = false;
  bool rememberPass = false;
  String srememberPass = "";
  bool toggleVisibility = true;
  Person responsedata = Person();
  bool initializo = false;
  String personalId = '';

  //FUNCTIONS
  onInit() async {}

  /* 📌 Validar que los campos del form esten completos antes de hacer la petición */
  Future<void> validateForm(BuildContext context) async {
    FocusScope.of(context).unfocus();
    if (ctrluserText.text.trim() == "" && ctrlPasswordText.text.trim() == "") {
      CustomSnackbar.showSnackBarSuccess(
        context,
        title: "Validar!",
        message: "Por favor, ingrese su usuario y contraseña.",
      );
      return;
    }
    if (ctrluserText.text.trim() == "") {
      CustomSnackbar.showSnackBarSuccess(
        context,
        title: "Validar!",
        message: "Por favor, ingrese su usuario",
      );
    }
    if (ctrlPasswordText.text.trim() == "") {
      CustomSnackbar.showSnackBarSuccess(
        context,
        title: "Validar!",
        message: "Por favor, ingrese su contraseña",
      );
    }
    authentication(context);
  }

  /* 📌 Recordar o no las credenciales */
  void checkRememberPass() {
    rememberPass = !rememberPass;
    notifyListeners();
  }

  /* 📌 Esconder o ver password */
  void seePassword() {
    toggleVisibility = !toggleVisibility;
    notifyListeners();
  }

  /* 📌 Realizar la autenticación */
  Future<void> authentication(BuildContext context) async {
    isLoading = true;

    try {
      final response = await authRepositoryImpl.login(
          ctrluserText.text, ctrlPasswordText.text);
      if (response == null) {
        showToastGlobal(
            context, 2, "error", "Usuario o contraseña incorrecto.");
        return;
      }
      responsedata = response;
      personalId = responsedata.personalId ?? '';
      // notifyListeners();

      if (rememberPass) {
        await secureStorage.write(
            key: Keys.kUserName, value: ctrluserText.text);
        await secureStorage.write(
            key: Keys.kPassword, value: ctrlPasswordText.text);
        srememberPass = 'true';
      }

      await secureStorage.write(
          key: Keys.kIdUser, value: responsedata.personalId);
      await secureStorage.write(
          key: Keys.kIdRole, value: responsedata.personalRol);
      await secureStorage.write(
          key: Keys.kNameUser, value: responsedata.personalNombreCompleto);
      await secureStorage.write(
          key: Keys.kEmail, value: responsedata.personalCorreo);
      await secureStorage.write(key: Keys.kRemenberPass, value: srememberPass);
      context.go(AppRoutesName.HOME);
    } catch (e) {
      CustomSnackbar.showSnackBarSuccess(
        context,
        title: "Validar!",
        message:
            "Ups! Ocurrió un error inesperado, intente nuevamente${e.toString()}",
      );
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  /* 📌 Ir a Whatsapp */
  void goToWhatsapp() async {
    const phoneNumber = '949238476'; // Número de teléfono con código de país
    const message =
        'Hola, estoy interesado en tus servicios.'; // Mensaje predeterminado
    final url = Uri.parse(
        'https://wa.me/$phoneNumber?text=${Uri.encodeComponent(message)}');

    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    } else {
      throw 'No se pudo abrir WhatsApp';
    }
  }
}
