import 'dart:io';

import 'package:app_tasking/app/ui/components/input/field_form.dart';
import 'package:app_tasking/app/ui/components/icon_wrapper.dart';
import 'package:app_tasking/app/ui/components/input_primary.dart';
import 'package:app_tasking/app/ui/views/subtask/subtask_provider.dart';
import 'package:app_tasking/app/ui/views/subtask/widgets/file_control.dart';
import 'package:app_tasking/app/ui/views/subtask/widgets/save_cancel_buttons.dart';
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

class NewEvaluation extends StatelessWidget {
  const NewEvaluation({super.key});

  @override
  Widget build(BuildContext context) {
    final subtaskProvider = Provider.of<SubtaskProvider>(context);
    Widget recomendacionInput = FieldForm(
        borderRadius: 8.0,
        label: "", //"Comentarios/Recomendación",
        // maxlines: 2,
        hintText: "Ejm. El proyecto tiene un avance del 50% queda pendiente...",
        textInputType: TextInputType.emailAddress,
        textEditingController: subtaskProvider.ctrlRecomendacionText);
    Widget privateNoteInput = FieldForm(
        borderRadius: 8.0,
        label: "", // "Nota privada",
        hintText: "Ejm. El proyecto tiene un avance del 50% queda pendiente...",
        textInputType: TextInputType.emailAddress,
        textEditingController: subtaskProvider.ctrlNotePrivEvaluText);
    Widget dateRevisionInput = InputPrimary(
      hintText: "dd/mm/aaaa",
      label: "Fecha de revisión:",
      maxLength: 10,
      textEditingController: subtaskProvider.dateOfRevisionEvalText,
      onChanged: (value) {
        subtaskProvider.dateOfRevisionEvalText.value;
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
                              subtaskProvider.dateOfRevisionEval = newDate;
                            },
                          ),
                        ),
                        CupertinoButton(
                          child: const Text('Hecho'),
                          onPressed: () {
                            Navigator.of(context).pop();
                            subtaskProvider.dateOfRevisionEvalText.text =
                                Helpers.dateToStringTimeDMY(
                                    subtaskProvider.dateOfRevisionEval);
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
                subtaskProvider.dateOfRevisionEvalText.text =
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
      textEditingController: subtaskProvider.dateOfDeliveryEvalText,
      onChanged: (value) {
        subtaskProvider.dateOfDeliveryEvalText.value;
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
                              subtaskProvider.dateOfDeliveryEval = newDate;
                            },
                          ),
                        ),
                        CupertinoButton(
                          child: const Text('Hecho'),
                          onPressed: () {
                            Navigator.of(context).pop();
                            subtaskProvider.dateOfDeliveryEvalText.text =
                                Helpers.dateToStringTimeDMY(
                                    subtaskProvider.dateOfDeliveryEval);
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
                subtaskProvider.dateOfDeliveryEvalText.text =
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
        value: subtaskProvider.independenceResults,
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
          subtaskProvider.updateIndependenceResults(value);
        },
        items: subtaskProvider.listQualityOfWork
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
        value: subtaskProvider.workInTeam,
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
          subtaskProvider.updateWorkInTeam(value);
        },
        items: subtaskProvider.listQualityOfWork
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
        value: subtaskProvider.qualityOfWork,
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
          subtaskProvider.updateQualityOfWork(value);
        },
        items: subtaskProvider.listQualityOfWork
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
          await subtaskProvider.postProcCreateNote(
              pQualityOfWork: subtaskProvider.qualityOfWork,
              pWorkInTeam: subtaskProvider.workInTeam,
              pIndependenceResult: subtaskProvider.independenceResults,
              pDateClose: subtaskProvider.dateOfDeliveryEvalText.text,
              pDateOfReview: subtaskProvider.dateOfRevisionEvalText.text,
              pPrivateNote: subtaskProvider.ctrlNotePrivEvaluText.text,
              pRecommendation: subtaskProvider.ctrlRecomendacionText.text);

          subtaskProvider.qualityOfWork = 'Esperado';
          subtaskProvider.workInTeam = 'Esperado';
          subtaskProvider.independenceResults = 'Esperado';
          subtaskProvider.dateOfDeliveryEvalText.text =
              Helpers.dateToStringTimeDMY(DateTime.now());
          subtaskProvider.dateOfRevisionEvalText.text =
              subtaskProvider.dateOfDeliveryEvalText.text;
          subtaskProvider.ctrlNotePrivEvaluText.text = '';
          subtaskProvider.ctrlRecomendacionText.text = '';
          if (subtaskProvider.isCreatingNote == false) {
            Navigator.pop(context);
          }
        })
      ],
    );
  }
}
