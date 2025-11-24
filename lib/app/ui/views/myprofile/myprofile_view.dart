import 'dart:io';
import 'package:app_tasking/app/ui/components/alert_dialog_component.dart';
import 'package:app_tasking/app/ui/views/myprofile/myprofile_provider.dart';
import 'package:app_tasking/core/helpers/constant.dart';
import 'package:app_tasking/core/routes/app_routes_name.dart';
import 'package:app_tasking/core/theme/app_colors.dart';
import 'package:app_tasking/core/theme/app_text_style.dart';
import 'package:app_tasking/preferences/shared_preferences.dart';
import 'package:app_tasking/preferences/theme_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:provider/provider.dart';

class MyprofileView extends StatelessWidget {
  const MyprofileView({super.key});

  @override
  Widget build(BuildContext context) {
    final myprofilecontroller = Provider.of<MyprofileProvider>(context);

    final prefs = PreferencesUser();
    bool whatPlatformIs = false;
    if (!kIsWeb) {
      whatPlatformIs = Platform.isIOS;
    } else {}

    return Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.primary(context),
        ),
        body: Builder(
          builder: (context) => Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Configuraciones",
                    style: AppTextStyle(context)
                        .bold20(color: AppColors.textBasic(context))),
                const SizedBox(
                  height: 20.0,
                ),
                Center(
                  child: Stack(
                    children: [
                      CircleAvatar(
                          radius: 80,
                          backgroundImage:
                              myprofilecontroller.profileImage != null
                                  ? FileImage(myprofilecontroller.profileImage!)
                                  : null,
                          child: myprofilecontroller.profileImage != null
                              ? const SizedBox()
                              : const Icon(Icons.person, size: 80)),
                      Positioned(
                          bottom: 0,
                          right: 0,
                          child: InkWell(
                            onTap: () =>
                                myprofilecontroller.pickImageFromGallery(),
                            child: const Icon(
                              Iconsax.edit_outline,
                            ),
                          )) /* CircleAvatar(
                          backgroundColor: AppColors.blueCustom,
                          child: Icon(Iconsax.edit_outline, color: Colors.white,))) */
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                // Center(
                //     child: loginController.responsedata.personalNombres != null ? Text(
                //         '${loginController.responsedata.personalNombres} ${loginController.responsedata.personalApellidos}',
                //         style: AppTextStyle(context)
                //             .bold16(color: AppColors.textBasic(context))): Text(splashController.names+splashController.lastName)),
                const SizedBox(
                  height: 20.0,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.dark_mode_outlined),
                        const SizedBox(
                          width: 10.0,
                        ),
                        Text(
                          "Modo noche",
                          style: AppTextStyle(context).bold16(
                              fontWeight: FontWeight.w500,
                              color: AppColors.textBasic(context)),
                        ),
                      ],
                    ),
                    Switch(
                        value: prefs.themeBool,
                        onChanged: (_) {
                          bool value = prefs.themeBool;
                          prefs.themeBool = !value;
                          Provider.of<ThemeProvider>(context, listen: false)
                              .getValueTheme = !value;
                        })
                  ],
                ),
                const SizedBox(
                  height: 20.0,
                ),
                InkWell(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialogComponent(
                            onTapButton: () => context.go(AppRoutesName.LOGIN),
                            title: msgBeforeCloseSesion);
                      },
                    );
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.logout),
                          const SizedBox(
                            width: 10.0,
                          ),
                          Text(
                            "Cerrar sesión",
                            style: AppTextStyle(context).bold16(
                                fontWeight: FontWeight.w500,
                                color: AppColors.textBasic(context)),
                          )
                        ],
                      ),
                      const Icon(Icons.arrow_forward_ios_outlined)
                    ],
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
