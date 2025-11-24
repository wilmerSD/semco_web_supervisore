import 'package:app_tasking/app/ui/views/home/home_provider.dart';
import 'package:app_tasking/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CustomNavigatorBar extends StatelessWidget {
  const CustomNavigatorBar({super.key});

  @override
  Widget build(BuildContext context) {
    final homeProvider = Provider.of<HomeProvider>(context);
    Future.delayed(const Duration(milliseconds: 20), () {
      homeProvider.animationMenu();
    });
    return AnimatedContainer(
      width: 550.0,
      duration: const Duration(milliseconds: 550),
      height: homeProvider.animatedNavigator ? 50.0 : 30.0,
      // color: AppColors.primarySec,
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: [
            GestureDetector(
              onTapDown: (_) => homeProvider.selectMenu(0, context),
              onTapUp: (_) => homeProvider.selectMenu(0, context),
              onTap: () => homeProvider.selectMenu(0, context),
              child: AnimatedContainer(
                curve: Curves.easeInOut,
                duration: const Duration(milliseconds: 500),
                padding: homeProvider.menuSelected != 0
                    ? const EdgeInsets.all(3.0)
                    : const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                    color: homeProvider.menuSelected == 0
                        ? AppColors.menuSelectedColor(context)
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(5)),
                child: _customOption(context, homeProvider.menuSelected == 0,
                    "Proyectos", Icons.business_center),
              ),
            ),
            const SizedBox(
              width: 15.0,
            ),
            GestureDetector(
              onTapDown: (_) => homeProvider.selectMenu(1, context),
              onTapUp: (_) => homeProvider.selectMenu(1, context),
              onTap: () => homeProvider.selectMenu(1, context),
              child: AnimatedContainer(
                padding: homeProvider.menuSelected != 1
                    ? const EdgeInsets.all(3.0)
                    : const EdgeInsets.all(8.0),
                curve: Curves.easeInOut,
                duration: const Duration(milliseconds: 500),
                decoration: BoxDecoration(
                    color: homeProvider.menuSelected == 1
                        ? AppColors.menuSelectedColor(context)
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(5)),
                child: _customOption(context, homeProvider.menuSelected == 1,
                    "Reuniones", Icons.calendar_month),
              ),
            ),
            const SizedBox(
              width: 15.0,
            ),
            GestureDetector(
              onTapDown: (_) => homeProvider.selectMenu(2, context),
              onTapUp: (_) => homeProvider.selectMenu(2, context),
              onTap: () => homeProvider.selectMenu(2, context),
              child: AnimatedContainer(
                curve: Curves.easeInOut,
                duration: const Duration(milliseconds: 500),
                padding: homeProvider.menuSelected != 2
                    ? const EdgeInsets.all(3.0)
                    : const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                    color: homeProvider.menuSelected == 2
                        ? AppColors.menuSelectedColor(context)
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(5)),
                child: _customOption(context, homeProvider.menuSelected == 2,
                    "Informes", Icons.dashboard),
              ),
            ),
            const SizedBox(
              width: 15.0,
            ),
            GestureDetector(
              onTapDown: (_) => homeProvider.selectMenu(3, context),
              onTapUp: (_) => homeProvider.selectMenu(3, context),
              onTap: () => homeProvider.selectMenu(3, context),
              child: AnimatedContainer(
                curve: Curves.easeInOut,
                duration: const Duration(milliseconds: 500),
                padding: homeProvider.menuSelected != 3
                    ? const EdgeInsets.all(3.0)
                    : const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                    color: homeProvider.menuSelected == 3
                        ? AppColors.menuSelectedColor(context)
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(5)),
                child: _customOption(context, homeProvider.menuSelected == 3,
                    "Administración", Icons.settings_applications_outlined),
              ),
            ),
            const SizedBox(
              width: 15.0,
            ),
            GestureDetector(
              onTapDown: (_) => homeProvider.selectMenu(4, context),
              onTapUp: (_) => homeProvider.selectMenu(4, context),
              onTap: () => homeProvider.selectMenu(4, context),
              child: AnimatedContainer(
                curve: Curves.easeInOut,
                duration: const Duration(milliseconds: 500),
                padding: homeProvider.menuSelected != 4
                    ? const EdgeInsets.all(3.0)
                    : const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                    color: homeProvider.menuSelected == 4
                        ? AppColors.menuSelectedColor(context)
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(5)),
                child: _customOption(context, homeProvider.menuSelected == 4,
                    "Chats", Icons.settings_applications_outlined),
              ),
            )
          ],
        ),
      ),
    );
  }
}

Widget _customOption(
    BuildContext context, bool isSelected, String text, IconData icon) {
  return Center(
    child: Text(text,
        style: TextStyle(
            color: isSelected ? Colors.white : AppColors.secondary(context),
            fontWeight: FontWeight.w400,
            fontSize: 15.0)),
  );
  // Row(
  //   children: [
  //     Icon(
  //       icon,
  //       color: isSelected ? Colors.white : AppColors.secondary(context),
  //       size: 16.0,
  //     ),
  //     const SizedBox(
  //       width: 3.0,
  //     ),
  //     Text(text,
  //         style: TextStyle(
  //             color: isSelected ? Colors.white : AppColors.secondary(context),
  //             fontWeight: FontWeight.w400,
  //             fontSize: 15.0)),
  //   ],
  // );
}
