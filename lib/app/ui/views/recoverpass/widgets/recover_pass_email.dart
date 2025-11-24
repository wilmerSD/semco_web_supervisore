
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

class RecoverPasswordEmail extends StatelessWidget {
  const RecoverPasswordEmail({super.key});

  @override
  Widget build(BuildContext context) {
    final recoverpassProvider = Provider.of<RecoverPasswordProvider>(context);

    /* 📌 Input de email */
    Widget inputEmail = FieldForm(
      label: "Email",
      hintText: "Ingrese correo email",
      textInputType: TextInputType.emailAddress,
      textEditingController: recoverpassProvider.textCtrlEmail,
    );

    /* 📌 btn para enviar código de verificación */
    Widget getCodeVerification = BtnPrimaryInk(
      text: recoverpassProvider.isLoading ? "Enviando..." : "Obtener código",
      loading: recoverpassProvider.isLoading,
      onTap: () => recoverpassProvider.validateEmail(context),
    );

    return Scaffold(
        appBar: AppBar(/* title: Text("hola"), */),
        body: Padding(
          padding: EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("¿Olvidaste tu contraseña?",
                  style: TextStyle(
                    fontSize: 24.sp,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primary(context),
                  )),
              SizedBox(
                height: 20.h,
              ),
              Text(
                  "No te preocupes, eso pasa. Por favor, ingrese su email asociado con su cuenta",
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                    color: AppColors.blueDark(context),
                  )),
              SizedBox(
                height: 20.h,
              ),
              inputEmail,
              SizedBox(
                height: 20.h,
              ),
              getCodeVerification,
              const Spacer(),
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
              )
            ],
          ),
        ));
  }
}
