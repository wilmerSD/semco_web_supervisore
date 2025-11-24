import 'dart:io';

import 'package:app_tasking/app/ui/components/btn/btn_cancel_second.dart';
import 'package:app_tasking/app/ui/components/btn/btn_save_second.dart';
import 'package:app_tasking/app/ui/components/custom_cupertino_date.dart';
import 'package:app_tasking/app/ui/components/dropdown/custom_dropdown_button.dart';
import 'package:app_tasking/app/ui/components/input/field_form.dart';
import 'package:app_tasking/app/ui/components/icon_wrapper.dart';
import 'package:app_tasking/app/ui/components/input_primary.dart';
import 'package:app_tasking/app/ui/views/project/project_provider.dart';
import 'package:app_tasking/app/ui/views/subtask/widgets/file_control.dart';
import 'package:app_tasking/app/ui/views/task/task_provider.dart';
import 'package:app_tasking/core/helpers/constant.dart';
import 'package:app_tasking/core/helpers/helpers.dart';
import 'package:app_tasking/core/theme/app_colors.dart';
import 'package:app_tasking/core/theme/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:provider/provider.dart';

class NewTask extends StatelessWidget {
  const NewTask({super.key});

  @override
  Widget build(BuildContext context) {
    final projectProvider = Provider.of<ProjectProvider>(context);
    Widget tittleInput = FieldForm(
      label: "Título de la tarea",
      maxlines: 2,
      hintText: "Ejm. Desarrollo de proyecto de mejora continua...",
      textInputType: TextInputType.emailAddress,
      // textEditingController: homecontroller.tittleProyect
    );
    Widget descriptionInput = FieldForm(
      label: "Descripción",
      maxlines: 2,
      hintText: "Ejm. Desarrollo de proyecto de mejora continua...",
      textInputType: TextInputType.emailAddress,
      // textEditingController: projectProvider.descriptionProyect
    );
    Widget clientyInput = CustomDropdownButton(
      initialValue: projectProvider.priority,
      onChanged: (value) {
        projectProvider.updatePriority(value);
      },
      items: projectProvider.listPriority,
    );
    Widget projectInput = CustomDropdownButton(
      initialValue: projectProvider.priority,
      onChanged: (value) {
        projectProvider.updatePriority(value);
      },
      items: projectProvider.listPriority,
    );
    Widget startDateInput = InputPrimary(
      readOnly: true,
      hintText: "dd/mm/aaaa",
      label: "Fecha de inicio:",
      maxLength: 10,
      // textEditingController: homecontroller.startDateText,
      // onChanged: (value) {
      //   homecontroller.startDateText.value;
      // },
      inputFormats: [
        FilteringTextInputFormatter.allow(RegExp(r'[0-9\/]')),
      ],
      suffixIcon: IconWrapper(
          onTap: () async {
            if (Platform.isIOS) {
              CustomCupertinoDate.showCupertinoModal(context,
                  title: "Selecciona una fecha",
                  onChanged: (DateTime date) => projectProvider.startDate = date,
                  onPressed: (_) => projectProvider.startDateText.text =
                      Helpers.dateToStringTimeDMY(projectProvider.startDate));
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
      // textEditingController: homecontroller.endDateText,
      onChanged: (value) {
        // homecontroller.endDateText.value;
      },
      inputFormats: [
        FilteringTextInputFormatter.allow(RegExp(r'[0-9\/]')),
      ],
      suffixIcon: IconWrapper(
          onTap: () async {
            if (Platform.isIOS) {
              CustomCupertinoDate.showCupertinoModal(context,
                  title: "Selecciona una fecha",
                  onChanged: (DateTime date) => projectProvider.endDate = date,
                  onPressed: (_) => projectProvider.endDateText.text =
                      Helpers.dateToStringTimeDMY(projectProvider.endDate));
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
                projectProvider.endDateText.text =
                    Helpers.dateToStringTimeDMY(projectProvider.endDate);
              }
            }
          },
          child: Icon(
            Iconsax.calendar_1_bold,
            color: AppColors.primary(context),
          )),
    );
    Widget responsibleInput = CustomDropdownButton(
      initialValue: projectProvider.priority,
      onChanged: (value) {
        projectProvider.updatePriority(value);
      },
      items: projectProvider.listPriority,
    );
    Widget supervisorInput = CustomDropdownButton(
      initialValue: projectProvider.priority,
      onChanged: (value) {
        projectProvider.updatePriority(value);
      },
      items: projectProvider.listPriority,
    );
    Widget participantsInput = CustomDropdownButton(
      initialValue: projectProvider.priority,
      onChanged: (value) {
        projectProvider.updatePriority(value);
      },
      items: projectProvider.listPriority,
    );
    Widget priorityInput = CustomDropdownButton(
      initialValue: projectProvider.priority,
      onChanged: (value) {
        projectProvider.updatePriority(value);
      },
      items: projectProvider.listPriority,
    );
    // onTap: () => FocusScope.of(context).unfocus(),
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
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
                  spacing: 10.0.h,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: () => projectProvider.showDescription(),
                          child: Text("Descripción",
                              style: AppTextStyle(context).bold13(
                                color: AppColors.primary(context),
                              )),
                        ),
                        InkWell(
                          onTap: () => projectProvider.showParticipants(),
                          child: Text("Convertir en Subtarea",
                              style: AppTextStyle(context).bold13(
                                color: AppColors.primary(context),
                              )),
                        ),
                        InkWell(
                          onTap: () => projectProvider.showParticipants(),
                          child: Text("Supervisor",
                              style: AppTextStyle(context).bold13(
                                color: AppColors.primary(context),
                              )),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: () => projectProvider.showParticipants(),
                          child: Text("Participantes",
                              style: AppTextStyle(context).bold13(
                                color: AppColors.primary(context),
                              )),
                        ),
                        InkWell(
                          onTap: () => projectProvider.showIshighPriority(),
                          child: Row(
                            spacing: 2.0,
                            children: [
                              Text("Alta prioridad",
                                  style: AppTextStyle(context).bold13(
                                    color: AppColors.primary(context),
                                  )),
                              Icon(
                                Bootstrap.fire,
                                color: projectProvider.ishighPriority
                                    ? Colors.orange
                                    : AppColors.primary(context),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                    projectProvider.isActiveDescription
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
                        const Icon(Bootstrap.globe_americas),
                        Text("Cliente:",
                            style: AppTextStyle(context).bold13(
                              color: AppColors.textBasic(context),
                            )),
                      ],
                    ),
                    SizedBox(width: 150.0.w, child: clientyInput)
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      spacing: 5.0.w,
                      children: [
                        const Icon(Bootstrap.briefcase),
                        Text("Proyecto:",
                            style: AppTextStyle(context).bold13(
                              color: AppColors.textBasic(context),
                            )),
                      ],
                    ),
                    SizedBox(width: 150.0.w, child: projectInput)
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
                projectProvider.isShowParticipants
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
                              "Guardar", // subprojectProvider.isCreatingNote ? 'Enviando' : 'Guardar',
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
      ),
    );
  }
}
