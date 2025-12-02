import 'package:app_tasking/app/ui/components/btn/btn_cancel_second.dart';
import 'package:app_tasking/app/ui/components/btn/btn_save_second.dart';
import 'package:app_tasking/app/ui/components/dropdown/dropdown_select.dart';
import 'package:app_tasking/app/ui/components/dropdown/option_select.dart';
import 'package:app_tasking/app/ui/components/dropdown/search_inner_widget.dart';
import 'package:app_tasking/app/ui/components/icon_wrapper.dart';
import 'package:app_tasking/app/ui/components/input/input_date.dart';
import 'package:app_tasking/app/ui/components/input/input_description.dart';
import 'package:app_tasking/app/ui/components/input/input_gen.dart';
import 'package:app_tasking/app/ui/components/input/input_tittle.dart';
import 'package:app_tasking/app/ui/components/rotating_icon.dart';
import 'package:app_tasking/app/ui/views/meet/meet_provider.dart';
import 'package:app_tasking/app/ui/views/meet/widgets/list_person_selected.dart';
import 'package:app_tasking/app/ui/views/meet/widgets/new_agenda.dart';
import 'package:app_tasking/app/ui/components/input/web_date_picker_field.dart';
import 'package:app_tasking/core/helpers/constant.dart';
import 'package:app_tasking/core/helpers/helpers.dart';
import 'package:app_tasking/core/theme/app_colors.dart';
import 'package:app_tasking/core/theme/app_text_style.dart';
import 'package:app_tasking/domain/entities/area.dart';
import 'package:app_tasking/domain/entities/person.dart';
import 'package:app_tasking/domain/entities/project.dart';
import 'package:app_tasking/infrastructure/models/option__select_model.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:duration_picker/duration_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:provider/provider.dart';

class NewMeet extends StatelessWidget {
  const NewMeet({super.key});

