import 'dart:io';
import 'package:app_tasking/app/ui/components/input/field_form.dart';
import 'package:app_tasking/app/ui/components/icon_wrapper.dart';
import 'package:app_tasking/app/ui/components/input_primary.dart';
import 'package:app_tasking/app/ui/views/project/project_provider.dart';
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

class NewEvaluationProject extends StatelessWidget {
  const NewEvaluationProject({super.key});

  @override
  Widget build(BuildContext context) {
    final projectProvider = Provider.of<ProjectProvider>(context);
    Widget recomendacionInput = FieldForm(
        borderRadius: 8.0,
        label: "", //"Comentarios/Recomendación",
        // maxlines: 2,
        hintText: "Ejm. El proyecto tiene un avance del 50% queda pendiente...",
        textInputType: TextInputType.emailAddress,
        textEditingController: projectProvider.ctrlRecomendacionText);
    Widget privateNoteInput = FieldForm(
        borderRadius: 8.0,
        label: "", // "Nota privada",
        hintText: "Ejm. El proyecto tiene un avance del 50% queda pendiente...",
        textInputType: TextInputType.emailAddress,
        textEditingController: projectProvider.ctrlNotePrivEvaluText);
    Widget dateRevisionInput = InputPrimary(
      hintText: "dd/mm/aaaa",
      label: "Fecha de revisión:",
      maxLength: 10,
      textEditingController: projectProvider.dateOfRevisionEvalText,
      onChanged: (value) {
        projectProvider.dateOfRevisionEvalText.value;
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
                              projectProvider.dateOfRevisionEval = newDate;
                            },
                          ),
                        ),
                        CupertinoButton(
                          child: const Text('Hecho'),
                          onPressed: () {
                            Navigator.of(context).pop();
                            projectProvider.dateOfRevisionEvalText.text =
                                Helpers.dateToStringTimeDMY(
                                    projectProvider.dateOfRevisionEval);
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
                projectProvider.dateOfRevisionEvalText.text =
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
      textEditingController: projectProvider.dateOfDeliveryEvalText,
      onChanged: (value) {
        projectProvider.dateOfDeliveryEvalText.value;
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
                              projectProvider.dateOfDeliveryEval = newDate;
                            },
                          ),
                        ),
                        CupertinoButton(
                          child: const Text('Hecho'),
                          onPressed: () {
                            Navigator.of(context).pop();
                            projectProvider.dateOfDeliveryEvalText.text =
                                Helpers.dateToStringTimeDMY(
                                    projectProvider.dateOfDeliveryEval);
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
                projectProvider.dateOfDeliveryEvalText.text =
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
        value: projectProvider.independenceResults,
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
          projectProvider.updateIndependenceResults(value);
        },
        items: projectProvider.listQualityOfWork
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
        value: projectProvider.workInTeam,
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
          projectProvider.updateWorkInTeam(value);
        },
        items: projectProvider.listQualityOfWork
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
        value: projectProvider.qualityOfWork,
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
          projectProvider.updateQualityOfWork(value);
        },
        items: projectProvider.listQualityOfWork
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
          await projectProvider.postProcCreateNote(
              pQualityOfWork: projectProvider.qualityOfWork,
              pWorkInTeam: projectProvider.workInTeam,
              pIndependenceResult: projectProvider.independenceResults,
              pDateClose: projectProvider.dateOfDeliveryEvalText.text,
              pDateOfReview: projectProvider.dateOfRevisionEvalText.text,
              pPrivateNote: projectProvider.ctrlNotePrivEvaluText.text,
              pRecommendation: projectProvider.ctrlRecomendacionText.text);

          projectProvider.qualityOfWork = 'Esperado';
          projectProvider.workInTeam = 'Esperado';
          projectProvider.independenceResults = 'Esperado';
          projectProvider.dateOfDeliveryEvalText.text =
              Helpers.dateToStringTimeDMY(DateTime.now());
          projectProvider.dateOfRevisionEvalText.text =
              projectProvider.dateOfDeliveryEvalText.text;
          projectProvider.ctrlNotePrivEvaluText.text = '';
          projectProvider.ctrlRecomendacionText.text = '';
          if (projectProvider.isCreatingNote == false) {
            Navigator.pop(context);
          }
        })
      ],
    );
  }
}
