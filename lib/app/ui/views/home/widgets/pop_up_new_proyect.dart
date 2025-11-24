import 'package:app_tasking/app/ui/components/custom_pop_up.dart';
import 'package:app_tasking/app/ui/views/home/home_provider.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

void popUpNewProyect(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      final homeProvider = Provider.of<HomeProvider>(context);
      return CustomPopup(
        title: 'Nuevo',
        options: const ['Proyecto', 'Tarea', 'Reunión', 'Informe'],
        actions: [
          () {
            Navigator.pop(context);
            homeProvider.goToNewProyect(context);
          },
          () {
            Navigator.pop(context);
            homeProvider.goToNewTask(context);
          },
          () {
            Navigator.pop(context);
            // context.push(location)
            homeProvider.goToNewMeet(context);
          },
          () {
            Navigator.pop(context);
            homeProvider.goToNewTask(context);
          },
        ],
      );
    },
  );
}
