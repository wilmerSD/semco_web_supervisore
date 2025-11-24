import 'package:app_tasking/app/ui/views/myprofile/myprofile_provider.dart';
import 'package:app_tasking/core/routes/app_routes_name.dart';
import 'package:app_tasking/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class AppBarHome extends StatelessWidget {
  const AppBarHome({super.key});

  @override
  PreferredSizeWidget build(BuildContext context) {
    // final homeProvider = Provider.of<HomeProvider>(context);
    final myProfileController = MyprofileProvider();
    Widget logo = Container(
      width: 100,
      height: 50,
      decoration: const BoxDecoration(
        // color: AppColors.red,
        image: DecorationImage(
          image: AssetImage(
              'assets/TaskingLogoWhite.png'), // Reemplaza con tu imagen
          fit: BoxFit.scaleDown,
        ),
      ),
    );

    return AppBar(
      toolbarHeight: 50.0.h,
      backgroundColor: AppColors.primary(context),
      title: logo,
      actions: [
        IconButton(
            icon: const Icon(
              Icons.search,
              color: AppColors.red,
            ),
            onPressed: () => {}),
        // Text(logincontroller.responsedata.personalId ?? ''),
        IconButton(
          icon: CircleAvatar(
            radius: 80,
            backgroundImage: myProfileController.profileImage != null
                ? FileImage(myProfileController.profileImage!)
                : null,
            backgroundColor: AppColors.backgroundColor(context),
            child: const Icon(
              Icons.person,
              color: Colors.red,
            ),
          ),
          onPressed: () => context.push(AppRoutesName.LOGIN),
        ),
      ],
      // toolbarHeight: 0,
    );
  }
}
