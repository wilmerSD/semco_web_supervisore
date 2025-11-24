import 'package:app_tasking/app/ui/components/btn/btn_cancel_second.dart';
import 'package:app_tasking/app/ui/components/btn/btn_save_second.dart';
import 'package:app_tasking/app/ui/components/popup/popup_general.dart';
import 'package:app_tasking/app/ui/components/popup/side_panel_container.dart';
import 'package:app_tasking/app/ui/views/meet/meet_provider.dart';
import 'package:app_tasking/app/ui/views/meet/widgets/new_meet.dart';
import 'package:app_tasking/app/ui/views/meet/widgets/new_meet.dart';
import 'package:app_tasking/core/theme/app_colors.dart';
import 'package:app_tasking/core/theme/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:provider/provider.dart';

class HeaderOptionsMeet extends StatelessWidget {
  const HeaderOptionsMeet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
        // margin: const EdgeInsets.symmetric(horizontal:  20.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.0),
          gradient: AppColors.gradientToHeader,
        ),
        height: 60.0,
        child: Row(
          spacing: 20.0,
          children: [
            const Icon(
              Bootstrap.list_task,
              color: Colors.white,
            ),
            Text(
              'Reuniones',
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
    children: [
      Container(
          padding: const EdgeInsets.all(8.0),
          // margin: const EdgeInsets.symmetric(horizontal: 10.0),
          decoration: const BoxDecoration(
              // color: AppColors.headerCreate,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(5), bottomLeft: Radius.circular(5))),
          child: _customText(context, 'Crear Reunión')),
      Container(
          padding: const EdgeInsets.all(10.0),
          
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5.0),
            color: AppColors.headerOptions,
          ),
          child: Row(
            spacing: 18.0,
            children: [
              InkWell(
                  onTap: () {
                    context.read<MeetProvider>().clearValuesToNewMeet();
                    showSidePanel(context,
                        title: 'Nueva reunión',
                        child: const NewMeet(),
                        floatingActionButton: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20.0, vertical: 15.0),
                          color: AppColors.firstBackgroundContainer(context),
                          // margin: EdgeInsets.only(top: 100),
                          child: Row(
                            spacing: 20.0,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              SizedBox(
                                width: 150.0,
                                child: BtnCancelSecond(
                                  text: 'Cancelar',
                                  onTap: () => Navigator.pop(context),
                                ),
                              ),
                              SizedBox(
                                  width: 150.0,
                                  child: Consumer<MeetProvider>(
                                      builder: (context, provider, _) {
                                    return BtnSaveSecond(
                                      loading: provider.isCreatingMeet,
                                      text: provider.isCreatingMeet
                                          ? "Guardando"
                                          : 'Guardar',
                                      showBoxShadow: false,
                                      onTap: () {
                                        provider.createMeet(context);
                                      },
                                    );
                                  })),
                            ],
                          ),
                        ));
                  },
                  child: _customText(context, 'Nueva')),
              _customText(context, 'De proyecto'),
              _customText(context, 'De tarea'),
              _customText(context, 'De Gantt'),
              _customText(context, 'De Acta'),
              // const SizedBox(
              //   width: 10.0,
              // ),
            ],
          )),
    ],
  );
}

Widget _customTypeView(BuildContext context) {
  return Row(
    children: [
      Container(
          padding: const EdgeInsets.all(10.0),
          decoration: const BoxDecoration(
              // color: AppColors.headerCreate,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(5), bottomLeft: Radius.circular(5))),
          child: _customText(context, 'Vistas')),
      Container(
          padding: const EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5.0),
            color: AppColors.headerOptions,
          ),
          child: Row(
            spacing: 15.0,
            children: [
              _customText(context, 'Bandeja'),
              _customText(context, 'Calendario'),
              // _customText(context, 'Gannt'),
              // _customText(context, 'Calendario'),
              // const SizedBox(
              //   width: 10.0,
              // ),
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