  @override
  Widget build(BuildContext context) {
    final meetProvider = Provider.of<MeetProvider>(context);

    Widget selectColor = Row(
      children: meetProvider.colors.map((color) {
        bool isSelected = meetProvider.selectedColor == color;
        return GestureDetector(
          onTap: () {
            meetProvider.updateselectedColor(color);
          },
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 4),
            width: 18.0,
            height: 18.0,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: color, width: 2),
              color: isSelected ? color.withValues() : Colors.transparent,
            ),
          ),
        );
      }).toList(),
    );

    Widget tittleInput = InputTittle(
      hintText: 'Acuerdos del proyecto de inversión...',
      labelText: '',
      textEditingController: meetProvider.tittleMeet,
      onChanged: (value) {
        meetProvider.tittleMeet.value;
      },
    );

    Widget subjectInput = InputDescription(
      hintText:
          'Definir los acuerdos y compromisos clave del proyecto de inversión, estableciendo plazos, responsabilidades y próximos pasos.',
      labelText: '',
      textEditingController: meetProvider.subjectMeet,
      onChanged: (value) {
        meetProvider.subjectMeet.value;
      },
    );

    Widget typeOfMeet = DropdownSelect(
      helperText: 'Tipo de reunión',
      icon:
          meetProvider.typeOfMeet.id == '0' ? Bootstrap.unlock : Bootstrap.lock,
      value: meetProvider.listTypeOfMeet.firstWhere(
        (element) => element.id == meetProvider.typeOfMeet.id,
        orElse: () => meetProvider.listTypeOfMeet.first, // valor por defecto
      ),
      items: meetProvider.listTypeOfMeet.map((element) {
        return DropdownMenuItem(
          value: element,
          child: OptionSelect(
            nameOption: element.text,
          ),
        );
      }).toList(),
      onChanged: (newValue) {
        meetProvider.updateTypeOfMeet();
        meetProvider.typeOfMeet = newValue as OptionSelectModel;
      },
    );

    Widget modeOfMeet = DropdownSelect(
      // helperText: 'Modalidad:',
      // icon: Bootstrap.pc_display_horizontal,
      value: meetProvider.listModeOfMeet.firstWhere(
        (element) => element.id == meetProvider.modeOfMeet.id,
        orElse: () => meetProvider.listModeOfMeet.first, // valor por defecto
      ),
      items: meetProvider.listModeOfMeet.map((element) {
        return DropdownMenuItem(
          value: element,
          child: OptionSelect(
            nameOption: element.text,
          ),
        );
      }).toList(),
      onChanged: (newValue) {
        meetProvider.modeOfMeet = newValue as OptionSelectModel;
        meetProvider.justUpdateUi();
      },
    );

    Widget placeMeet = DropdownSelect(
      // helperText: 'Lugar:',
      // icon: Bootstrap.geo_alt,
      value: meetProvider.listPlaceMeet.firstWhere(
        (element) => element.id == meetProvider.placeMeet.id,
        orElse: () => meetProvider.listModeOfMeet.first, // valor por defecto
      ),
      items: meetProvider.listPlaceMeet.map((element) {
        return DropdownMenuItem(
          value: element,
          child: OptionSelect(
            nameOption: element.text,
          ),
        );
      }).toList(),
      onChanged: (newValue) {
        meetProvider.placeMeet = newValue as OptionSelectModel;
      },
    );

    return SizedBox(
      height: 800.0,
      child: /*  Scaffold(
        // backgroundColor: Colors.transparent,
        body: */
          meetProvider.isLoadOnInit
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : Container(
                  color: AppColors.firstBackgroundContainer(context),
                  padding: const EdgeInsets.symmetric(
                      vertical: 10.0, horizontal: 10.0),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      spacing: 10.0,
                      children: [
                        if (meetProvider.showAdvanceInputs)
                          contentWithVerticalLine(
                            context,
                            Row(
                              children: [
                                SizedBox(
                                  width: 400,
                                  child: Row(
                                    children: [
                                      _customsubTittle(
                                        Bootstrap.palette,
                                        'Asignar color:',
                                        context,
                                      ),
                                      Expanded(child: selectColor)
                                    ],
                                  ),
                                ),
                                SizedBox(width: 250.0, child: typeOfMeet)
                              ],
                            ),
                          ),
                        contentWithVerticalLine(
                          context,
                          Row(
                            children: [
                              _customsubTittle(
                                Bootstrap.book,
                                'Título de la reunión:',
                                context,
                              ),
                              Expanded(child: tittleInput)
                            ],
                          ),
                        ),
                        contentWithVerticalLine(
                          context,
                          Row(
                            children: [
                              _customsubTittle(
                                Bootstrap.journal_text,
                                'Descripción:',
                                context,
                              ),
                              Expanded(child: subjectInput)
                            ],
                          ),
                        ),
                        if (meetProvider.showAdvanceInputs)
                          contentWithVerticalLine(
                            context,
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              spacing: 30.0,
                              children: [
                                Row(
                                  children: [
                                    _customsubTittle(
                                      Bootstrap.pc_display_horizontal,
                                      'Modalidad:',
                                      context,
                                    ),
                                    SizedBox(width: 300, child: modeOfMeet)
                                  ],
                                ),
                                if (meetProvider.modeOfMeet.id != '1')
                                  Row(
                                    children: [
                                      _secondColumnInRow(
                                        Bootstrap.geo_alt,
                                        'Paltaforma:',
                                        context,
                                      ),
                                      SizedBox(width: 300, child: placeMeet)
                                    ],
                                  ),
                                Row(
                                  children: [
                                    _secondColumnInRow(
                                      Bootstrap.geo,
                                      'Especificar lugar',
                                      context,
                                    ),
                                    SizedBox(
                                        width: 250, child: meetingPlaceOther()),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        if (meetProvider.showAdvanceInputs)
                          contentWithVerticalLine(
                            context,
                            Row(
                              spacing: 30.0,
                              children: [
                                Row(
                                  children: [
                                    _customsubTittle(
                                      Bootstrap.star,
                                      'Espacio de trabajo:',
                                      context,
                                    ),
                                    SizedBox(width: 300, child: clientMeet())
                                  ],
                                ),
                                // SizedBox(
                                //     width: 400.0,
                                //     height: heightInputs,
                                //     child: clientMeet()),
                                Row(
                                  children: [
                                    _secondColumnInRow(
                                      Bootstrap.duffle,
                                      'Proyecto:',
                                      context,
                                    ),
                                    SizedBox(width: 300, child: projectMeet())
                                  ],
                                ),

                                // SizedBox(
                                //     width: 300.0,
                                //     height: heightInputs,
                                //     child: projectMeet()),
                              ],
                            ),
                          ),
                        if (meetProvider.showAdvanceInputs)
                          contentWithVerticalLine(
                            context,
                            Row(
                              children: [
                                _customsubTittle(
                                  Bootstrap.person_raised_hand,
                                  'Responsable:',
                                  context,
                                ),
                                SizedBox(width: 300, child: responsibleInput())
                              ],
                            ),
                          ),
                        contentWithVerticalLine(
                          context,
                          Row(
                            spacing: 10.0,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Row(
                                children: [
                                  _customsubTittle(
                                    Bootstrap.people_fill,
                                    'Participantes:',
                                    context,
                                  ),
                                  SizedBox(
                                      width: 300, child: participantsInput())
                                ],
                              ),

                              // SizedBox(
                              //     width: 350.0,
                              //     height: heightInputs,
                              //     child: participantsInput()),
                              const Expanded(child: ListPersonSelected())
                            ],
                          ),
                        ),
                        contentWithVerticalLine(
                          context,
                          Row(
                            spacing: 30.0,
                            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                  width: 250.0,
                                  // height: heightInputs,
                                  child: WebDatePickerField(
                                    helperText: 'Fecha',
                                    icon: Bootstrap.calendar_event,
                                    controller: context
                                        .read<MeetProvider>()
                                        .ctrlDateMeet,
                                    onDateSelected: (range) {
                                      // print('Seleccionado: ${range.start}');
                                      // meetProvider.justUpdateUi();
                                    },
                                  )),
                              SizedBox(width: 250.0, child: timeMeet(context)),
                              SizedBox(
                                  width: 250.0, child: durationMeet(context)),
                            ],
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: TextButton.icon(
                            onPressed: () =>
                                meetProvider.showAdvanceInputMeet(),
                            label: Text('Avanzado',
                                style: AppTextStyle(context).bold15(
                                    color: AppColors.secondary(context))),
                            icon: RotatingIcon(
                              expanded: meetProvider.showAdvanceInputs,
                              icon: Bootstrap.caret_down_fill,
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: TextButton.icon(
                            onPressed: () => meetProvider.changeWithAgenda(),
                            label: Text('Agenda',
                                style: AppTextStyle(context).bold15(
                                    color: AppColors.secondary(context))),
                            icon: RotatingIcon(
                              expanded: meetProvider.withAgenda,
                              icon: Bootstrap.caret_down_fill,
                            ),
                          ),
                        ),
                        meetProvider.withAgenda
                            ? const NewAgenda()
                            : const SizedBox()
                      ],
                    ),
                  ),
                ),
    );
  }
}

