import 'dart:io';

import 'package:app_tasking/app/ui/components/custom_cupertino_time.dart';
import 'package:app_tasking/app/ui/components/input/field_form.dart';
import 'package:app_tasking/app/ui/components/icon_wrapper.dart';
import 'package:app_tasking/app/ui/components/input_primary.dart';
import 'package:app_tasking/app/ui/views/subtask/subtask_provider.dart';
import 'package:app_tasking/app/ui/views/subtask/widgets/file_control.dart';
import 'package:app_tasking/app/ui/views/subtask/widgets/save_cancel_buttons.dart';
import 'package:app_tasking/core/helpers/helpers.dart';
import 'package:app_tasking/core/theme/app_colors.dart';
import 'package:app_tasking/core/theme/app_text_style.dart';
import 'package:duration_picker/duration_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:provider/provider.dart';

class NewReport extends StatelessWidget {
  const NewReport({super.key});

  @override
  Widget build(BuildContext context) {
    final subtaskProvider = Provider.of<SubtaskProvider>(context);
    Widget reportInput = FieldForm(
        label: "Reporte",
        maxlines: 2,
        hintText: "Ejm. El proyecto tiene un avance del 50% queda pendiente...",
        textInputType: TextInputType.emailAddress,
        textEditingController: subtaskProvider.ctrlReportText);

    Widget timeInput = InputPrimary(
      readOnly: true,
      hintText: "00:00",
      label: "Tiempo",
      maxLength: 10,
      textEditingController: subtaskProvider.ctrlTimeReportText,
      onChanged: (value) {
        subtaskProvider.ctrlTimeReportText.value;
      },
      validator: (date) {
        return null;
      },
      suffixIcon: IconWrapper(
          onTap: () async {
            if (Platform.isIOS) {
              CustomCupertinoTime.showCupertinoModal(context,
                  use24hFormat: true, title: 'Tiempo', onChanged: (value) {
                subtaskProvider.timeOfWork = value;
              }, onPressed: (_) {
                subtaskProvider.ctrlTimeReportText.text =
                    Helpers.dateToStringHourMinute(
                        subtaskProvider.timeOfWork);
              });
            } else {
              final resultingDuration = await showDurationPicker(
                  context: context,
                  initialTime: subtaskProvider.durationOfWork,
                  baseUnit: BaseUnit.minute,
                  upperBound: const Duration(hours: 8),
                  lowerBound: const Duration(minutes: 15),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                  ));
              if (resultingDuration != null &&
                  resultingDuration != subtaskProvider.durationOfWork) {
                subtaskProvider.ctrlTimeReportText.text =
                    Helpers.formatDurationToHHMM(resultingDuration);
              }
            }
          },
          child: Icon(
            Clarity.clock_solid_badged,
            color: AppColors.primary(context),
          )),
    );
    Widget state = DropdownButton<String>(
      value: subtaskProvider.stateReport,
      icon: Row(
        children: [
          Icon(Icons.arrow_downward, color: AppColors.primary(context)),
          SizedBox(
            width: 12.0.w,
          )
        ],
      ),
      elevation: 16,
      isExpanded: true,
      style: TextStyle(color: AppColors.textBasic(context)),
      underline: Container(
        height: 1.2,
        color: AppColors.underlineColorGen,
      ),
      onChanged: (String? value) {
        subtaskProvider.updateStateReportState(value);
      },
      items: subtaskProvider.listStates
          .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
    Widget advance = Slider(
      activeColor: AppColors.primary(context),
      // inactiveColor:,
      // thumbColor: ,
      min: 0.0,
      max: 100.0,
      value: subtaskProvider.advanceReport,
      onChanged: (value) {
        subtaskProvider.updateAdvanceReport(value);
        print("${subtaskProvider.advanceReport.toInt()}");
      },
      divisions: 10,
      label: subtaskProvider.advanceReport.toString(),
    );

    return Column(
      spacing: 10.0.h,
      mainAxisSize: MainAxisSize.min,
      children: [
        reportInput,
        Column(
          children: [
            Row(
              children: [
                Checkbox(
                    value: subtaskProvider.sendEmailReport,
                    onChanged: (_) {
                      subtaskProvider.checkSendEmailReport();
                    }),
                InkWell(
                    onTap: () => subtaskProvider.checkSendEmailReport(),
                    child: Text("Notificación de Correo Electrónico",
                        style: AppTextStyle(context).bold13(
                          color: AppColors.textBasic(context),
                        ))),
              ],
            ),
            Row(
              children: [
                Checkbox(
                    value: subtaskProvider.isRevisionReport,
                    onChanged: (_) {
                      subtaskProvider.checkIsRevisionReport();
                    }),
                InkWell(
                    onTap: () => subtaskProvider.checkIsRevisionReport(),
                    child: Text("Indicar si es revisión",
                        style: AppTextStyle(context).bold13(
                          color: AppColors.textBasic(context),
                        ))),
              ],
            ),
          ],
        ),
        Row(
          children: [
            Text("Avance:",
                style: AppTextStyle(context).bold13(
                  color: AppColors.textBasic(context),
                )),
            Expanded(child: advance)
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Estado:",
                style: AppTextStyle(context).bold13(
                  color: AppColors.textBasic(context),
                )),
            SizedBox(
              width: 15.0,
            ),
            SizedBox(width: 130.0.w, child: state)
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Tiempo:",
                style: AppTextStyle(context).bold13(
                  color: AppColors.textBasic(context),
                )),
            SizedBox(width: 130.0.w, child: timeInput),
          ],
        ),
        FileControl(),
        const SizedBox(),
        SaveCancelButtons(onSave: () async {
          await subtaskProvider.postProcCreateNote(
            pComeComentario: subtaskProvider.ctrlReportText.text,
            pHora: Helpers
                .getHours(subtaskProvider.ctrlTimeReportText.text),
            pMinuto: Helpers
                .getMinutes(subtaskProvider.ctrlTimeReportText.text),
            pSendEmail: subtaskProvider.sendEmailReport,
            pRevizar: subtaskProvider.isRevisionReport,
            pOpAvance: subtaskProvider.advanceReport.toInt(),
            pCambioEstado: subtaskProvider.stateReport,
          );
          subtaskProvider.ctrlReportText.clear();
          subtaskProvider.ctrlTimeReportText.text = '00:00';
          subtaskProvider.sendEmailReport = false;
          subtaskProvider.isRevisionReport = false;
          subtaskProvider.advanceReport = 0.0;
          subtaskProvider.stateReport = 'Asignado';
          if (subtaskProvider.isCreatingNote == false) {
            Navigator.pop(context);
          }
        })
      ],
    );
  }
}
