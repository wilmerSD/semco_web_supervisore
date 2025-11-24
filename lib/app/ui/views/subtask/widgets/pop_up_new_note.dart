import 'package:app_tasking/app/ui/components/custom_pop_up.dart';
import 'package:flutter/material.dart';

void popUpNewNote(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return CustomPopup(
        title: 'Nuevo',
        options: const ['Comentario', 'Nota', 'Reporte', 'Evaluación'],
        actions: [
          () {
            print('Ordenado por Nombre');
          },
          () {
            print('Ordenado por Prioridad');
          },
          () {
            print('Ordenado por Fecha');
          },
          () {
            print('Ordenado por Porcentaje');
          },
        ],
      );
    },
  );
}
