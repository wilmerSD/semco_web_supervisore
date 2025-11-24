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

class NewNoteProject extends StatelessWidget {
  const NewNoteProject({super.key});

  @override
  Widget build(BuildContext context) {
    final projectProvider = Provider.of<ProjectProvider>(context);
    Widget noteInput = FieldForm(
        label: "Nota",
        maxlines: 2,
        hintText: "Ejm. El proyecto tiene un avance del 50% queda pendiente...",
        // textInputType: TextInputType.emailAddress,
        textEditingController: projectProvider.ctrlNoteText);
    Widget dateOfControlInput = InputPrimary(
      readOnly: true,
      hintText: "dd/mm/aaaa",
      label: "Fecha de control:",
      maxLength: 10,
      textEditingController: projectProvider.dateOfControlText,
      onChanged: (value) {
        projectProvider.dateOfControlText.value;
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
                              projectProvider.dateOfControl = newDate;
                            },
                          ),
                        ),
                        CupertinoButton(
                          child: const Text('Hecho'),
                          onPressed: () {
                            Navigator.of(context).pop();
                            projectProvider.dateOfControlText.text =
                                Helpers.dateToStringTimeDMY(
                                    projectProvider.dateOfControl);
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
                projectProvider.dateOfControlText.text =
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
      value: projectProvider.typeNoteSelected,
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
        projectProvider.updateTypeNoteSelected(value);
      },
      items: projectProvider.listTypeNote
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
          await projectProvider.postProcCreateNote(
            pComeComentario: projectProvider.ctrlNoteText.text,
            privateOrPublicNote: projectProvider.typeNoteSelected,
            pDateOfControl: projectProvider.dateOfControlText.text,
          );
          projectProvider.ctrlNoteText.clear();
          projectProvider.typeNoteSelected = 'Privado';
          projectProvider.dateOfControlText.text = Helpers.dateToStringTimeDMY(projectProvider.dateOfControl);
          if(projectProvider.isCreatingNote == false){
            Navigator.pop(context);
          }
        })
      ],
    );
  }
}