Widget _customIcon(IconData icon, {Color? color}) {
  return Icon(icon, size: 15.0, color: color);
}

Widget _customLabel(String text, BuildContext context) {
  return Text(
    text,
    style: AppTextStyle(context).bold13(color: AppColors.textBasic(context)),
  );
}

Widget _customsubTittle(IconData icon, String text, BuildContext context) {
  return SizedBox(
    width: 200.0,
    child: Row(
      spacing: 8.0,
      children: [_customIcon(icon), _customLabel(text, context)],
    ),
  );
}

Widget _secondColumnInRow(IconData icon, String text, BuildContext context) {
  return SizedBox(
    width: 130.0,
    child: Row(
      spacing: 8.0,
      children: [_customIcon(icon), _customLabel(text, context)],
    ),
  );
}

Widget _customTextLink(Function function, String text, BuildContext context) {
  return InkWell(
    onTap: () => function(),
    child: Text(
      text,
      style: AppTextStyle(context).bold13(color: AppColors.primary(context)),
    ),
  );
}

Widget _customContainer(BuildContext context, Widget child) {
  return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 15.0,
        vertical: 20.0,
      ),
      decoration: BoxDecoration(
        color: AppColors.backgroundColor(context),
        borderRadius: BorderRadius.circular(8.0),
        // boxShadow: [AppColors.boxShadowGeneral],
      ),
      child: child);
}

class TimeTextInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    var text = newValue.text.replaceAll(":", "");

    if (text.length > 4) {
      text = text.substring(0, 4);
    }

    String formatted = text;
    if (text.length >= 3) {
      formatted = text.substring(0, 2) + ':' + text.substring(2);
    }

    return TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(offset: formatted.length),
    );
  }
}

Widget clientMeet() {
  final searchController = TextEditingController();
  return Consumer<MeetProvider>(builder: (context, meetProvider, _) {
    return DropdownSelect(
      // helperText: 'Espacio de trabajo:',
      // icon: Bootstrap.star,
      value: meetProvider.listClient.firstWhere(
        (element) => element.clienteId == meetProvider.clientMeet.clienteId,
        orElse: () => meetProvider.listClient.first, // valor por defecto
      ),
      items: meetProvider.listClient.map((element) {
        return DropdownMenuItem(
          value: element,
          child: OptionSelect(
            nameOption:
                element.clienteNombre ?? element.clienteRazonSocial ?? '',
          ),
        );
      }).toList(),
      dropdownSearchData: DropdownSearchData<Area>(
          searchController: searchController,
          searchInnerWidgetHeight: kDropdownHeight,
          searchInnerWidget: SearchInnerWidget(
            searchController: searchController,
            hintText: 'Buscar cliente...',
          ),
          searchMatchFn: (item, searchValue) {
            final p = item.value as Area;
            return p.clienteNombre!
                .toLowerCase()
                .contains(searchValue.toLowerCase());
          }),
      onChanged: (newValue) {
        meetProvider.clientMeet = newValue as Area;
        meetProvider.getListProjects(meetProvider.clientMeet.clienteId);
      },
    );
  });
}

Widget projectMeet() {
  final searchController = TextEditingController();
  return Consumer<MeetProvider>(
    builder: (context, meetProvider, _) {
      final list = meetProvider.listProjects;
      // Project? current = meetProvider.projectMeet;
      // Asegurar que el value actual exista en la lista
      // if (current == null ||
      //     !list.any((p) => p.campanaid == current!.campanaid)) {
      //   current = list.isNotEmpty ? list.first : null;
      //   meetProvider.projectMeet = current!; // actualizar provider
      // }
      // if (meetProvider.isGettingListProjects) {
      //   return const Center(
      //     child: CircularProgressIndicator(),
      //   );
      // }
      // Caso cuando la lista está vacía
      if (list.isEmpty || meetProvider.isGettingListProjects) {
        return const DropdownSelect(
          label: 'Proyecto',
          hint:
              'Seleccione un espacio de trabajo para ver los proyectos disponibles',
          value: null,
          items: [],
          // enabled: false, // Deshabilitado
        );
      }

      return DropdownSelect(
        // helperText: 'Proyecto:',
        // icon: Bootstrap.duffle,
        value: list.firstWhere(
          (element) => element.campanaid == meetProvider.projectMeet.campanaid,
          orElse: () => list.first, // valor por defecto
        ),
        items: list.map((element) {
          return DropdownMenuItem(
            value: element,
            child: OptionSelect(
              nameOption: element.campanaNombre ?? '',
            ),
          );
        }).toList(),
        dropdownSearchData: DropdownSearchData<Project>(
          searchController: searchController,
          searchInnerWidgetHeight: kDropdownHeight,
          searchInnerWidget: SearchInnerWidget(
            searchController: searchController,
            hintText: 'Buscar espacio de trabajo...',
          ),
          searchMatchFn: (item, searchValue) {
            final p = item.value as Project;
            return p.campanaNombre!
                .toLowerCase()
                .contains(searchValue.toLowerCase());
          },
        ),
        onMenuStateChange: (isOpen) {
          if (!isOpen) {
            searchController.clear();
          }
        },
        onChanged: (newValue) {
          meetProvider.projectMeet = newValue as Project;
        },
      );
    },
  );
}

