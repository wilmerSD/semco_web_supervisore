import 'dart:io';

import 'package:app_tasking/app/ui/components/input/field_form.dart';
import 'package:app_tasking/app/ui/components/icon_wrapper.dart';
import 'package:app_tasking/app/ui/components/input_primary.dart';
import 'package:app_tasking/app/ui/views/subtask/widgets/file_control.dart';
import 'package:app_tasking/app/ui/views/subtask/widgets/save_cancel_buttons.dart';
import 'package:app_tasking/app/ui/views/task/task_provider.dart';
import 'package:app_tasking/core/helpers/constant.dart';
import 'package:app_tasking/core/helpers/helpers.dart';
import 'package:app_tasking/core/theme/app_colors.dart';
import 'package:app_tasking/core/theme/app_text_style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:provider/provider.dart';

class NewEvaluationTask extends StatelessWidget {
  const NewEvaluationTask({super.key});

  @override
  Widget build(BuildContext context) {
    final taskProvider = Provider.of<TaskProvider>(context);
    Widget recomendacionInput = FieldForm(
        borderRadius: 8.0,
        label: "", //"Comentarios/Recomendación",
        // maxlines: 2,
        hintText: "Ejm. El proyecto tiene un avance del 50% queda pendiente...",
        textInputType: TextInputType.emailAddress,
        textEditingController: taskProvider.ctrlRecomendacionText);
    Widget privateNoteInput = FieldForm(
        borderRadius: 8.0,
        label: "", // "Nota privada",
        hintText: "Ejm. El proyecto tiene un avance del 50% queda pendiente...",
        textInputType: TextInputType.emailAddress,
        textEditingController: taskProvider.ctrlNotePrivEvaluText);
    Widget dateRevisionInput = InputPrimary(
      hintText: "dd/mm/aaaa",
      label: "Fecha de revisión:",
      maxLength: 10,
      textEditingController: taskProvider.dateOfRevisionEvalText,
      onChanged: (value) {
        taskProvider.dateOfRevisionEvalText.value;
      },
      inputFormats: [
        FilteringTextInputFormatter.allow(RegExp(r'[0-9\/]')),
      ],
      suffixIcon: IconWrapper(
          onTap: () async {
            if (Platform.isIOS) {
              showCupertinoModalPopup(
                context: context,
                builder: (BuildContext context) {
                  return Container(
                    height: 260,
                    color: Colors.white,
                    child: Column(
                      children: [
                        SizedBox(
                          height: 200,
                          child: CupertinoDatePicker(
                            initialDateTime: DateTime.now(),
                            mode: CupertinoDatePickerMode.date,
                            onDateTimeChanged: (DateTime newDate) {
                              taskProvider.dateOfRevisionEval = newDate;
                            },
                          ),
                        ),
                        CupertinoButton(
                          child: const Text('Hecho'),
                          onPressed: () {
                            Navigator.of(context).pop();
                            taskProvider.dateOfRevisionEvalText.text =
                                Helpers.dateToStringTimeDMY(
                                    taskProvider.dateOfRevisionEval);
                          },
                        ),
                      ],
                    ),
                  );
                },
              );
            } else {
              DateTime? pickdateInicio = await showDatePicker(
                context: context,
                locale: const Locale("es", "ES"),
                initialDate: DateTime.now(),
                firstDate: DateTime.now(),
                lastDate: DateTime(2100),
                cancelText: textCancelText,
                confirmText: textconfirmText,
              );
              if (pickdateInicio != null) {
                taskProvider.dateOfRevisionEvalText.text =
                    Helpers.dateToStringTimeDMY(pickdateInicio);
              }
            }
          },
          child: Icon(
            Iconsax.calendar_1_bold,
            color: AppColors.primary(context),
          )),
    );
    Widget dateDeliveryInput = InputPrimary(
      hintText: "dd/mm/aaaa",
      label: "Fecha de entrega:",
      maxLength: 10,
      textEditingController: taskProvider.dateOfDeliveryEvalText,
      onChanged: (value) {
        taskProvider.dateOfDeliveryEvalText.value;
      },
      inputFormats: [
        FilteringTextInputFormatter.allow(RegExp(r'[0-9\/]')),
      ],
      suffixIcon: IconWrapper(
          onTap: () async {
            if (Platform.isIOS) {
              showCupertinoModalPopup(
                context: context,
                builder: (BuildContext context) {
                  return Container(
                    height: 260,
                    color: Colors.white,
                    child: Column(
                      children: [
                        SizedBox(
                          height: 200,
                          child: CupertinoDatePicker(
                            initialDateTime: DateTime.now(),
                            mode: CupertinoDatePickerMode.date,
                            onDateTimeChanged: (DateTime newDate) {
                              taskProvider.dateOfDeliveryEval = newDate;
                            },
                          ),
                        ),
                        CupertinoButton(
                          child: const Text('Hecho'),
                          onPressed: () {
                            Navigator.of(context).pop();
                            taskProvider.dateOfDeliveryEvalText.text =
                                Helpers.dateToStringTimeDMY(
                                    taskProvider.dateOfDeliveryEval);
                          },
                        ),
                      ],
                    ),
                  );
                },
              );
            } else {
              DateTime? pickdateInicio = await showDatePicker(
                context: context,
                locale: const Locale("es", "ES"),
                initialDate: DateTime.now(),
                firstDate: DateTime.now(),
                lastDate: DateTime(2100),
                cancelText: textCancelText,
                confirmText: textconfirmText,
              );
              if (pickdateInicio != null) {
                taskProvider.dateOfDeliveryEvalText.text =
                    Helpers.dateToStringTimeDMY(pickdateInicio);
              }
            }
          },
          child:
              Icon(Iconsax.calendar_1_bold, color: AppColors.primary(context))),
    );
    Widget independenceResults = SizedBox(
      width: 150,
      child: DropdownButton<String>(
        value: taskProvider.independenceResults,
        icon: Icon(
          Icons.arrow_downward,
          color: AppColors.primary(context),
        ),
        elevation: 16,
        style: TextStyle(color: AppColors.textBasic(context)),
        underline: Container(
          height: 1,
          color: AppColors.underlineColorGen,
        ),
        onChanged: (String? value) {
          taskProvider.updateIndependenceResults(value);
        },
        items: taskProvider.listQualityOfWork
            .map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
      ),
    );
    Widget workInTeam = SizedBox(
      width: 150,
      child: DropdownButton<String>(
        value: taskProvider.workInTeam,
        icon: Icon(
          Icons.arrow_downward,
          color: AppColors.primary(context),
        ),
        elevation: 16,
        style: TextStyle(color: AppColors.textBasic(context)),
        underline: Container(
          height: 1,
          color: AppColors.underlineColorGen,
        ),
        onChanged: (String? value) {
          taskProvider.updateWorkInTeam(value);
        },
        items: taskProvider.listQualityOfWork
            .map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
      ),
    );
    Widget qualityOfWork = SizedBox(
      width: 150,
      child: DropdownButton<String>(
        value: taskProvider.qualityOfWork,
        icon: Icon(
          Icons.arrow_downward,
          color: AppColors.primary(context),
        ),
        elevation: 16,
        style: TextStyle(color: AppColors.textBasic(context)),
        underline: Container(
          height: 1,
          color: AppColors.underlineColorGen,
        ),
        onChanged: (String? value) {
          taskProvider.updateQualityOfWork(value);
        },
        items: taskProvider.listQualityOfWork
            .map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
      ),
    );
    return Column(
      spacing: 10.0.h,
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Fecha de entrega:",
                style: AppTextStyle(context).bold13(
                  color: AppColors.textBasic(context),
                )),
            SizedBox(width: 150.0.w, child: dateDeliveryInput)
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Fecha de revisión:",
                style: AppTextStyle(context).bold13(
                  color: AppColors.textBasic(context),
                )),
            SizedBox(width: 150.0.w, child: dateRevisionInput),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Calidad de trabajo:",
                style: AppTextStyle(context).bold13(
                  color: AppColors.textBasic(context),
                )),
            qualityOfWork
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Trabajo en equipo:",
                style: AppTextStyle(context).bold13(
                  color: AppColors.textBasic(context),
                )),
            workInTeam
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Independencia en \nlogro de resultados:",
                style: AppTextStyle(context).bold13(
                  color: AppColors.textBasic(context),
                )),
            independenceResults
          ],
        ),
        Column(
          spacing: 5.0.w,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Comentarios/Recomendación:",
                style: AppTextStyle(context).bold13(
                  color: AppColors.textBasic(context),
                )),
            recomendacionInput
            // Expanded(child: evaluationInput),
          ],
        ),
        Column(
          spacing: 3.0.h,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Nota privada:",
                style: AppTextStyle(context).bold13(
                  color: AppColors.textBasic(context),
                )),
            privateNoteInput
            // Expanded(child: privateNoteInput),
          ],
        ),
        FileControl(),
        const SizedBox(),
        SaveCancelButtons(onSave: () async {
          await taskProvider.postProcCreateNote(
              pQualityOfWork: taskProvider.qualityOfWork,
              pWorkInTeam: taskProvider.workInTeam,
              pIndependenceResult: taskProvider.independenceResults,
              pDateClose: taskProvider.dateOfDeliveryEvalText.text,
              pDateOfReview: taskProvider.dateOfRevisionEvalText.text,
              pPrivateNote: taskProvider.ctrlNotePrivEvaluText.text,
              pRecommendation: taskProvider.ctrlRecomendacionText.text);

          taskProvider.qualityOfWork = 'Esperado';
          taskProvider.workInTeam = 'Esperado';
          taskProvider.independenceResults = 'Esperado';
          taskProvider.dateOfDeliveryEvalText.text =
              Helpers.dateToStringTimeDMY(DateTime.now());
          taskProvider.dateOfRevisionEvalText.text =
              taskProvider.dateOfDeliveryEvalText.text;
          taskProvider.ctrlNotePrivEvaluText.text = '';
          taskProvider.ctrlRecomendacionText.text = '';
          if (taskProvider.isCreatingNote == false) {
            Navigator.pop(context);
          }
        })
      ],
    );
  }
}
