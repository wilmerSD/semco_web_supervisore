import 'package:app_tasking/app/ui/components/custom_pop_up.dart';
import 'package:app_tasking/app/ui/views/project/project_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void showCustomPopup(BuildContext context) {
  final projectProvider = Provider.of<ProjectProvider>(context, listen:false);
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return CustomPopup(
        title: 'Orden',
        options: const ['Nombre', 'Prioridad', 'Fecha', 'Porcentaje'],
        actions: [
          () {
            //  homecontroller.orderByAlphabetically();
          },
          () {
            //  homecontroller.orderByPriority();
          },
          () {
            //  homecontroller.orderByDate();
          },
          () {
            //  homecontroller.orderByPercentage();
          },
        ],
      );
    },
  );
}
