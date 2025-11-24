import 'package:animate_do/animate_do.dart';
import 'package:app_tasking/app/ui/components/custom_navigator_bar.dart';
import 'package:app_tasking/core/helpers/constant.dart';
import 'package:app_tasking/core/theme/app_colors.dart';
import 'package:app_tasking/core/theme/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';

class Logo extends StatelessWidget {
  const Logo({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
       /*  const SizedBox(
          width: 5.0,
        ),
        FadeInLeft(
          child: Row(
            spacing: 3.0,
            children: [
              const Icon(
                Bootstrap.check_circle,
                color: AppColors.secondaryConst,
                size: 20.0,
              ),
              Text(
                nameSystem,
                style: AppTextStyle(context).bold21(
                    color: AppColors.secondaryConst, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ), */
        logo(),
        const SizedBox(
          width: 20.0,
        ),
        const CustomNavigatorBar(),
      ],
    );
  }
}

Widget logo() {
  return Container(
      width: 170,
      height: 250,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image:
              AssetImage('assets/supervisore.png'), // Reemplaza con tu imagen
          fit: BoxFit.scaleDown,
        ),
      ),
    );
}