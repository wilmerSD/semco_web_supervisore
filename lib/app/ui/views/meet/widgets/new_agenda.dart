import 'package:app_tasking/app/providers/project_provider.dart';
import 'package:app_tasking/app/ui/components/btn/btn_add.dart';
import 'package:app_tasking/app/ui/components/btn/btn_cancel_third.dart';
import 'package:app_tasking/app/ui/components/custom_icon_button.dart';
import 'package:app_tasking/app/ui/components/dropdown/dropdown_select.dart';
import 'package:app_tasking/app/ui/components/dropdown/option_select.dart';
import 'package:app_tasking/app/ui/components/input/input_tittle.dart';
import 'package:app_tasking/app/ui/views/meet/meet_provider.dart';
import 'package:app_tasking/app/ui/views/meet/widgets/table_agenda.dart';
import 'package:app_tasking/core/theme/app_colors.dart';
import 'package:app_tasking/domain/entities/agenda.dart';
import 'package:app_tasking/domain/entities/meet.dart';
import 'package:app_tasking/domain/entities/person.dart';
import 'package:app_tasking/domain/entities/project.dart';
import 'package:app_tasking/domain/entities/task.dart';
import 'package:app_tasking/infrastructure/models/option__select_model.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:provider/provider.dart';

class NewAgenda extends StatelessWidget {
  const NewAgenda({super.key});

