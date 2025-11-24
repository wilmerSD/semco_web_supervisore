import 'dart:io';

import 'package:app_tasking/app/ui/components/custom_cupertino_time.dart';
import 'package:app_tasking/app/ui/components/input/field_form.dart';
import 'package:app_tasking/app/ui/components/icon_wrapper.dart';
import 'package:app_tasking/app/ui/components/input_primary.dart';
import 'package:app_tasking/app/ui/views/subtask/widgets/file_control.dart';
import 'package:app_tasking/app/ui/views/subtask/widgets/save_cancel_buttons.dart';
import 'package:app_tasking/app/ui/views/task/task_provider.dart';
import 'package:app_tasking/core/helpers/helpers.dart';
import 'package:app_tasking/core/theme/app_colors.dart';
import 'package:app_tasking/core/theme/app_text_style.dart';
import 'package:duration_picker/duration_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:provider/provider.dart';

class NewReportTask extends StatelessWidget {
  const NewReportTask({super.key});

  @override
  Widget build(BuildContext context) {
    final taskProvider = Provider.of<TaskProvider>(context);
    Widget reportInput = FieldForm(
        label: "Reporte",
        maxlines: 2,
        hintText: "Ejm. El proyecto tiene un avance del 50% queda pendiente...",
        textInputType: TextInputType.emailAddress,
        textEditingController: taskProvider.ctrlReportText);

    Widget timeInput = InputPrimary(
      readOnly: true,
      hintText: "00:00",
      label: "Tiempo",
      maxLength: 10,
      textEditingController: taskProvider.ctrlTimeReportText,
      onChanged: (value) {
        taskProvider.ctrlTimeReportText.value;
      },
      validator: (date) {
        return null;
      },
      suffixIcon: IconWrapper(
          onTap: () async {
            if (Platform.isIOS) {
              CustomCupertinoTime.showCupertinoModal(context,
                  use24hFormat: true, title: 'Tiempo', onChanged: (value) {
                taskProvider.timeOfWork = value;
              }, onPressed: (_) {
                taskProvider.ctrlTimeReportText.text =
                    Helpers.dateToStringHourMinute(
                        taskProvider.timeOfWork);
              });
            } else {
              final resultingDuration = await showDurationPicker(
                  context: context,
                  initialTime: taskProvider.durationOfWork,
                  baseUnit: BaseUnit.minute,
                  upperBound: const Duration(hours: 8),
                  lowerBound: const Duration(minutes: 15),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                  ));
              if (resultingDuration != null &&
                  resultingDuration != taskProvider.durationOfWork) {
                taskProvider.ctrlTimeReportText.text =
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
      value: taskProvider.stateReport,
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
        taskProvider.updateStateReportState(value);
      },
      items: taskProvider.listStates
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
      value: taskProvider.advanceReport,
      onChanged: (value) {
        taskProvider.updateAdvanceReport(value);
        print("${taskProvider.advanceReport.toInt()}");
      },
      divisions: 10,
      label: taskProvider.advanceReport.toString(),
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
                    value: taskProvider.sendEmailReport,
                    onChanged: (_) {
                      taskProvider.checkSendEmailReport();
                    }),
                InkWell(
                    onTap: () => taskProvider.checkSendEmailReport(),
                    child: Text("Notificación de Correo Electrónico",
                        style: AppTextStyle(context).bold13(
                          color: AppColors.textBasic(context),
                        ))),
              ],
            ),
            Row(
              children: [
                Checkbox(
                    value: taskProvider.isRevisionReport,
                    onChanged: (_) {
                      taskProvider.checkIsRevisionReport();
                    }),
                InkWell(
                    onTap: () => taskProvider.checkIsRevisionReport(),
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
          await taskProvider.postProcCreateNote(
            pComeComentario: taskProvider.ctrlReportText.text,
            pHora: Helpers
                .getHours(taskProvider.ctrlTimeReportText.text),
            pMinuto: Helpers
                .getMinutes(taskProvider.ctrlTimeReportText.text),
            pSendEmail: taskProvider.sendEmailReport,
            pRevizar: taskProvider.isRevisionReport,
            pOpAvance: taskProvider.advanceReport.toInt(),
            pCambioEstado: taskProvider.stateReport,
          );
          taskProvider.ctrlReportText.clear();
          taskProvider.ctrlTimeReportText.text = '00:00';
          taskProvider.sendEmailReport = false;
          taskProvider.isRevisionReport = false;
          taskProvider.advanceReport = 0.0;
          taskProvider.stateReport = 'Asignado';
          if (taskProvider.isCreatingNote == false) {
            Navigator.pop(context);
          }
        })
      ],
    );
  }
}