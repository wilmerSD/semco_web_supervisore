import 'package:app_tasking/app/ui/components/btn/btn_primary_ink.dart';
import 'package:app_tasking/app/ui/components/input/field_form.dart';
import 'package:app_tasking/app/ui/views/recoverpass/recover_password_provider.dart';
import 'package:app_tasking/core/helpers/helpers.dart';
import 'package:app_tasking/core/routes/app_routes_name.dart';
import 'package:app_tasking/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class RecoverPassCode extends StatelessWidget {
  const RecoverPassCode({super.key});

  @override
  Widget build(BuildContext context) {
    final recoverpassProvider = Provider.of<RecoverPasswordProvider>(context);

    /* 📌 Input de código de verificación */
    Widget inputCode = FieldForm(
      label: "Código de verificación",
      hintText: "123456",
      textInputType: TextInputType.emailAddress,
      textEditingController: recoverpassProvider.textCtrlCodeVerification,
    );

    /* 📌 btn para enviar código de verificación */
    Widget sendCodeVerification = BtnPrimaryInk(
      text: recoverpassProvider.isLoading ? "Verificando..." : "Verificar",
      loading: recoverpassProvider.isLoading,
      onTap: () => recoverpassProvider.validateCode(context),
    );

    /* 📌 btn para regresar a login */
    Widget backLogin = InkWell(
        onTap: () {
          context.go(AppRoutesName.LOGIN);
        },
        child: const Padding(
          padding: EdgeInsets.all(12),
          child: Text('Regresar a login',
              style: TextStyle(
                  color: AppColors.blueRecoverPass,
                  fontWeight: FontWeight.w900,
                  fontSize: 14)),
        ));
    return Scaffold(
        appBar: AppBar(),
        body: Padding(
          padding: EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Ingresar código",
                  /* textAlign: TextAlign.center, */
                  style: TextStyle(
                    fontSize: 24.sp,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primary(context),
                  )),
              SizedBox(
                height: 20.h,
              ),
              RichText(
                text: TextSpan(
                  /* text: '', */
                  /* style: DefaultTextStyle.of(context).style, */
                  children: <TextSpan>[
                    TextSpan(
                        text: 'Enviamos un código a ',
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: AppColors.blueDark(context),
                        )),
                    TextSpan(
                        text: ' sdwilmer@gmail.com',
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: AppColors.blueDark(context),
                          fontWeight: FontWeight.w600,
                        )),
                  ],
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              inputCode,
              SizedBox(
                height: 20.h,
              ),
              sendCodeVerification,
              SizedBox(
                height: 20.h,
              ),
              Center(
                  child: RichText(
                text: TextSpan(
                  /* text: '', */
                  /* style: DefaultTextStyle.of(context).style, */
                  children: <TextSpan>[
                    TextSpan(
                        text: 'Enviar código nuevamente',
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                          color: AppColors.blueDark(context),
                        )),
                    TextSpan(
                        text: ' 00:20',
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: AppColors.blueDark(context),
                        )),
                  ],
                ),
              )),
              Spacer(),
              InkWell(
                onTap: () => context.go(AppRoutesName.LOGIN),
                child: Center(
                  child: RichText(
                    text: TextSpan(
                      /* text: '', */
                      /* style: DefaultTextStyle.of(context).style, */
                      children: <TextSpan>[
                        TextSpan(
                            text: '¿Recordaste tu contraseña?',
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w500,
                              color: AppColors.blueDark(context),
                            )),
                        TextSpan(
                            text: ' Acceder',
                            style: TextStyle(
                                fontSize: 14.sp,
                                color: AppColors.primary(context),
                                fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 15.h,
              ),
            ],
          ),
        ));
  }
}
