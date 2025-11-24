import 'package:app_tasking/app/providers/auth_provider.dart';
import 'package:app_tasking/app/ui/components/alert_dialog_component.dart';
import 'package:app_tasking/core/helpers/constant.dart';
import 'package:app_tasking/core/routes/app_routes_name.dart';
import 'package:app_tasking/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:provider/provider.dart';

enum AnimationStyles { defaultStyle, custom, none }

enum Menu { profile, closeSesion }

class PopupMenuProfille extends StatefulWidget {
  const PopupMenuProfille({super.key});

  @override
  State<PopupMenuProfille> createState() => _PopupMenuProfilleState();
}

class _PopupMenuProfilleState extends State<PopupMenuProfille> {
  AnimationStyle? _animationStyle;

  @override
  Widget build(BuildContext context) {
    _animationStyle = AnimationStyle(
      curve: Easing.emphasizedDecelerate,
      duration: const Duration(seconds: 1),
    );
    return SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          PopupMenuButton<Menu>(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
              side: BorderSide(
                color: AppColors.shadowAppBarColor(context), // 👈 color del borde
                width: 2, // grosor del borde
              ),
            ),
            elevation: 0,
            offset: const Offset(-10, 30), // 👈 Esto baja el menú 20px
            color: AppColors.backgroundColor(context),
            borderRadius: BorderRadius.circular(16),
            shadowColor: const Color.fromARGB(145, 158, 158, 158).withValues(),
            popUpAnimationStyle: _animationStyle,
            icon: const CircleAvatar(
              radius: 12.0,
              child:  Icon(Bootstrap.person_fill, color: AppColors.primaryConst, size: 12,),
            ),
            onSelected: (Menu item) {
              switch (item) {
                case Menu.profile:
                  context.go(AppRoutesName.MYPROFILE);
                  break;
                case Menu.closeSesion:
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialogComponent(
                        onTapButton: () {
                          Provider.of<AuthProvider>(context, listen: false).logout();
                          context.go(AppRoutesName.LOGIN);
                        } ,
                        title: "¿Seguro que quieres salir de $ktittleSistem ?",
                      );
                    },
                  );
                  break;
              }
            },
            itemBuilder: (BuildContext context) => <PopupMenuEntry<Menu>>[
              const PopupMenuItem<Menu>(
                value: Menu.profile,
                child: ListTile(
                  leading: Icon(BoxIcons.bx_user),
                  title: Text('Perfil'),
                ),
              ),

              const PopupMenuDivider(),

              const PopupMenuItem<Menu>(
                value: Menu.closeSesion,
                child: ListTile(
                  leading: Icon(Iconsax.logout_outline),
                  title: Text('Cerrar sesión'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}