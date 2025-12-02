import 'package:app_tasking/app/providers/project_provider.dart';
import 'package:app_tasking/app/ui/components/btn/btn_add.dart';
import 'package:app_tasking/app/ui/components/btn/btn_cancel_third.dart';
import 'package:app_tasking/app/ui/components/custom_icon_button.dart';
import 'package:app_tasking/app/ui/components/dropdown/dropdown_select.dart';
import 'package:app_tasking/app/ui/components/dropdown/option_select.dart';
import 'package:app_tasking/app/ui/components/dropdown/search_inner_widget.dart';
import 'package:app_tasking/app/ui/components/input/input_tittle.dart';
import 'package:app_tasking/app/ui/views/meet/meet_provider.dart';
import 'package:app_tasking/app/ui/views/meet/widgets/table_agenda.dart';
import 'package:app_tasking/core/helpers/constant.dart';
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
        _TableAgenda(meetProvider.listAgendaAdd),
        Row(
          spacing: 20.0,
          children: [
            Text(
              '  ${(meetProvider.listAgendaAdd.length + 1).toString().padLeft(2, '0')}',
            ),
            Expanded(
              child: Row(
                spacing: 15.0,
                crossAxisAlignment: CrossAxisAlignment.end,
                // mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Expanded(
                      flex: 2, child: _inputTitle(context)), //input de titulo
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
  final searchController = TextEditingController();
  return Consumer<MeetProvider>(
    builder: (context, meetProvider, _) {
      final list = meetProvider.listPersonToAgenda;

      // Caso cuando la lista está vacía
      if (list.isEmpty) {
        return const DropdownSelect(
          label: 'Responsable',
          hint:
              'Añadir participantes en la reunión para poder seleccionar un responsable de agenda',
          value: null,
          items: [],
          // enabled: false, // Deshabilitado
        );
      }
      meetProvider.personAgenda = list.first; //Por unica vez al inicio
      // Si la lista tiene datos
      final selected = list.firstWhere(
        (element) => element.personalId == meetProvider.personAgenda.personalId,
        orElse: () => list.first,
      );

      return DropdownSelect(
        label: 'Responsable',
        value: selected,
        items: list.map((element) {
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
          meetProvider.personAgenda = newValue as Person;
        },
      );
    },
  );
}

Widget _comboboxProject() {
  final searchController = TextEditingController();

  return Consumer<MeetProvider>(
    builder: (context, meetProvider, _) {
      return DropdownSelect<Project>(
        label: 'Proyecto:',
        value: meetProvider.currentProjectAgenda.id == 0
            ? null
            : meetProvider.listProjects.firstWhere(
                (p) => p.id == meetProvider.currentProjectAgenda.id,
                orElse: () => meetProvider.listProjects.first,
              ),
        items: meetProvider.listProjects.map((project) {
          return DropdownMenuItem(
            value: project,
            child: OptionSelect(nameOption: project.campanaNombre ?? ''),
          );
        }).toList(),
        onChanged: (value) {
          meetProvider.currentProjectAgenda = value!;
          meetProvider.getTasks();
        },
        dropdownSearchData: DropdownSearchData<Project>(
          searchController: searchController,
          searchInnerWidgetHeight: kDropdownHeight,
          searchInnerWidget: SearchInnerWidget(
            searchController: searchController,
            hintText: 'Buscar proyecto...',
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
      );
    },
  );
}

Widget _comboboxTasks() {
  final searchController = TextEditingController();
  return Consumer<MeetProvider>(
    builder: (context, meetProvider, _) {
      return DropdownSelect<Task>(
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
        dropdownSearchData: DropdownSearchData<Task>(
          searchController: searchController,
          searchInnerWidgetHeight: kDropdownHeight,
          searchInnerWidget: SearchInnerWidget(
            searchController: searchController,
            hintText: 'Buscar tarea...',
          ),
          searchMatchFn: (item, searchValue) {
            final p = item.value as Task;
            return p.ordenProduccionTrabajoRealizar!
                .toLowerCase()
                .contains(searchValue.toLowerCase());
          },
        ),
        onMenuStateChange: (isOpen) {
          if (!isOpen) {
            searchController.clear();
          }
        },
      );
    },
  );
}

Widget _comboboxMeets() {
  final searchController = TextEditingController();
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
        dropdownSearchData: DropdownSearchData<Meet>(
          searchController: searchController,
          searchInnerWidgetHeight: kDropdownHeight,
          searchInnerWidget: SearchInnerWidget(
            searchController: searchController,
            hintText: 'Buscar reunión...',
          ),
          searchMatchFn: (item, searchValue) {
            final p = item.value as Meet;
            return p.reunionTitulo!
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
            Expanded(flex: 2, child: _textHeader(context, 'Tema de agenda')),
            SizedBox(width: 100, child: _textHeader(context, 'Tipo')),
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
                  padding: const EdgeInsets.symmetric(
                      horizontal: 15.0, vertical: 5.0),
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
                      Expanded(flex: 2, child: Text(newAgenda.tittle ?? "-")),
                      SizedBox(width: 100, child: Text(newAgenda.type ?? "-")),
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
