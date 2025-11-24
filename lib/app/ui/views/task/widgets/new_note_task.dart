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

class NewNoteTask extends StatelessWidget {
  const NewNoteTask({super.key});

  @override
  Widget build(BuildContext context) {
    final taskProvider = Provider.of<TaskProvider>(context);
    Widget noteInput = FieldForm(
        label: "Nota",
        maxlines: 2,
        hintText: "Ejm. El proyecto tiene un avance del 50% queda pendiente...",
        // textInputType: TextInputType.emailAddress,
        textEditingController: taskProvider.ctrlNoteText);
    Widget dateOfControlInput = InputPrimary(
      readOnly: true,
      hintText: "dd/mm/aaaa",
      label: "Fecha de control:",
      maxLength: 10,
      textEditingController: taskProvider.dateOfControlText,
      onChanged: (value) {
        taskProvider.dateOfControlText.value;
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
                              taskProvider.dateOfControl = newDate;
                            },
                          ),
                        ),
                        CupertinoButton(
                          child: const Text('Hecho'),
                          onPressed: () {
                            Navigator.of(context).pop();
                            taskProvider.dateOfControlText.text =
                                Helpers.dateToStringTimeDMY(
                                    taskProvider.dateOfControl);
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
                taskProvider.dateOfControlText.text =
                    Helpers.dateToStringTimeDMY(pickdateInicio);
              }
            }
          },
          child: Icon(
            Iconsax.calendar_1_bold,
            color: AppColors.primary(context),
          )),
    );

    Widget typeNote = DropdownButton<String>(
      isExpanded: true,
      value: taskProvider.typeNoteSelected,
      icon: Row(
        children: [
          Icon(Icons.arrow_downward, color: AppColors.primary(context)),
          SizedBox(
            width: 12.0,
          ),
        ],
      ),
      iconSize: 23,
      elevation: 10,
      style: TextStyle(color: AppColors.textBasic(context)),
      underline: Container(
        height: 1,
        color: AppColors.underlineColorGen,
      ),
      onChanged: (String? value) {
        taskProvider.updateTypeNoteSelected(value);
      },
      items: taskProvider.listTypeNote
          .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
    return Column(
      spacing: 10.0.h,
      mainAxisSize: MainAxisSize.min,
      children: [
        noteInput,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Tipo de nota:",
                style: AppTextStyle(context).bold13(
                  color: AppColors.textBasic(context),
                )),
            SizedBox(width: 130.0.w, child: typeNote),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Fecha de control:",
                style: AppTextStyle(context).bold13(
                  color: AppColors.textBasic(context),
                )),
            SizedBox(width: 130.0.w, child: dateOfControlInput),
          ],
        ),
        FileControl(),
        SizedBox(),
        SaveCancelButtons(onSave: () async {
          await taskProvider.postProcCreateNote(
            pComeComentario: taskProvider.ctrlNoteText.text,
            privateOrPublicNote: taskProvider.typeNoteSelected,
            pDateOfControl: taskProvider.dateOfControlText.text,
          );
          taskProvider.ctrlNoteText.clear();
          taskProvider.typeNoteSelected = 'Privado';
          taskProvider.dateOfControlText.text =
              Helpers.dateToStringTimeDMY(taskProvider.dateOfControl);
          if (taskProvider.isCreatingNote == false) {
            Navigator.pop(context);
          }
        })
      ],
    );
  }
}