Widget responsibleInput() {
  final searchController = TextEditingController();
  return Consumer<MeetProvider>(builder: (context, meetProvider, _) {
    print("ValueId: ${meetProvider.personResponsible.personalId}");
    return DropdownSelect(
      value: meetProvider.listPersonResponsible.firstWhere(
        (element) =>
            element.personalId == meetProvider.personResponsible.personalId,
        orElse: () =>
            meetProvider.listPersonResponsible.first, // valor por defecto
      ),
      items: meetProvider.listPersonResponsible.map((element) {
        return DropdownMenuItem(
          value: element,
          child: OptionSelect(
            nameOption: element.personalNombreCompleto,
          ),
        );
      }).toList(),
      dropdownSearchData: DropdownSearchData<Person>(
        searchController: searchController,
        searchInnerWidgetHeight: kDropdownHeight,
        searchInnerWidget: SearchInnerWidget(
          searchController: searchController,
          hintText: 'Buscar persona...',
        ),
        searchMatchFn: (item, searchValue) {
          final p = item.value as Person;
          return p.personalNombreCompleto!
              .toLowerCase()
              .contains(searchValue.toLowerCase());
        },
      ),
      onMenuStateChange: (isOpen) {
        if (!isOpen) {
          searchController.clear();
        }
      },
      onChanged: (newValue) {
        final person = newValue as Person;
        if (person.personalId == meetProvider.personResponsible.personalId) {
          return;
        }
        meetProvider.removeAndAddPersonToAgenda(
            meetProvider.personResponsible, newValue);
        meetProvider.personResponsible = person;
      },
    );
  });
}

Widget participantsInput() {
  final searchController = TextEditingController();
  return Consumer<MeetProvider>(
    builder: (context, meetProvider, child) {
      return DropdownSelect(
        // helperText: 'Participantes',
        icon: Bootstrap.people,
        value: meetProvider.listPerson.firstWhere(
          (element) => element.personalId == meetProvider.person.personalId,
          orElse: () => meetProvider.listPerson.first, // valor por defecto
        ),
        items: meetProvider.listPerson.map((element) {
          return DropdownMenuItem(
            value: element,
            child: OptionSelect(
              nameOption: element.personalNombreCompleto,
            ),
          );
        }).toList(),
        dropdownSearchData: DropdownSearchData<Person>(
          searchController: searchController,
          searchInnerWidgetHeight: kDropdownHeight,
          searchInnerWidget: SearchInnerWidget(
            searchController: searchController,
            hintText: 'Buscar persona...',
          ),
          searchMatchFn: (item, searchValue) {
            final p = item.value as Person;
            return p.personalNombreCompleto!
                .toLowerCase()
                .contains(searchValue.toLowerCase());
          },
        ),
        onMenuStateChange: (isOpen) {
          if (!isOpen) {
            searchController.clear();
          }
        },
        onChanged: (newValue) {
          meetProvider.person = newValue as Person;
          meetProvider.removeOrAddPersonSelected(newValue);
          meetProvider.removeOrAddPeopleToAgenda(newValue);
        },
      );
    },
  );
}

Widget meetingPlaceOther() {
  return Consumer<MeetProvider>(builder: (context, provider, _) {
    return InputTittle(
      onChanged: (_) {},
      // labelText: 'Especificar lugar',
      hintText: 'Oficina surco...',
      textEditingController: provider.ctrlMeetingPlace,
      // hintText: hintText
    );
  });
}

Widget contentWithVerticalLine(BuildContext context, Widget child) {
  return Container(
    width: double.infinity,
    // margin: const EdgeInsets.all(
    //   0.0
    // ),
    decoration: BoxDecoration(
      color: AppColors.listProyectsColor(context),
      boxShadow: [
        BoxShadow(
          color: AppColors.shadowListColor(context),
          blurRadius: 2.0,
          spreadRadius: 0.1,
        )
      ],
      borderRadius: BorderRadius.circular(5.0),
    ),
    child: Stack(
      children: [
        Positioned.fill(
          child: Align(
            alignment: Alignment.centerLeft,
            child: Container(
              width: 5.0,
              decoration: const BoxDecoration(
                color: AppColors.secondaryConst,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(5.0),
                  bottomLeft: Radius.circular(5.0),
                ),
              ),
            ),
          ),
        ),
        Padding(
            padding: const EdgeInsetsDirectional.only(
                start: 15.0, top: 8.0, bottom: 8.0, end: 8.0),
            child: child),
      ],
    ),
  );
}

