import 'package:app_tasking/app/ui/components/icon_wrapper.dart';
import 'package:app_tasking/app/ui/views/home/home_provider.dart';
import 'package:app_tasking/core/theme/app_colors.dart';
import 'package:app_tasking/core/theme/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:provider/provider.dart';

class OptionsProyects extends StatelessWidget {
  const OptionsProyects({super.key});

  @override
  Widget build(BuildContext context) {
    final homeProvider = Provider.of<HomeProvider>(
      context,
    );
    Future.delayed(
        const Duration(milliseconds: 80), () => homeProvider.animation());

    return AnimatedContainer(
      duration: const Duration(milliseconds: 500),
      curve: Curves.ease,
      color: AppColors.primaryThird(context),
      padding: const EdgeInsets.all(5.0),
      height: homeProvider.animatedOptions ? 50.0 : 10.0,
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Row(
          // scrollDirection: Axis.horizontal,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                InkWell(
                  onTap: () => homeProvider.selectOptionProyect(0, context),
                  child: Text(
                    "Director",
                    style: homeProvider.optionProyect == 0
                        ? AppTextStyle(context).bold15(
                            color: AppColors.primary(context),
                            fontWeight: FontWeight.w900)
                        : AppTextStyle(context).bold14(
                            color: AppColors.primary(context),
                            fontWeight: FontWeight.w400),
                  ),
                ),
                SizedBox(
                  width: 15.0.w,
                ),
                InkWell(
                  onTap: () => homeProvider.selectOptionProyect(
                      1, context), // print("kanban otro"),
                  child: Text(
                    "Kanban",
                    style: homeProvider.optionProyect == 1
                        ? AppTextStyle(context).bold15(
                            color: AppColors.primary(context),
                            fontWeight: FontWeight.w900)
                        : AppTextStyle(context).bold14(
                            color: AppColors.primary(context),
                            fontWeight: FontWeight.w400),
                  ),
                ),
                SizedBox(
                  width: 15.0.w,
                ),
                InkWell(
                  onTap: () => print("kanban otro"),
                  child: Text(
                    "Gantt",
                    style: homeProvider.optionProyect == 2
                        ? AppTextStyle(context).bold15(
                            color: AppColors.primary(context),
                            fontWeight: FontWeight.w900)
                        : AppTextStyle(context).bold14(
                            color: AppColors.primary(context),
                            fontWeight: FontWeight.w400),
                  ),
                )
              ],
            ),
            IconWrapper(
                onTap: () => homeProvider.updateOptionOfProyectShow(),
                child: homeProvider.showProjectInKanban
                    ? Icon(Bootstrap.arrow_up_short)
                    : Icon(Bootstrap.arrow_down_short))
          ],
        ),
      ),
    );
  }
}
