import 'package:animate_do/animate_do.dart';
import 'package:app_tasking/app/ui/components/btn/btn_primary_ink.dart';
import 'package:app_tasking/app/ui/components/input/field_form.dart';
import 'package:app_tasking/app/ui/views/login/login_provider.dart';
import 'package:app_tasking/core/helpers/constant.dart';
import 'package:app_tasking/core/helpers/helpers.dart';
import 'package:app_tasking/core/routes/app_routes_name.dart';
import 'package:app_tasking/core/theme/app_colors.dart';
import 'package:app_tasking/core/theme/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:provider/provider.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    Widget imageLogo = Container(
      width: 280,
      height: 250,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image:
              AssetImage('assets/supervisore.png'), // Reemplaza con tu imagen
          fit: BoxFit.scaleDown,
        ),
      ),
    );

    return ChangeNotifierProvider(
      create: (_) => LoginProvider(),
      child: Builder(builder: (context) {
        debugPrint('Hola Login2');
        Future.microtask(() {
          // context.read<LoginProvider>().onInit(); // Solo una vez
        });
        return Scaffold(
          body: Container(
            decoration: const BoxDecoration(
                image: DecorationImage(
              image: AssetImage('assets/Fondo.png'),
              fit: BoxFit.fill,
            )),
            child: GestureDetector(
              onTap: () => FocusScope.of(context).unfocus(),
              child: Container(
                padding: const EdgeInsets.all(15.0),
                child: Center(
                  child: Container(
                    width: 400.0,
                    // height: 200,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color: AppColors.backgroundColor(context),
                    ),
                    padding: const EdgeInsets.all(34.0),
                    //height: 550.0.h,
                    child: Column(
                      spacing: 25.0,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Imagen
                        FadeInUp(
                          from: 0,
                          child: SizedBox(height: 80, child: imageLogo),
                        ),
                        // // Usuario
                        _inputUserName(context),
                        // Contraseña
                        _inputPassword(),
                        _rememberPass(context),
                        //Boton
                        _button(),
                        // forgotPassword,
                        // Text(idUser),
                        // Text(idUserParam),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}

Widget _inputUserName(BuildContext context) {
  return FieldForm(
    label: "Usuario",
    hintText: "Ingresa tu usuario",
    textInputType: TextInputType.emailAddress,
    textEditingController: context.read<LoginProvider>().ctrluserText,
  );
}

Widget _inputPassword() {
  debugPrint('Hola password');
  return Selector<LoginProvider, bool>(
    selector: (_, provider) => provider.toggleVisibility,
    builder: (context, toggleVisibility, _) {
      final provider = context.read<LoginProvider>();
      return FieldForm(
        label: "Contraseña",
        hintText: "Ingresa tu contraseña",
        privateText: toggleVisibility,
        suffix: IconButton(
          onPressed: provider.seePassword,
          icon: Icon(
            toggleVisibility ? Icons.visibility : Icons.visibility_off,
          ),
        ),
        textEditingController: provider.ctrlPasswordText,
      );
    },
  );
}

Widget _rememberPass(BuildContext context) {
  return Selector<LoginProvider, bool>(
    selector: (_, provider) => provider.rememberPass,
    builder: (context, rememberPass, child) {
      debugPrint('Hola remember pass');
      return Row(
        children: [
          Checkbox(
            activeColor: AppColors.primary(context),
            value: rememberPass,
            onChanged: (_) {
              context.read<LoginProvider>().checkRememberPass();
            },
          ),
          child!, // reutilizamos el texto sin redibujarlo
        ],
      );
    },
    child: Text(
      "Recordar datos",
      style: AppTextStyle(context).bold14(
        // color: AppColors.,
        fontWeight: FontWeight.w300,
      ),
    ),
  );
}

Widget _forgotPassword(BuildContext context) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    mainAxisSize: MainAxisSize.min,
    children: [
      const Text('¿Olvidaste tu contraseña?',
          style: TextStyle(
              color: AppColors.grayMiddle,
              fontWeight: FontWeight.w700,
              fontSize: 13)),
      InkWell(
          onTap: () => context.push(AppRoutesName.RECOVERPASS),
          child: Text(' Recuperar aquí',
              // textScaler: TextScaler.linear(0.2),
              style: TextStyle(
                  color: AppColors.primary(context),
                  fontWeight: FontWeight.w700,
                  fontSize: 13))),
    ],
  );
}

Widget _button() {
  return Selector<LoginProvider, bool>(
    selector: (_, provider) => provider.isLoading,
    builder: (context, isLoading, _) {
      return BtnPrimaryInk(
        loading: isLoading,
        text: isLoading ? 'Validando' : "Ingresar",
        onTap: () => context.read<LoginProvider>().validateForm(context),
      );
    },
  );
}

Widget _footer(BuildContext context) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      InkWell(
        onTap: () {},
        child: Row(
          children: [
            Container(
              width: 50.0,
              height: 50.0,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                      'assets/whatsaapLogo.png'), // Reemplaza con tu imagen
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Text(
              "¿Necesitas ayuda?",
              style: TextStyle(
                  color: AppColors.blueDark(context),
                  fontWeight: FontWeight.w600,
                  fontSize: 14.0),
            ),
          ],
        ),
      ),
      const Text(
        "Version 1.0.0",
        style: TextStyle(
            color: AppColors.grayBlue,
            fontWeight: FontWeight.w600,
            fontSize: 14.0),
      )
    ],
  );
}
