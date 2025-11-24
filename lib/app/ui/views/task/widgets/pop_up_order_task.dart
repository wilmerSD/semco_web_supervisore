import 'package:app_tasking/app/ui/components/custom_pop_up.dart';
import 'package:app_tasking/app/ui/views/task/task_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void showCustomPopup(BuildContext context) {
  final taskProvider = Provider.of<TaskProvider>(context, listen:false);
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
