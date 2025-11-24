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

class RecoverPassReset extends StatelessWidget {
  const RecoverPassReset({super.key});

  @override
  Widget build(BuildContext context) {
    final recoverpassProvider = Provider.of<RecoverPasswordProvider>(context);

      /* 📌 Input de password */
      Widget inputPass = FieldForm(
      label: "Nueva contraseña",
      hintText: "contraseña",
      privateText: true,
      suffix: GestureDetector(
        onTap: () {
          //logincontroller.toggleVisibility(); // Método para cambiar la visibilidad
        },
        child: Icon(
          recoverpassProvider.isVisibleIcon
              ? Icons.visibility
              : Icons.visibility_off,
        ),
      ),
      textEditingController: recoverpassProvider.ctrlPasswordText,
      onEditingComplete: () {
        FocusScope.of(context).unfocus();
        // Lógica para validar el formulario
      },
    );

      /* 📌 Input password verificación */
      Widget inputSecondPass = FieldForm(
          label: "Repetir nueva contraseña",
          hintText: "repetir contraseña",
          privateText: recoverpassProvider.isVisible,
          suffix: GestureDetector(
            onTap: () {
             /*  recoverpassProvider.setPrivate(); */
            },
            child: Icon(
                recoverpassProvider.isVisibleIcon ? Icons.visibility
              : Icons.visibility_off)
          ),
          textEditingController: recoverpassProvider.textCtrlPasswordToConfirm,
        );

      /* 📌 btn para cambiar la contraseña */
      Widget btnChangePass = BtnPrimaryInk(
            text: recoverpassProvider.isLoading ? "Cambiando..." : "Cambiar contraseña",
            loading: recoverpassProvider.isLoading,
            onTap: () => {recoverpassProvider.validatePass(context)},
          );

    return Scaffold(
      appBar: AppBar(),
      body: 
      Padding(
        padding: EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
          Text("Restablecer contraseña",style: TextStyle(
                    fontSize: 24.sp,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primary(context),
                  )),
          SizedBox(height: 20.h,),
          Text("Por favor escribe algo que recuerdes",style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                    color: AppColors.blueDark(context),
                  )),
          SizedBox(height: 20.h,),
          inputPass,
          SizedBox(height: 20.h,),
          inputSecondPass,
          SizedBox(height: 20.h,),
          btnChangePass,
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
        ],),
      )
    );
  }
}
