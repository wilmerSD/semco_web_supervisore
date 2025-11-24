import 'package:app_tasking/app/ui/components/about_app.dart';
import 'package:app_tasking/app/ui/components/logo.dart';
import 'package:app_tasking/app/ui/components/popup/popup_general.dart';
import 'package:app_tasking/app/ui/components/popup/popup_menu_profille.dart';
import 'package:app_tasking/app/ui/views/myprofile/myprofile_provider.dart';
import 'package:app_tasking/core/routes/app_routes_name.dart';
import 'package:app_tasking/core/theme/app_colors.dart';
import 'package:app_tasking/preferences/shared_preferences.dart';
import 'package:app_tasking/preferences/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:provider/provider.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final BuildContext context;

  const CustomAppBar({
    super.key,
    required this.context,
  });

  @override
  Widget build(BuildContext context) {
    final myprofileProvider = Provider.of<MyprofileProvider>(context);
    final prefs = PreferencesUser();
    bool value = prefs.themeBool;
    return AppBar(
      toolbarHeight: 70.0,
      backgroundColor: AppColors.backgroundColor(context),
      title: const Logo(),
      actions: [
            Row(
              children: [
                customIcon(context,
                    value ? Bootstrap.moon : Bootstrap.brightness_high_fill,
                    () {
                  prefs.themeBool = !value;
                  Provider.of<ThemeProvider>(context, listen: false)
                      .getValueTheme = !value;
                }),
                customIcon(context, Bootstrap.bell_fill, () {}),
                customIcon(context, Bootstrap.life_preserver, () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return PopupGeneral(
                        scrollable: true,
                        onTapButton: () => {},
                        title: "Sobre la app",
                        content: const SizedBox(
                          height: 800.0,
                          width: 850.0,
                          child: AboutApp(),
                        ),
                      );
                    },
                  );
                }),
                const PopupMenuProfille(),
                IconButton(
                  icon: CircleAvatar(
                    radius: 12.0,
                    backgroundImage: myprofileProvider.profileImage != null
                        ? FileImage(myprofileProvider.profileImage!)
                        : null,
                    backgroundColor: AppColors.backgroundColor(this.context),
                    child: myprofileProvider.profileImage != null
                        ? const SizedBox()
                        : CircleAvatar(
                            child: Icon(
                            Icons.person,
                            color: AppColors.secondary(context),
                            size: 12,
                          )),
                  ),
                  onPressed: () => context.go(AppRoutesName.MYPROFILE),
                ),
                customIcon(context, Bootstrap.door_open_fill, () {
                  context.go(AppRoutesName.LOGIN);
                }),
                const SizedBox(width: 20.0,)
              ],
            ),
      
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(50.0);
}

Widget customIcon(BuildContext context, IconData icon, Function()? onTap) {
  return IconButton(
      icon: Icon(
        icon,
        color: AppColors.primary(context),
        size: 18.0,
      ),
      onPressed: onTap);
}