Widget timeMeet(BuildContext context) {
  final meetProvider = Provider.of<MeetProvider>(context);
  final FocusNode timeFocusNode = FocusNode();
  timeFocusNode.addListener(() {
    if (!timeFocusNode.hasFocus) {
      final text = meetProvider.ctrlTimeMeet.text.trim();

      // Solo formatear si se quedó vacío o incompleto
      meetProvider.ctrlTimeMeet.text = Helpers.normalizeTimeText(text);
    }
  });

  return InputDate(
    helperText: 'Hora:',
    icon: Bootstrap.clock,
    hintText: "00:00",
    textEditingController: meetProvider.ctrlTimeMeet,
    onChanged: (value) {
      // meetProvider.ctrlTimeMeet.value;
    },
    inputFormats: [
      FilteringTextInputFormatter.digitsOnly, // Solo números
      TimeTextInputFormatter(),
    ],
    focusNode: timeFocusNode, // ← Aquí
    suffixIcon: IconWrapper(
        onTap: () async {
          TimeOfDay? pickedTime = await showTimePicker(
            context: context,
            initialTime: TimeOfDay.now(),
          );
          if (pickedTime != null) {
            String formattedTime = Helpers.timeOfDayToString(
              pickedTime,
            ); //pickedTime.format(context);
            meetProvider.ctrlTimeMeet.text = formattedTime;
          }
        },
        child: Icon(
          Clarity.clock_solid_badged,
          size: 15.0,
          color: AppColors.primary(context),
        )),
  );
}

Widget durationMeet(BuildContext context) {
  final meetProvider = Provider.of<MeetProvider>(context);
  final FocusNode timeFocusNode = FocusNode();
  timeFocusNode.addListener(() {
    if (!timeFocusNode.hasFocus) {
      final text = meetProvider.ctrlDurationMeet.text.trim();
      meetProvider.ctrlDurationMeet.text = Helpers.normalizeDurationText(text);
    }
  });

  return InputDate(
    helperText: 'Duración:',
    icon: Bootstrap.hourglass_split,
    hintText: "00:00",
    /* label: "Tiempo",
      maxLength: 10, */
    focusNode: timeFocusNode,
    textEditingController: meetProvider.ctrlDurationMeet,
    onChanged: (value) {
      meetProvider.ctrlDurationMeet.value;
    },
    inputFormats: [
      FilteringTextInputFormatter.digitsOnly, // Solo números
      TimeTextInputFormatter(),
    ],
    /*    validator: (date) {
        return null;
      }, */
    suffixIcon: IconWrapper(
      onTap: () async {
        final resultingDuration = await showDurationPicker(
          context: context,
          initialTime: meetProvider.duration,
          baseUnit: BaseUnit.minute,
          upperBound: const Duration(hours: 8),
          lowerBound: const Duration(minutes: 15),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.0),
          ),
        );
        if (resultingDuration != null &&
            resultingDuration != meetProvider.duration) {
          meetProvider.ctrlDurationMeet.text = Helpers.formatDurationToHHMM(
            resultingDuration,
          );
        }
      },
      child: Icon(
        Clarity.clock_solid_badged,
        size: 15.0,
        color: AppColors.primary(context),
      ),
    ),
  );
}

class BtnsSaveAndCancelMeet extends StatelessWidget {
  const BtnsSaveAndCancelMeet({super.key});

  @override
  Widget build(BuildContext context) {
    final meetProvider = Provider.of<MeetProvider>(context);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
      decoration: BoxDecoration(
        color: AppColors.backgroundColor(context),
        borderRadius: BorderRadius.circular(8.0),
      ),

      // margin: EdgeInsets.only(top: 100),
      child: Row(
        spacing: 20.0,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          SizedBox(
            width: 150.0,
            child: BtnCancelSecond(
              text: 'Cancelar',
              onTap: () => Navigator.pop(context),
            ),
          ),
          SizedBox(
              width: 150.0,
              child: BtnSaveSecond(
                loading: meetProvider.isCreatingMeet,
                text: meetProvider.isCreatingMeet ? "Guardando" : 'Guardar',
                showBoxShadow: false,
                onTap: () {
                  // print('Tratando de guardar')
                  meetProvider.createMeet(context);
                },
              )),
        ],
      ),
    );
  }
}
