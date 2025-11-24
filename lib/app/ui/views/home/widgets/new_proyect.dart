import 'dart:io';

import 'package:app_tasking/app/ui/components/btn/btn_cancel_second.dart';
import 'package:app_tasking/app/ui/components/btn/btn_save_second.dart';
import 'package:app_tasking/app/ui/components/custom_cupertino_date.dart';
import 'package:app_tasking/app/ui/components/dropdown/custom_dropdown_button.dart';
import 'package:app_tasking/app/ui/components/input/field_form.dart';
import 'package:app_tasking/app/ui/components/icon_wrapper.dart';
import 'package:app_tasking/app/ui/components/input_primary.dart';
import 'package:app_tasking/app/ui/views/home/home_provider.dart';
import 'package:app_tasking/app/ui/views/subtask/widgets/file_control.dart';
import 'package:app_tasking/core/helpers/constant.dart';
import 'package:app_tasking/core/helpers/helpers.dart';
import 'package:app_tasking/core/theme/app_colors.dart';
import 'package:app_tasking/core/theme/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:provider/provider.dart';

class NewProyect extends StatelessWidget {
  const NewProyect({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final homeProvider = Provider.of<HomeProvider>(context);
    Widget tittleInput = FieldForm(
        label: "Título de proyecto",
        maxlines: 2,
        hintText: "Ejm. Proyecto de mejora continua.",
        textInputType: TextInputType.emailAddress,
        textEditingController: homeProvider.tittleProyect);
    Widget descriptionInput = FieldForm(
        label: "Descripción",
        maxlines: 2,
        hintText:
            "Ejm. Esta iniciativa que tiene como objetivo lograr mejoras progresivas...",
        textInputType: TextInputType.emailAddress,
        textEditingController: homeProvider.descriptionProyect);
    Widget selectColor = Row(
      children: homeProvider.colors.map((color) {
        bool isSelected = homeProvider.selectedColor == color;
        return GestureDetector(
          onTap: () {
            homeProvider.updateselectedColor(color);
          },
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 4),
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: color,
                width: 2,
              ),
              color: isSelected ? color.withOpacity(0.5) : Colors.transparent,
            ),
          ),
        );
      }).toList(),
    );
    Widget startDateInput = InputPrimary(
      readOnly: true,
      hintText: "dd/mm/aaaa",
      label: "Fecha de inicio:",
      maxLength: 10,
      textEditingController: homeProvider.startDateText,
      onChanged: (value) {
        homeProvider.startDateText.value;
      },
      inputFormats: [
        FilteringTextInputFormatter.allow(RegExp(r'[0-9\/]')),
      ],
      suffixIcon: IconWrapper(
          onTap: () async {
            if (Platform.isIOS) {
              CustomCupertinoDate.showCupertinoModal(context,
                  title: "Selecciona una fecha",
                  onChanged: (DateTime date) => homeProvider.startDate = date,
                  onPressed: (_) => homeProvider.startDateText.text =
                      Helpers.dateToStringTimeDMY(homeProvider.startDate));
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
                // subtaskController.dateOfControlText.text =
                //     Helpers.dateToStringTimeDMY(pickdateInicio);
              }
            }
          },
          child: Icon(
            Iconsax.calendar_1_bold,
            color: AppColors.primary(context),
          )),
    );
    Widget endDateInput = InputPrimary(
      readOnly: true,
      hintText: "dd/mm/aaaa",
      label: "Fecha de fin:",
      maxLength: 10,
      textEditingController: homeProvider.endDateText,
      onChanged: (value) {
        homeProvider.endDateText.value;
      },
      inputFormats: [
        FilteringTextInputFormatter.allow(RegExp(r'[0-9\/]')),
      ],
      suffixIcon: IconWrapper(
          onTap: () async {
            if (Platform.isIOS) {
              CustomCupertinoDate.showCupertinoModal(context,
                  title: "Selecciona una fecha",
                  onChanged: (DateTime date) => homeProvider.endDate = date,
                  onPressed: (_) => homeProvider.endDateText.text =
                      Helpers.dateToStringTimeDMY(homeProvider.endDate));
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
                homeProvider.endDateText.text =
                    Helpers.dateToStringTimeDMY(homeProvider.endDate);
              }
            }
          },
          child: Icon(
            Iconsax.calendar_1_bold,
            color: AppColors.primary(context),
          )),
    );
    Widget priorityInput = CustomDropdownButton(
      initialValue: homeProvider.priority,
      onChanged: (value) {
        homeProvider.updatePriority(value);
      },
      items: homeProvider.listPriority,
    );
    Widget responsibleInput = CustomDropdownButton(
      initialValue: homeProvider.priority,
      onChanged: (value) {
        homeProvider.updatePriority(value);
      },
      items: homeProvider.listPriority,
    );
    Widget supervisorInput = CustomDropdownButton(
      initialValue: homeProvider.priority,
      onChanged: (value) {
        homeProvider.updatePriority(value);
      },
      items: homeProvider.listPriority,
    );
    Widget workSpaceInput = CustomDropdownButton(
      initialValue: homeProvider.priority,
      onChanged: (value) {
        homeProvider.updatePriority(value);
      },
      items: homeProvider.listPriority,
    );
    // onTap: () => FocusScope.of(context).unfocus(),
    return Scaffold(
       appBar: AppBar(
          backgroundColor: AppColors.primary(context),
        ),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 10.0.h, horizontal: 10.0.w),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            spacing: 10.0.h,
            children: [
              Column(
                spacing: 4.0.h,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Titulo",
                      style: AppTextStyle(context).bold13(
                        color: AppColors.textBasic(context),
                      )),
                  tittleInput
                ],
              ),
              SizedBox(),
              Column(
                // spacing: 4.0.h,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () => homeProvider.showDescription(),
                        child: Text("Descripción",
                            style: AppTextStyle(context).bold13(
                              color: AppColors.primary(context),
                            )),
                      ),
                      InkWell(
                        onTap: () => homeProvider.showParticipants(),
                        child: Text("Participantes",
                            style: AppTextStyle(context).bold13(
                              color: AppColors.primary(context),
                            )),
                      ),
                      InkWell(
                        onTap: () => homeProvider.showIshighPriority(),
                        child: Row(
                          spacing: 2.0,
                          children: [
                            Text("Alta prioridad",
                                style: AppTextStyle(context).bold13(
                                  color: AppColors.primary(context),
                                )),
                            Icon(
                              Bootstrap.fire,
                              color: homeProvider.ishighPriority
                                  ? Colors.orange
                                  : AppColors.primary(context),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                  homeProvider.isActiveDescription
                      ? Column(
                          spacing: 5.0.h,
                          children: [
                            descriptionInput,
                            FileControl(),
                          ],
                        )
                      : const SizedBox()
                ],
              ),
              SizedBox(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    spacing: 5.0.w,
                    children: [
                      const Icon(Icons.palette), // Icono de paleta
                      Text('Asignar color:',
                          style: AppTextStyle(context).bold13(
                            color: AppColors.textBasic(context),
                          )),
                    ],
                  ),
                  selectColor
                ],
              ),
              SizedBox(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    spacing: 5.0.w,
                    children: [
                      Icon(Bootstrap.fire),
                      Text("Priodidad",
                          style: AppTextStyle(context).bold13(
                            color: AppColors.textBasic(context),
                          )),
                    ],
                  ),
                  SizedBox(width: 150, child: priorityInput)
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    spacing: 5.0.w,
                    children: [
                      Icon(Bootstrap.person_lines_fill),
                      Text("Responsable:",
                          style: AppTextStyle(context).bold13(
                            color: AppColors.textBasic(context),
                          )),
                    ],
                  ),
                  SizedBox(width: 150.0.w, child: responsibleInput)
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    spacing: 5.0.w,
                    children: [
                      Icon(Bootstrap.person_lines_fill),
                      Text("Supervisor:",
                          style: AppTextStyle(context).bold13(
                            color: AppColors.textBasic(context),
                          )),
                    ],
                  ),
                  SizedBox(width: 150.0.w, child: supervisorInput),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    spacing: 5.0.w,
                    children: [
                      Icon(Bootstrap.calendar_check),
                      Text("Fecha de inicio:",
                          style: AppTextStyle(context).bold13(
                            color: AppColors.textBasic(context),
                          )),
                    ],
                  ),
                  SizedBox(width: 150.0.w, child: startDateInput)
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    spacing: 5.0.w,
                    children: [
                      Icon(Bootstrap.calendar_check),
                      Text("Fecha de fin:",
                          style: AppTextStyle(context).bold13(
                            color: AppColors.textBasic(context),
                          )),
                    ],
                  ),
                  SizedBox(width: 150.0.w, child: endDateInput)
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    spacing: 5.0.w,
                    children: [
                      Icon(Bootstrap.globe_americas),
                      Text("Espacio de trabajo:",
                          style: AppTextStyle(context).bold13(
                            color: AppColors.textBasic(context),
                          )),
                    ],
                  ),
                  SizedBox(width: 150.0.w, child: workSpaceInput)
                ],
              ),
              homeProvider.isShowParticipants
                  ? Row(
                      children: [
                        Row(
                          spacing: 5.0.w,
                          children: [
                            Icon(Bootstrap.people_fill),
                            Text("Participantes:",
                                style: AppTextStyle(context).bold13(
                                  color: AppColors.textBasic(context),
                                ))
                          ],
                        ),
                      ],
                    )
                  : const SizedBox(),
                  
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                        width: 150.0.w,
                        child: BtnSaveSecond(
                          loading: false,
                          text:
                              "Guardar", // subtaskController.isCreatingNote ? 'Enviando' : 'Guardar',
                          showBoxShadow: false,
                          onTap: () {},
                        )),
                    SizedBox(
                        width: 150.0.w,
                        child: BtnCancelSecond(
                          text: 'Cancelar',
                          onTap: () => Navigator.pop(context),
                        ))
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}
