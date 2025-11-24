import 'dart:io';
import 'package:app_tasking/app/ui/components/custom_cupertino_time.dart';
import 'package:app_tasking/app/ui/components/input/field_form.dart';
import 'package:app_tasking/app/ui/components/icon_wrapper.dart';
import 'package:app_tasking/app/ui/components/input_primary.dart';
import 'package:app_tasking/app/ui/views/project/project_provider.dart';
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

class NewReportProject extends StatelessWidget {
  const NewReportProject({super.key});

  @override
  Widget build(BuildContext context) {
    final projectProvider = Provider.of<ProjectProvider>(context);
    Widget reportInput = FieldForm(
        label: "Reporte",
        maxlines: 2,
        hintText: "Ejm. El proyecto tiene un avance del 50% queda pendiente...",
        textInputType: TextInputType.emailAddress,
        textEditingController: projectProvider.ctrlReportText);

    Widget timeInput = InputPrimary(
      readOnly: true,
      hintText: "00:00",
      label: "Tiempo",
      maxLength: 10,
      textEditingController: projectProvider.ctrlTimeReportText,
      onChanged: (value) {
        projectProvider.ctrlTimeReportText.value;
      },
      validator: (date) {
        return null;
      },
      suffixIcon: IconWrapper(
          onTap: () async {
            if (Platform.isIOS) {
              CustomCupertinoTime.showCupertinoModal(context,
                  use24hFormat: true, title: 'Tiempo', onChanged: (value) {
                projectProvider.timeOfWork = value;
              }, onPressed: (_) {
                projectProvider.ctrlTimeReportText.text =
                    Helpers.dateToStringHourMinute(
                        projectProvider.timeOfWork);
              });
            } else {
              final resultingDuration = await showDurationPicker(
                  context: context,
                  initialTime: projectProvider.durationOfWork,
                  baseUnit: BaseUnit.minute,
                  upperBound: const Duration(hours: 8),
                  lowerBound: const Duration(minutes: 15),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                  ));
              if (resultingDuration != null &&
                  resultingDuration != projectProvider.durationOfWork) {
                projectProvider.ctrlTimeReportText.text =
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
      value: projectProvider.stateReport,
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
        projectProvider.updateStateReportState(value);
      },
      items: projectProvider.listStates
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
      value: projectProvider.advanceReport,
      onChanged: (value) {
        projectProvider.updateAdvanceReport(value);
        print("${projectProvider.advanceReport.toInt()}");
      },
      divisions: 10,
      label: projectProvider.advanceReport.toString(),
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
                    value: projectProvider.sendEmailReport,
                    onChanged: (_) {
                      projectProvider.checkSendEmailReport();
                    }),
                InkWell(
                    onTap: () => projectProvider.checkSendEmailReport(),
                    child: Text("Notificación de Correo Electrónico",
                        style: AppTextStyle(context).bold13(
                          color: AppColors.textBasic(context),
                        ))),
              ],
            ),
            Row(
              children: [
                Checkbox(
                    value: projectProvider.isRevisionReport,
                    onChanged: (_) {
                      projectProvider.checkIsRevisionReport();
                    }),
                InkWell(
                    onTap: () => projectProvider.checkIsRevisionReport(),
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
          await projectProvider.postProcCreateNote(
            pComeComentario: projectProvider.ctrlReportText.text,
            pHora: Helpers
                .getHours(projectProvider.ctrlTimeReportText.text),
            pMinuto: Helpers
                .getMinutes(projectProvider.ctrlTimeReportText.text),
            pSendEmail: projectProvider.sendEmailReport,
            pRevizar: projectProvider.isRevisionReport,
            pOpAvance: projectProvider.advanceReport.toInt(),
            pCambioEstado: projectProvider.stateReport,
          );
          projectProvider.ctrlReportText.clear();
          projectProvider.ctrlTimeReportText.text = '00:00';
          projectProvider.sendEmailReport = false;
          projectProvider.isRevisionReport = false;
          projectProvider.advanceReport = 0.0;
          projectProvider.stateReport = 'Asignado';
          if (projectProvider.isCreatingNote == false) {
            Navigator.pop(context);
          }
        })
      ],
    );
  }
}
