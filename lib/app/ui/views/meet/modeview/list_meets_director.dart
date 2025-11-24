import 'package:app_tasking/app/ui/views/meet/modeview/meet_exapandable_table.dart';
import 'package:app_tasking/core/theme/app_colors.dart';
import 'package:app_tasking/core/theme/app_text_style.dart';
import 'package:flutter/material.dart';

class ListMeetsDirector extends StatelessWidget {
  const ListMeetsDirector({super.key});

  @override
  Widget build(BuildContext context) {
    // final meetProvider = Provider.of<MeetProvider>(context);

    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
        decoration: BoxDecoration(
            color: AppColors.firstBackgroundContainer(context),
            borderRadius: BorderRadius.circular(5.0)),
        child: Column(
          children: [
            Row(
              spacing: 20.0,
              children: [
                Padding(
                    padding: const EdgeInsets.only(left: 25),
                    child: _tittleList(context, 'Nombre', 365)),
                _tittleList(context, 'Área de trabajo', 260),
                _tittleList(context, 'Cantidad', 200),
                _tittleList(context, 'Intervalo de fechas', 300),
                Expanded(
                    child: Align(
                        alignment: Alignment.centerRight,
                        child: _tittleList(context, 'Comprimir todo', 200))),
              ],
            ),
            Expanded(child: MeetExpandableTable())
          ],
        ),
      ),
    );
  }
}

Widget _tittleList(BuildContext context, String text, double width) {
  return SizedBox(
      width: width,
      child: Text(
        text,
        style: AppTextStyle(context).bold15(),
      ));
}
