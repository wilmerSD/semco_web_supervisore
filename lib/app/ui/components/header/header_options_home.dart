import 'package:app_tasking/core/theme/app_colors.dart';
import 'package:app_tasking/core/theme/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';

class HeaderOptionsHome extends StatelessWidget {
  const HeaderOptionsHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        // margin: const EdgeInsets.symmetric(horizontal:  20.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.0),
           gradient: AppColors.gradientToHeader,
        ),
        height: 50.0,
        child: Row(
          spacing: 20.0,
          children: [
            const Icon(
              Bootstrap.list_task,
              color: Colors.white,
            ),
            Text(
              'Director',
              style: AppTextStyle(context)
                  .bold20(color: Colors.white, fontWeight: FontWeight.w600),
            ),
            _customOptions(context),
            _customTypeView(context),
            const Spacer(),
            Row(
              children: [
                _customText(context, 'Bienvenido, '),
                _customText(context, 'Jose Sanchez')
              ],
            )
          ],
        ));
  }
}

Widget _customOptions(BuildContext context) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.center,
    spacing: 5.0,
    children: [
      _customText(context, 'Crear'),
      Container(
           padding: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5.0),
            color: AppColors.headerOptions,
          ),
          child: Row(
            spacing: 10.0,
            children: [
              
              _customText(context, 'Proyecto'),
              _customText(context, 'Tarea'),
              _customText(context, 'Gannt'),
              _customText(context, 'Borrador'),
              const SizedBox(
                width: 10.0,
              ),
            ],
          )),
    ],
  );
}

Widget _customTypeView(BuildContext context) {
  return Row(
     crossAxisAlignment: CrossAxisAlignment.center,
    spacing: 5.0,
    children: [
      _customText(context, 'Vistas'),
       Container(
           padding: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5.0),
            color: AppColors.headerOptions,
          ),
          child: Row(
            spacing: 10.0,
            children: [
              _customText(context, 'Vistas'),
              _customText(context, 'Director'),
              _customText(context, 'Kanban'),
              _customText(context, 'Gannt'),
              _customText(context, 'Calendario'),
              const SizedBox(
                width: 10.0,
              ),
            ],
          )),
    ],
  );
}

Widget _customText(BuildContext context, String text) {
  return Text(
    text,
    style: AppTextStyle(context)
        .bold15(color: Colors.white, fontWeight: FontWeight.normal),
  );
}