  @override
  Widget build(BuildContext context) {
    final meetProvider = Provider.of<MeetProvider>(context);
    return Column(
      spacing: 10.0,
      children: [
        // SizedBox(
        //   height: (meetProvider.listAgendaAdd.length * 56.0) +
        //       60, // 56 px por fila aprox
        //   child: ClipRRect(
        //     /* borderRadius: const BorderRadius.only(
        //       topLeft: Radius.circular(10),
        //       topRight: Radius.circular(10.0),
        //     ), */
        //     // borderRadius: BorderRadius.circular(10.0),
        //     child: _TableAgenda(meetProvider.listAgendaAdd),
        //   ),
        // ),
        _TableAgenda(meetProvider.listAgendaAdd),
        Row(
          spacing: 20.0,
          children: [
            Text('  0${meetProvider.reunDetId + 1}'),
            Expanded(
              child: Row(
                spacing: 15.0,
                crossAxisAlignment: CrossAxisAlignment.end,
                // mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Expanded(child: _inputTitle(context)), //input de titulo
                  Expanded(child: _comboboxType(context)), //Combobox de tipo
                  meetProvider.typeOfAgenda.id == '1'
                      ? Expanded(child: _comboboxProject())
                      : meetProvider.typeOfAgenda.id == '2'
                          ? Expanded(
                              flex: 2,
                              child: Row(
                                spacing: 15.0,
                                children: [
                                  Expanded(child: _comboboxProject()),
                                  Expanded(child: _comboboxTasks()),
                                ],
                              ),
                            )
                          : meetProvider.typeOfAgenda.id == '3'
                              ? Expanded(child: _comboboxMeets())
                              : const SizedBox(),
                  Expanded(
                      child: _comboboxResponsible()), //Combobox responsable

                  SizedBox(
                    // color: Colors.amber,
                    width: 150,
                    child: BtnAdd(
                      icon: Bootstrap.save,
                      text: meetProvider.modeEdit ? 'Actualizar' : 'Agregar',
                      onTap: () {
                        // meetProvider.prueba();
                        meetProvider.modeEdit
                            ? meetProvider.updateRowAgenda()
                            : meetProvider.addNewAgenda();
                      },
                    ),
                  ),
                  if (meetProvider.modeEdit)
                    SizedBox(
                      width: 150,
                      child: BtnCancelThird(
                        text: 'Cancelar',
                        onTap: () {
                          meetProvider.clearValuesToNewRow();
                        },
                      ),
                    )
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}

Widget _inputTitle(BuildContext context) {
  final meetProvider = Provider.of<MeetProvider>(context);
  return InputTittle(
    // helperText: 'Título',
    labelText: 'Tema de agenda',
    onChanged: (value) {
      meetProvider.ctrlTittleAgenda.value;
    },
    hintText: '',
    textEditingController: meetProvider.ctrlTittleAgenda,
  );
}

Widget _comboboxType(BuildContext context) {
  final meetProvider = Provider.of<MeetProvider>(context);
  return DropdownSelect(
    // helperText: 'Tipo',
    label: 'Tipo',
    // icon: Bootstrap.pc_display_horizontal,
    value: meetProvider.listTypeAgenda.firstWhere(
      (element) => element.id == meetProvider.typeOfAgenda.id,
      orElse: () => meetProvider.listTypeAgenda.first, // valor por defecto
    ),
    items: meetProvider.listTypeAgenda.map((element) {
      return DropdownMenuItem(
        value: element,
        child: OptionSelect(
          nameOption: element.text,
        ),
      );
    }).toList(),
    onChanged: (newValue) {
      meetProvider.justUpdateUi();
      meetProvider.typeOfAgenda = newValue as OptionSelectModel;
    },
  );
}

Widget _comboboxResponsible() {
  // final meetProvider = Provider.of<MeetProvider>(context);
  return Consumer<MeetProvider>(
    builder: (context, meetProvider, _) {
      return DropdownSelect(
        // helperText: 'Responsable',
        label: 'Responsable',
        value: meetProvider.listPerson.firstWhere(
          (element) =>
              element.personalId == meetProvider.personAgenda.personalId,
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
        onChanged: (newValue) {
          meetProvider.personAgenda = newValue as Person;
        },
      );
    },
  );
}

Widget _comboboxProject() {
  return Consumer<MeetProvider>(
    builder: (context, meetProvider, _) {
      return DropdownSelect<Project>(
        label: 'Proyecto:',
        // helperText: 'Proyecto:',
        icon: Bootstrap.duffle,
        value: meetProvider.listProjects.firstWhere(
          (element) => element.id == meetProvider.currentProjectAgenda.id,
          orElse: () => meetProvider.listProjects.first, // valor por defecto
        ),
        items: meetProvider.listProjects.map((element) {
          return DropdownMenuItem(
            value: element,
            child: OptionSelect(
              nameOption: element.campanaNombre ?? element.campanaNombre ?? '',
            ),
          );
        }).toList(),
        onChanged: (newValue) {
          meetProvider.currentProjectAgenda = newValue as Project;
          meetProvider.getTasks();
        },
        // 👇 Aquí agregamos la búsqueda
        searchData: DropdownSearchData<Project>(
          searchInnerWidgetHeight: 50,
          searchInnerWidget: Padding(
            padding: const EdgeInsets.all(8),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Buscar proyecto...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                isDense: true,
              ),
              onChanged: (query) {
                // Opcional si deseas filtrar manualmente
              },
            ),
          ),

          // 👇 Esto establece por qué campo se filtra AUTOMÁTICAMENTE
          searchMatchFn: (item, searchValue) {
            final project = item.value as Project;
            return project.campanaNombre!
                .toLowerCase()
                .contains(searchValue.toLowerCase());
          },
        ),
      );
    },
  );
}

Widget _comboboxTasks() {
  return Consumer<MeetProvider>(
    builder: (context, meetProvider, _) {
      return DropdownSelect(
        label: 'Tarea:',
        // helperText: 'Proyecto:',
        icon: Bootstrap.duffle,
        value: meetProvider.listTaskAgenda.firstWhere(
          (element) =>
              element.ordenProduccionId ==
              meetProvider.currentTaskAgenda.ordenProduccionId,
          orElse: () => meetProvider.listTaskAgenda.first, // valor por defecto
        ),
        items: meetProvider.listTaskAgenda.map((element) {
          return DropdownMenuItem(
            value: element,
            child: OptionSelect(
                nameOption: element.ordenProduccionTrabajoRealizar ?? ''),
          );
        }).toList(),
        onChanged: (newValue) {
          meetProvider.currentTaskAgenda = newValue as Task;
        },
      );
    },
  );
}

Widget _comboboxMeets() {
  return Consumer<MeetProvider>(
    builder: (context, meetProvider, _) {
      return DropdownSelect(
        label: 'Reunión:',
        // helperText: 'Proyecto:',
        icon: Bootstrap.duffle,
        value: meetProvider.meetsToAgenda.firstWhere(
          (element) =>
              element.reunionId == meetProvider.currentMeetAgenda.reunionId,
          orElse: () => meetProvider.meetsToAgenda.first, // valor por defecto
        ),
        items: meetProvider.meetsToAgenda.map((element) {
          return DropdownMenuItem(
            value: element,
            child: OptionSelect(
              nameOption: element.reunionTitulo ?? element.reunionTitulo ?? '',
            ),
          );
        }).toList(),
        onChanged: (newValue) {
          meetProvider.currentMeetAgenda = newValue as Meet;
        },
      );
    },
  );
}

class _TableAgenda extends StatelessWidget {
  final List<Agenda> listAgenda;
  const _TableAgenda(this.listAgenda);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(10.0),
          height: 50.0,
          decoration: BoxDecoration(
            color: AppColors.secondaryConst,
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Row(spacing: 20.0, children: [
            _textHeader(
              context,
              'Nro     ',
            ),
            Expanded(flex: 3, child: _textHeader(context, 'Tema de agenda')),
            Expanded(child: _textHeader(context, 'Tipo')),
            Expanded(child: _textHeader(context, 'Asociado a')),
            Expanded(child: _textHeader(context, 'Responsable')),
            const SizedBox(width: 100),
          ]),
        ),
        SizedBox(
          height: (listAgenda.length * 56.0) + 60, // 40 px por fila aprox,
          child: ListView.builder(
              itemCount: listAgenda.length,
              itemBuilder: (context, index) {
                final newAgenda = listAgenda[index];
                return Container(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5.0),
                  margin: const EdgeInsets.only(top: 8.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: AppColors.backgroundColor(context),
                  ),
                  child: Row(
                    spacing: 20.0,
                    children: [
                      SizedBox(
                          width: 50,
                          child: Text("${index + 1}".padLeft(2, '0'))),
                      Expanded(flex: 3, child: Text(newAgenda.tittle ?? "-")),
                      Expanded(child: Text(newAgenda.type ?? "-")),
                      Expanded(
                          child: Text(newAgenda.associatedTypeName ?? "-")),
                      Expanded(child: Text(newAgenda.responsibleNames ?? "-")),
                      Row(
                        spacing: 10.0,
                        children: [
                          CustomIconButton(
                              iconData: Bootstrap.pencil_square,
                              onPressed: () {
                                context
                                    .read<MeetProvider>()
                                    .passValuesToUpdate(newAgenda);
                              }),
                          CustomIconButton(
                            iconData: Bootstrap.trash3,
                            onPressed: () {
                              context
                                  .read<MeetProvider>()
                                  .removeRowAgenda(newAgenda);
                            },
                            color: Colors.red,
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              }),
        )
      ],
    );
  }
}

Widget _textHeader(BuildContext context, String text) {
  // final ColorScheme colorScheme = Theme.of(context).colorScheme;
  return Text(
    text,
    style: TextStyle(
        fontSize: 15.0,
        fontWeight: FontWeight.w300,
        color: Colors.white // colorScheme.onInverseSurface,
        ),
  );
}
