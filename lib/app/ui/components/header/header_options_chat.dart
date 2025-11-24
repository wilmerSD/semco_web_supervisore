import 'package:app_tasking/core/theme/app_colors.dart';
import 'package:app_tasking/core/theme/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';

class HeaderOptionsChat extends StatelessWidget {
  const HeaderOptionsChat({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
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
              'Chat',
              style: AppTextStyle(context)
                  .bold20(color: Colors.white, fontWeight: FontWeight.w600),
            ),
            _customOptions(context),
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
    children: [
      Container(
          padding: const EdgeInsets.all(8.0),
          decoration: const BoxDecoration(
              // color: AppColors.headerCreate,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(5), bottomLeft: Radius.circular(5))),
          child: _customText(context, 'Crear')),
      Container(
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.0),
          color: AppColors.headerOptions,
        ),
        child: Row(
          spacing: 10.0,
          children: [
            InkWell(
                onTap: () {
                  // showDialog(
                  //   context: context,
                  //   builder: (BuildContext context) {
                  //     return PopupGeneral(
                  //       scrollable: true,
                  //       onTapButton: () => {},
                  //       title: "Nueva reunión",
                  //       content: const SizedBox(
                  //         height: 800.0,
                  //         width: 850.0,
                  //         child: SizedBox(),
                  //       ),
                  //     );
                  //   },
                  // );
                },
                child: _customText(context, 'Nueva')),
            _customText(context, 'De proyecto'),
            _customText(context, 'De tarea'),
            _customText(context, 'De Gantt'),
            _customText(context, 'De Acta'),
            const SizedBox(
              width: 10.0,
            ),
          ],
        ),
      )
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
