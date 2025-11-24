import 'package:app_tasking/app/ui/components/custom_pop_up.dart';
import 'package:app_tasking/app/ui/views/home/home_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void popUpTypeList(BuildContext context) {
  final homeProvider = Provider.of<HomeProvider>(context, listen: false);
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return CustomPopup(
        title: 'Vistas monitoreo',
        options: const ['Director',/*  'Tarjetas', */ 'Detalles', 'Compacto'],
        actions: [
           () {
            Navigator.pop(context);
            homeProvider.changeList(1);
          },/*
          () {
            Navigator.pop(context);
            homecontroller.changeList(2);
          }, */
          () {
            Navigator.pop(context);
            homeProvider.changeList(3);
          },
          () {
            Navigator.pop(context);
            homeProvider.changeList(4);
          },
        ],
      );
    },
  );
}
