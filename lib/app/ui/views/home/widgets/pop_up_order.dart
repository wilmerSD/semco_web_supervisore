import 'package:app_tasking/app/ui/components/custom_pop_up.dart';
import 'package:app_tasking/app/ui/views/home/home_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void showCustomPopup(BuildContext context) {
  final homeProvider = Provider.of<HomeProvider>(context, listen: false);
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return CustomPopup(
        title: 'Orden',
        options: const ['Nombre', 'Prioridad', 'Fecha', 'Porcentaje'],
        actions: [
          () {
            Navigator.pop(context);
            homeProvider.orderByAlphabetically();
          },
          () {
            Navigator.pop(context);
            homeProvider.orderByPriority();
          },
          () {
            Navigator.pop(context);
            homeProvider.orderByDate();
          },
          () {
            Navigator.pop(context);
            homeProvider.orderByPercentage();
          },
        ],
      );
    },
  );
}
