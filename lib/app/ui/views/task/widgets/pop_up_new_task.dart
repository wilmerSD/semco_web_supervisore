import 'package:app_tasking/app/ui/components/custom_pop_up.dart';
import 'package:flutter/material.dart';

void popUpNewTask(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return CustomPopup(
        title: 'Nuevo',
        options: const ['Proyecto', 'Tarea', 'Reunión', 'Informe'],
        actions: [
          () {
            
          },
          () {
            
          },
          () {
            
          },
          () {
            
          },
        ],
      );
    },
  );
}
