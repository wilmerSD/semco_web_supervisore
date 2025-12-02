import 'package:app_tasking/app/providers/task_provider.dart';
import 'package:app_tasking/app/ui/components/btn/btn_cancel_second.dart';
import 'package:app_tasking/app/ui/components/btn/btn_save_second.dart';
import 'package:app_tasking/app/ui/components/custom_animated_swicher.dart';
import 'package:app_tasking/app/ui/components/custom_icon_button.dart';
import 'package:app_tasking/app/ui/components/dropdown/dropdown_select.dart';
import 'package:app_tasking/app/ui/components/dropdown/option_select.dart';
import 'package:app_tasking/app/ui/components/dropdown/search_inner_widget.dart';
import 'package:app_tasking/app/ui/components/input/input_description.dart';
import 'package:app_tasking/app/ui/components/input/web_date_picker_field.dart';
import 'package:app_tasking/app/ui/components/rotating_icon.dart';
import 'package:app_tasking/app/ui/views/meet/agreement_provider.dart';
import 'package:app_tasking/app/ui/views/meet/btn/btn_meet_gen.dart';
import 'package:app_tasking/app/ui/views/meet/meet_provider.dart';
import 'package:app_tasking/core/helpers/constant.dart';
import 'package:app_tasking/core/helpers/enums.dart';
import 'package:app_tasking/core/helpers/helpers.dart';
import 'package:app_tasking/core/theme/app_colors.dart';
import 'package:app_tasking/core/theme/app_text_style.dart';
import 'package:app_tasking/domain/entities/agenda.dart';
import 'package:app_tasking/domain/entities/agreement.dart';
import 'package:app_tasking/domain/entities/area.dart';
import 'package:app_tasking/domain/entities/participant.dart';
import 'package:app_tasking/domain/entities/person.dart';
import 'package:app_tasking/domain/entities/project.dart';
import 'package:app_tasking/domain/entities/task.dart';
import 'package:app_tasking/infrastructure/models/option__select_model.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:provider/provider.dart';

class ListAgenda extends StatelessWidget {
  const ListAgenda({super.key});

  @override
  Widget build(BuildContext context) {
    final meetProvider = Provider.of<MeetProvider>(context);
    return ListView.builder(
      itemCount: meetProvider.listAgenda.length,
      itemBuilder: (context, index) {
        final agenda = meetProvider.listAgenda[index];
        return AgendaExpandableTile(agenda: agenda);
      },
    );
  }
}

class AgendaExpandableTile extends StatefulWidget {
  final Agenda agenda;

  const AgendaExpandableTile({super.key, required this.agenda});

  @override
  State<AgendaExpandableTile> createState() => _AgendaExpandableTileState();
}

class _AgendaExpandableTileState extends State<AgendaExpandableTile> {
  bool isLoadingChildren = false;
  bool isExpanded = false;
  List<Agreement> agreements = [];

  Future<void> _loadAgreements() async {
    setState(() => isLoadingChildren = true);
    final agreement = await context.read<MeetProvider>().getAgreements(
        widget.agenda.reunionId ?? '',
        widget.agenda.id ?? 0); //Obtenemos los acuerdos
    setState(() {
      agreements = agreement;
      isLoadingChildren = false;
      isExpanded = true;
    });
  }

  void _addAgreement(Agreement newAgreement) {
    setState(() {
      agreements.add(newAgreement);
    });
  }

  void _deleteAgreement(Agreement agreement) {
    setState(() {
      agreements.remove(agreement);
    });
  }

  void _editAgreement(Agreement updatedAgreement) {
    setState(() {
      final index = agreements.indexWhere(
          (element) => element.agreementId == updatedAgreement.agreementId);
      if (index != -1) {
        agreements[index] = updatedAgreement;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        dividerColor: Colors.transparent, // 🔥 elimina las líneas grises
        splashColor:
            const Color.fromARGB(0, 240, 197, 197), // quita el efecto splash
        highlightColor: Colors.transparent, // quita el highlight al tocar
      ),
      child: ExpansionTile(
        // dense: true,
        backgroundColor: Colors.transparent,
        tilePadding: const EdgeInsetsDirectional.all(0.0),
        showTrailingIcon: false,
        onExpansionChanged: (bool expanded) {
          if (expanded) {
            _loadAgreements();
          } else {
            setState(() => isExpanded = false);
          }
        },
        title: Container(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
          decoration: BoxDecoration(
            color: AppColors.backgroundColor(context),
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 15.0,
            children: [
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  // color: Colors.blue,
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 5.0,
                      ),
                      RotatingIcon(
                          expanded: isExpanded,
                          icon: Bootstrap.caret_up_fill,
                          size: 15),
                    ],
                  ),
                ),
              ),
              // const SizedBox(width: 10.0),
              _title(context, '0${widget.agenda.id}'),
              // const SizedBox(width: 10.0),
              // Expanded(

              //   child: Text('${widget.agenda.id}')),
              Expanded(
                  flex: 2, child: _title(context, widget.agenda.tittle ?? '')),
              Expanded(
                  child:
                      _title(context, widget.agenda.associatedTypeName ?? '')),
              Expanded(
                  child: _title(context, widget.agenda.responsibleNames ?? '')),
              Expanded(
                  child: _title(context,
                      Helpers.formateDateTimeEsp(widget.agenda.dateCreation))),
              Expanded(
                child: Center(
                  child: SizedBox(
                    width: 200,
                    child: BtnMeetGen(
                      text: 'Agregar acuerdo',
                      onTap: () {},
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
        children: [
          Container(
            width: double.infinity,
            padding:
                const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
            decoration: BoxDecoration(
                color: AppColors.backgroundColor(context),
                borderRadius: BorderRadius.circular(10.0)),
            child: isLoadingChildren
                ? const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Center(child: CircularProgressIndicator()),
                  )
                : Center(
                    child: CustomAnimatedSwicher(
                        option1: _AgreementView(agreements, widget.agenda,
                            _addAgreement, _deleteAgreement, _editAgreement),
                        option2: _NoteView(
                            widget.agenda, agreements, _addAgreement, () {
                          setState(() {
                            // showFormAgreement = false;
                          });
                        }, _deleteAgreement, _editAgreement)),
                  ),
          )
        ],
      ),
    );
  }
}

Widget _title(BuildContext context, String text) {
  return Text(
    text,
    overflow: TextOverflow.ellipsis,
    // style: AppTextStyle(context)
    //     .bold14(fontWeight: FontWeight.bold, color: AppColors.secondaryConst),
    maxLines: 2,
  );
}

Widget _subTittleChild(BuildContext context, String text,
    {double? width = 200.0}) {
  return SizedBox(
    // width: width,
    child: Text(
      text,
      style: AppTextStyle(context)
          .bold14(fontWeight: FontWeight.bold, color: AppColors.secondaryConst),
      maxLines: 2,
    ),
  );
}

Widget _contentChild(BuildContext context, String text,
    {double? width = 200.0}) {
  return SizedBox(
    // width: width,
    child: Text(
      '$text',
      style: AppTextStyle(context).bold14(),
      textAlign: TextAlign.justify,
    ),
  );
}

class _AgreementView extends StatefulWidget {
  final List<Agreement> agreements;
  final Agenda agenda;
  final Function(Agreement) onAddAgreement;
  final Function(Agreement) onEditAgreement;
  // final Function() onAddNote;
  final Function(Agreement) onDeleteAgreement;

  const _AgreementView(this.agreements, this.agenda, this.onAddAgreement,
      /* this.onAddNote, */ this.onDeleteAgreement, this.onEditAgreement);

  @override
  State<_AgreementView> createState() => _AgreementViewState();
}

class _AgreementViewState extends State<_AgreementView> {
  bool showFormAgreement = true;
  Agreement? agreementEdit;
  @override
  Widget build(BuildContext context) {
    final finalAgreements =
        widget.agreements.where((element) => element.type != 'Nota').toList();
    return finalAgreements.isEmpty
        ? Column(
            spacing: 20.0,
            children: [
              const Center(
                child: Text('Sin acuerdos asociados'),
              ),
              _AgreementForm(
                key: ValueKey(agreementEdit?.agreementId ?? 'new'),
                widget.agenda,
                widget.onAddAgreement,
                () {
                  setState(() {
                    agreementEdit = null;
                    showFormAgreement = false;
                  });
                },
                () {
                  setState(() {
                    agreementEdit = null;
                  });
                },
                (updatedAgreement) {
                  widget.onEditAgreement(updatedAgreement);
                  setState(() {
                    agreementEdit = null;
                    showFormAgreement = false;
                  });
                },
                agreementEdit,
              )
            ],
          )
        : Column(
            spacing: 10.0,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 15.0,
                children: [
                  Expanded(
                      flex: 4, child: _subTittleChild(context, 'Descripción')),
                  Expanded(flex: 2, child: _subTittleChild(context, 'Tipo')),
                  Expanded(
                      flex: 2, child: _subTittleChild(context, 'Asignado a')),
                  Expanded(
                    flex: 2,
                    child: _subTittleChild(
                      context,
                      'Responsable',
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: _subTittleChild(
                      context,
                      'Fecha',
                    ),
                  ),
                  const SizedBox(
                    width: 100,
                    height: 10,
                  )
                ],
              ),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: finalAgreements.length,
                itemBuilder: (context, index) {
                  final agreement = finalAgreements[index];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 20.0, right: 10.0),
                    child: Row(
                      spacing: 15.0,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                            flex: 4,
                            child: _contentChild(
                                context, agreement.name?.trim() ?? '')),
                        Expanded(
                            flex: 2,
                            child:
                                _contentChild(context, agreement.type ?? '')),
                        Expanded(
                            flex: 2,
                            child: _contentChild(
                                context, agreement.areaName ?? '-')),
                        Expanded(
                            flex: 2,
                            child: _contentChild(
                                context, agreement.responsibleFullName ?? '-')),
                        Expanded(
                            flex: 1,
                            child: _contentChild(context,
                                Helpers.ddMMyyyy(agreement.limitDate))),
                        // Expanded(child: child)
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomIconButton(
                                onPressed: () {
                                  setState(() {
                                    agreementEdit = agreement;
                                    showFormAgreement = true;
                                  });
                                },
                                iconData: Bootstrap.pencil_square),
                            CustomIconButton(
                              onPressed: () async {
                                final response = await context
                                    .read<AgreementProvider>()
                                    .deleteAgreement(
                                        context,
                                        widget.agenda.reunionId ?? '',
                                        widget.agenda.id ?? 0,
                                        agreement.agreementId ?? '');
                                if (response) {
                                  widget.onDeleteAgreement(agreement);
                                }
                              },
                              iconData: Bootstrap.trash3,
                              color: Colors.red,
                            )
                          ],
                        )
                      ],
                    ),
                  );
                },
              ),
              showFormAgreement
                  ? _AgreementForm(
                      key: ValueKey(agreementEdit?.agreementId ?? 'new'),
                      widget.agenda,
                      widget.onAddAgreement,
                      () {
                        setState(() {
                          agreementEdit = null;
                          showFormAgreement = false;
                        });
                      },
                      () {
                        setState(() {
                          agreementEdit = null;
                        });
                      },
                      (updatedAgreement) {
                        widget.onEditAgreement(updatedAgreement);
                        setState(() {
                          agreementEdit = null;
                          showFormAgreement = false;
                        });
                      },
                      agreementEdit,
                    )
                  : DottedBorder(
                      color: Colors.green,
                      strokeWidth: 2,
                      radius: const Radius.circular(200.0),
                      borderType: BorderType.Circle,
                      child: CustomIconButton(
                        iconData: Bootstrap.plus,
                        color: Colors.green,
                        onPressed: () {
                          setState(() {
                            showFormAgreement = true;
                          });
                        },
                      ))
            ],
          );
  }
}

class _AgreementForm extends StatefulWidget {
  final Agenda agenda;
  final Function(Agreement) onCreated; // callback
  final Function() onClose;
  final Function() onCloseEdit;
  final Function(Agreement) onEdit;
  final Agreement? editAgreement;

  const _AgreementForm(this.agenda, this.onCreated, this.onClose,
      this.onCloseEdit, this.onEdit, this.editAgreement,
      {super.key});

  @override
  State<_AgreementForm> createState() => _AgreementFormState();
}

class _AgreementFormState extends State<_AgreementForm> {
  final descController = TextEditingController();
  final TextEditingController ctrlDateLimitAgreement =
      TextEditingController(text: Helpers.dateToStringTimeDMY(DateTime.now()));

  final ctrlSearchResponsible = TextEditingController();
  final ctrlSearchArea = TextEditingController();
  final ctrlSearchProject = TextEditingController();
  final ctrlSearchTask = TextEditingController();
  // final ctrlSearchSubTask = TextEditingController();

  Person personResponsible = Person(
    personalId: '-1',
    personalNombreCompleto: 'Seleccionar',
  );

  Participant participantResponsible = Participant(
    personalId: '0',
    fullName: 'Seleccionar',
  );

  final lisTypeAgreement =
      AgreementType.values.map((e) => e.toOption()).toList();
  OptionSelectModel agreementTypeSelected =
      AgreementType.values.first.toOption();

  Project projectMeet = Project(
    campanaid: '0',
    campanaNombre: 'Seleccionar',
  );

  List<Task> listTaskAgenda = [
    Task(
      ordenProduccionId: '0',
      ordenProduccionTrabajoRealizar: 'Seleccionar',
    )
  ];
  Task currentTaskAgenda = Task(
    id: '0',
    ordenProduccionTrabajoRealizar: 'Seleccionar',
  );

  Area clientMeet = Area(
    clienteId: '0',
    clienteNombre: 'Seleccionar',
  );

  OptionSelectModel agreementTypePrivacitySelected =
      PrivacityType.values.first.toOption();

  List<Participant> listParticipants = [
    Participant(
      personalId: '0',
      fullName: 'Seleccionar',
    )
  ];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final meetProvider = Provider.of<MeetProvider>(context, listen: false);
      final a = widget.editAgreement;

      setState(() {
        listParticipants.addAll(meetProvider.participantsDetail);
      });

      if (a != null) {
        // Responsable
        participantResponsible = listParticipants.firstWhere(
          (p) => p.personalId == a.responsibleId,
          orElse: () => Participant(personalId: '0', fullName: 'Seleccionar'),
        );

        // Descripción
        descController.text = a.name ?? '';

        // Fecha Límite (si aplica)
        if (a.limitDate != null) {
          ctrlDateLimitAgreement.text =
              Helpers.changeDateTodMy(a.limitDate ?? '');
        }

        // Tipo de acuerdo
        agreementTypeSelected = lisTypeAgreement.firstWhere(
          (e) => e.id == a.type,
          orElse: () => lisTypeAgreement.first,
        );

        // Proyecto
        projectMeet = meetProvider.listProjects.firstWhere(
          (p) => p.campanaid == a.projectId,
          orElse: () => Project(campanaid: '0', campanaNombre: 'Seleccionar'),
        );

        // Área
        clientMeet = meetProvider.listClient.firstWhere(
          (aArea) => aArea.clienteId == a.areaId,
          orElse: () => Area(clienteId: '0', clienteNombre: 'Seleccionar'),
        );

        // Tarea
        currentTaskAgenda = listTaskAgenda.firstWhere(
          (t) => t.id == a.taskId,
          orElse: () => listTaskAgenda.first,
        );
        setState(() {});
      }
    });
  }

  @override
  void dispose() {
    descController.dispose();
    ctrlDateLimitAgreement.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final meetProvider = context.watch<MeetProvider>();

    return _wrapperForm(
      context,
      Column(
        spacing: 20.0,
        children: [
          Row(
            children: [
              Expanded(
                child: InputDescription(
                  hintText:
                      'Auditar el sitio web y optimizar 15 páginas clave para mejorar el posicionamiento en Google. Incluir la investigación de palabras clave, ajuste de títulos, meta descripciones y mejora de la velocidad de carga del sitio.',
                  labelText: 'Descripción del acuerdo:',
                  textEditingController: descController,
                  onChanged: (value) {
                    descController.value;
                  },
                  isMandatory: true,
                ),
              ),
            ],
          ),
          Row(
            spacing: 15.0,
            children: [
              Expanded(
                  child: DropdownSelect(
                label: 'Tipo:',
                value: lisTypeAgreement.firstWhere(
                  (element) => element.id == agreementTypeSelected.id,
                  orElse: () => lisTypeAgreement.first, // valor por defecto
                ),
                items: lisTypeAgreement.map((element) {
                  return DropdownMenuItem(
                    value: element,
                    child: OptionSelect(
                      nameOption: element.text,
                    ),
                  );
                }).toList(),
                onChanged: (newValue) {
                  // meetProvider.updateTypeOfMeet();
                  setState(() {});
                  agreementTypeSelected = newValue as OptionSelectModel;
                },
              )),
              /* Expanded(
                child: DropdownSelect<Person>(
                  isMandatory: true,
                  label: 'Responsable:',
                  value: listPerson.firstWhere(
                    (element) =>
                        element.personalId == personResponsible.personalId,
                    orElse: () => listPerson.first, // valor por defecto
                  ),
                  items: listPerson.map((element) {
                    return DropdownMenuItem(
                      value: element,
                      child: OptionSelect(
                        nameOption: element.personalNombreCompleto,
                      ),
                    );
                  }).toList(),
                  dropdownSearchData: DropdownSearchData<Person>(
                    searchController: ctrlSearchResponsible,
                    searchInnerWidgetHeight: kDropdownHeight,
                    searchInnerWidget: SearchInnerWidget(
                      searchController: ctrlSearchResponsible,
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
                      ctrlSearchResponsible.clear();
                    }
                  },
                  onChanged: (newValue) {
                    personResponsible = newValue as Person;
                    print(personResponsible.personalNombreCompleto);
                  },
                ),
              ), */
              Expanded(
                child: DropdownSelect<Participant>(
                  isMandatory: true,
                  label: 'Responsable:',
                  value: listParticipants.firstWhere(
                    (element) =>
                        element.personalId == participantResponsible.personalId,
                    orElse: () => listParticipants.first,
                  ),
                  items: listParticipants.map((element) {
                    return DropdownMenuItem(
                      value: element,
                      child: OptionSelect(
                        nameOption: element.fullName,
                      ),
                    );
                  }).toList(),
                  dropdownSearchData: DropdownSearchData<Participant>(
                    searchController: ctrlSearchResponsible,
                    searchInnerWidgetHeight: kDropdownHeight,
                    searchInnerWidget: SearchInnerWidget(
                      searchController: ctrlSearchResponsible,
                      hintText: 'Buscar persona...',
                    ),
                    searchMatchFn: (item, searchValue) {
                      final p = item.value as Participant;
                      return p.fullName!
                          .toLowerCase()
                          .contains(searchValue.toLowerCase());
                    },
                  ),
                  onMenuStateChange: (isOpen) {
                    if (!isOpen) {
                      ctrlSearchResponsible.clear();
                    }
                  },
                  onChanged: (newValue) {
                    participantResponsible = newValue as Participant;
                    print(participantResponsible.fullName);
                  },
                ),
              ),
              Expanded(
                child: SizedBox(
                    // width: 250.0,
                    height: 80.0,
                    child: WebDatePickerField(
                      isMandatory: true,
                      label: 'Fecha límite',
                      icon: Bootstrap.calendar_event,
                      controller: ctrlDateLimitAgreement,
                      onDateSelected: (range) {
                        // print('Seleccionado: ${range.start}');
                        // meetProvider.justUpdateUi();
                      },
                    )),
              ),
              const Expanded(flex: 1, child: SizedBox())
            ],
          ),
          if (agreementTypeSelected.id == 'Tarea')
            Row(
              spacing: 15.0,
              children: [
                Expanded(
                    child: DropdownSelect<Area>(
                  label: 'Espacio de trabajo:',
                  // helperText: 'Proyecto:',
                  // icon: Bootstrap.duffle,
                  value: meetProvider.listClient.firstWhere(
                    (element) => element.clienteId == clientMeet.clienteId,
                    orElse: () =>
                        meetProvider.listClient.first, // valor por defecto
                  ),
                  items: meetProvider.listClient.map((element) {
                    return DropdownMenuItem(
                      value: element,
                      child: OptionSelect(
                        nameOption: element.clienteNombre ?? '',
                      ),
                    );
                  }).toList(),
                  dropdownSearchData: DropdownSearchData<Area>(
                    searchController: ctrlSearchArea,
                    searchInnerWidgetHeight: kDropdownHeight,
                    searchInnerWidget: SearchInnerWidget(
                      searchController: ctrlSearchArea,
                      hintText: 'Buscar espacio de trabajo...',
                    ),
                    searchMatchFn: (item, searchValue) {
                      final p = item.value as Area;
                      return p.clienteNombre!
                          .toLowerCase()
                          .contains(searchValue.toLowerCase());
                    },
                  ),
                  onMenuStateChange: (isOpen) {
                    if (!isOpen) {
                      ctrlSearchArea.clear();
                    }
                  },
                  onChanged: (newValue) {
                    clientMeet = newValue as Area;
                    meetProvider.getListProjects(clientMeet.clienteId);
                  },
                )),

                //Deberian salirme solo los proyectos asociados al cliente seleccionado
                Expanded(
                    child: DropdownSelect<Project>(
                  label: 'Proyecto:',
                  // helperText: 'Proyecto:',
                  // icon: Bootstrap.duffle,
                  value: meetProvider.listProjects.firstWhere(
                    (element) => element.campanaid == projectMeet.campanaid,
                    orElse: () =>
                        meetProvider.listProjects.first, // valor por defecto
                  ),
                  items: meetProvider.listProjects.map((element) {
                    return DropdownMenuItem(
                      value: element,
                      child: OptionSelect(
                        nameOption: element.campanaNombre ?? '',
                      ),
                    );
                  }).toList(),
                  dropdownSearchData: DropdownSearchData<Project>(
                    searchController: ctrlSearchProject,
                    searchInnerWidgetHeight: kDropdownHeight,
                    searchInnerWidget: SearchInnerWidget(
                      searchController: ctrlSearchProject,
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
                      ctrlSearchProject.clear();
                    }
                  },
                  onChanged: (newValue) async {
                    projectMeet = newValue as Project;
                    final response = await context
                        .read<TaskProviderP>()
                        .getTasks(project: projectMeet);

                    setState(() {
                      listTaskAgenda
                        ..clear()
                        ..add(
                          Task(
                            ordenProduccionId: '0',
                            ordenProduccionTrabajoRealizar: 'Seleccionar',
                          ),
                        )
                        ..addAll(response);
                    });
                    // meetProvider.getTasks(project: projectMeet);
                  },
                )),
                //Trabajar con selector para que no se actualice toda la vista
                Expanded(
                    child: DropdownSelect<Task>(
                  label: 'Tarea:',
                  // helperText: 'Proyecto:',
                  icon: Bootstrap.duffle,
                  value: listTaskAgenda.firstWhere(
                    (element) =>
                        element.ordenProduccionId ==
                        currentTaskAgenda.ordenProduccionId,
                    orElse: () => listTaskAgenda.first, // valor por defecto
                  ),
                  items: listTaskAgenda.map((element) {
                    return DropdownMenuItem(
                      value: element,
                      child: OptionSelect(
                          nameOption:
                              element.ordenProduccionTrabajoRealizar ?? ''),
                    );
                  }).toList(),
                  dropdownSearchData: DropdownSearchData<Task>(
                    searchController: ctrlSearchProject,
                    searchInnerWidgetHeight: kDropdownHeight,
                    searchInnerWidget: SearchInnerWidget(
                      searchController: ctrlSearchProject,
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
                      ctrlSearchProject.clear();
                    }
                  },
                  onChanged: (newValue) {
                    currentTaskAgenda = newValue as Task;
                    // meetProvider.getListSubTask(
                    //     currentTaskAgenda); //Función para traer subtareas
                  },
                )),
                //Trabajar con selector para que no se actualice toda la vista
                //Evaluar si se necesita otro combobox para subtarea
                const Expanded(child: SizedBox())
                // Expanded(
                //     child: DropdownSelect(
                //   label: 'Sub Tarea:',
                //   // helperText: 'Proyecto:',
                //   icon: Bootstrap.duffle,
                //   value: meetProvider.listTaskAgenda.firstWhere(
                //     (element) =>
                //         element.ordenProduccionId ==
                //         meetProvider.currentTaskAgenda.ordenProduccionId,
                //     orElse: () =>
                //         meetProvider.listTaskAgenda.first, // valor por defecto
                //   ),
                //   items: meetProvider.listTaskAgenda.map((element) {
                //     return DropdownMenuItem(
                //       value: element,
                //       child: OptionSelect(
                //           nameOption:
                //               element.ordenProduccionTrabajoRealizar ?? ''),
                //     );
                //   }).toList(),
                //   onChanged: (newValue) {
                //     meetProvider.currentTaskAgenda = newValue as Task;
                //     print(meetProvider.currentTaskAgenda.id);
                //     print('ui');
                //   },
                // )),
              ],
            ),
          Row(
            spacing: 20.0,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SizedBox(
                width: 150.0,
                child: BtnCancelSecond(
                  text: 'Cancelar',
                  onTap: () {
                    if (widget.editAgreement != null) {
                      widget.onCloseEdit();
                    } else {
                      widget.onClose();
                    }
                  },
                ),
              ),
              SizedBox(
                  width: 150.0,
                  child:
                      Consumer<MeetProvider>(builder: (context, provider, _) {
                    return BtnSaveSecond(
                        loading: provider.isCreatingMeet,
                        text: provider.isCreatingMeet ? "Guardando" : 'Guardar',
                        showBoxShadow: false,
                        onTap: () async {
                          final isTask = agreementTypeSelected.id == 'Tarea';
                          final isNote = agreementTypeSelected.id == 'Nota';

                          // Modo EDICIÓN
                          if (widget.editAgreement != null) {
                            final updatedAgreement = Agreement(
                              agreementId: widget.editAgreement!.agreementId,
                              reunionId: widget.agenda.reunionId,
                              agendaId: widget.agenda.id,
                              name: descController.text,
                              type: agreementTypeSelected.id,
                              privacity: agreementTypePrivacitySelected.id,
                              responsibleId: participantResponsible.personalId,
                              responsibleFullName:
                                  participantResponsible.fullName,
                              limitDate: isNote
                                  ? null
                                  : Helpers.changeStringDateToymd(
                                      ctrlDateLimitAgreement.text),
                              projectId: isTask ? projectMeet.campanaid : null,
                              taskId: isTask
                                  ? currentTaskAgenda.ordenProduccionId
                                  : null,
                              areaId: isTask ? clientMeet.clienteId : null,
                              areaName:
                                  isTask ? clientMeet.clienteNombre : null,
                            );

                            final success = await context
                                .read<AgreementProvider>()
                                .updateAgreement(context, updatedAgreement);

                            if (success) {
                              widget.onEdit(updatedAgreement);
                              widget.onClose();
                              // Limpiar el formulario
                              descController.clear();
                            }
                            return;
                          }

                          // Modo CREACIÓN
                          final selectPerson =
                              participantResponsible.personalId != '0';

                          final newAgreement = await context
                              .read<AgreementProvider>()
                              .createAgreement(
                                  context,
                                  widget.agenda.reunionId ?? '',
                                  widget.agenda.id ?? 0,
                                  descController.text,
                                  agreementTypeSelected.id,
                                  agreementTypePrivacitySelected.id,
                                  selectPerson
                                      ? participantResponsible.personalId
                                      : null,
                                  selectPerson
                                      ? participantResponsible.fullName
                                      : null,
                                  ctrlDateLimitAgreement.text,
                                  isTask ? projectMeet.campanaid ?? '' : null,
                                  isTask
                                      ? currentTaskAgenda.ordenProduccionId
                                      : null,
                                  isTask ? clientMeet.clienteId : null,
                                  isTask ? clientMeet.clienteNombre : null);
                          if (newAgreement != null) {
                            widget.onCreated(newAgreement);
                            descController.clear();
                          }
                        });
                  })),
            ],
          ),
        ],
      ),
    );
  }
}

class _NoteView extends StatefulWidget {
  final Agenda agenda;
  final List<Agreement> agreements;
  final Function(Agreement) onCreated; // callback
  final Function() onClose;
  final Function(Agreement) onDelete;
  final Function(Agreement) onEditNote;
  const _NoteView(this.agenda, this.agreements, this.onCreated, this.onClose,
      this.onDelete, this.onEditNote);

  @override
  State<_NoteView> createState() => _NoteViewState();
}

class _NoteViewState extends State<_NoteView> {
  bool showFormNote = true;
  Agreement? noteEdit;
  @override
  Widget build(BuildContext context) {
    final agreementsNotes =
        widget.agreements.where((element) => element.type == 'Nota').toList();
    return agreementsNotes.isEmpty
        ? Column(
            spacing: 20.0,
            children: [
              const Center(
                child: Text('Sin notas asociadas'),
              ),
              _NoteForm(
                key: ValueKey(noteEdit?.agreementId ?? 'new'),
                widget.agenda,
                widget.onCreated,
                () {
                  setState(() {
                    noteEdit = null;
                    showFormNote = false;
                  });
                },
                () {
                  setState(() {
                    noteEdit = null;
                  });
                },
                (updatedNote) {
                  widget.onEditNote(updatedNote);
                  setState(() {
                    noteEdit = null;
                    showFormNote = false;
                  });
                },
                noteEdit,
              )
            ],
          )
        : Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 15.0,
                children: [
                  Expanded(flex: 4, child: _subTittleChild(context, 'Nota')),
                  Expanded(
                      flex: 2, child: _subTittleChild(context, 'Responsable')),
                  Expanded(
                      flex: 1,
                      child: _subTittleChild(context, 'Fecha de creación')),
                  const SizedBox(
                    width: 100,
                    height: 10,
                  )
                ],
              ),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: agreementsNotes.length,
                itemBuilder: (context, index) {
                  final agreement = agreementsNotes[index];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 20.0, right: 10.0),
                    child: Row(
                      spacing: 15.0,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                            flex: 4,
                            child: _contentChild(
                                context, agreement.name?.trim() ?? '')),

                        Expanded(
                            flex: 2,
                            child: _contentChild(
                                context, agreement.responsibleFullName ?? '-')),
                        Expanded(
                            flex: 1,
                            child: _contentChild(context,
                                Helpers.ddMMyyyy(agreement.dateCreation))),
                        // Expanded(child: child)
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomIconButton(
                                onPressed: () {
                                  setState(() {
                                    noteEdit = agreement;
                                    showFormNote = true;
                                  });
                                },
                                iconData: Bootstrap.pencil_square),
                            CustomIconButton(
                              onPressed: () async {
                                //todo: Funcion para eliminar la nota/agenda
                                final response = await context
                                    .read<AgreementProvider>()
                                    .deleteAgreement(
                                        context,
                                        widget.agenda.reunionId ?? '',
                                        widget.agenda.id ?? 0,
                                        agreement.agreementId ?? '');
                                if (response) {
                                  widget.onDelete(agreement);
                                }
                              },
                              iconData: Bootstrap.trash3,
                              color: Colors.red,
                            )
                          ],
                        )
                      ],
                    ),
                  );
                },
              ),
              showFormNote
                  ? _NoteForm(
                      key: ValueKey(noteEdit?.agreementId ?? 'new'),
                      widget.agenda,
                      widget.onCreated,
                      () {
                        setState(() {
                          noteEdit = null;
                          showFormNote = false;
                        });
                      },
                      () {
                        setState(() {
                          noteEdit = null;
                        });
                      },
                      (updatedNote) {
                        widget.onEditNote(updatedNote);
                        setState(() {
                          noteEdit = null;
                          showFormNote = false;
                        });
                      },
                      noteEdit,
                    )
                  : DottedBorder(
                      color: Colors.green,
                      strokeWidth: 2,
                      radius: const Radius.circular(200.0),
                      borderType: BorderType.Circle,
                      child: CustomIconButton(
                        iconData: Bootstrap.plus,
                        color: Colors.green,
                        onPressed: () {
                          setState(() {
                            showFormNote = true;
                          });
                        },
                      ))
            ],
          );
  }
}

class _NoteForm extends StatefulWidget {
  final Agenda agenda;
  final Function(Agreement) onCreated; // callback
  final Function() onClose;
  final Function() onCloseEdit;
  final Function(Agreement) onEdit;
  final Agreement? editNote;

  const _NoteForm(this.agenda, this.onCreated, this.onClose, this.onCloseEdit,
      this.onEdit, this.editNote,
      {super.key});

  @override
  State<_NoteForm> createState() => _NoteFormState();
}

class _NoteFormState extends State<_NoteForm> {
  final ctrlNote = TextEditingController();

  final lisTypePrivacityAgreement =
      PrivacityType.values.map((e) => e.toOption()).toList();

  OptionSelectModel agreementTypePrivacitySelected =
      PrivacityType.values.first.toOption();

  PrivacityType? privacityFromString(String? value) {
    if (value == null) return null;

    return PrivacityType.values.firstWhere(
      (e) => e.name == value,
      orElse: () => PrivacityType.values.first, // por defecto
    );
  }

  @override
  void initState() {
    super.initState();
    if (widget.editNote != null) {
      ctrlNote.text = widget.editNote!.name ?? '';
      agreementTypePrivacitySelected = lisTypePrivacityAgreement.firstWhere(
        (e) => e.id == widget.editNote!.privacity,
        orElse: () => lisTypePrivacityAgreement.first,
      );
      // final priv = privacityFromString(widget.editNote!.privacity);
      // setState(() {
      //   agreementTypePrivacitySelected =
      //       priv?.toOption() ?? PrivacityType.values.first.toOption();
      // });
      print('tipo:${widget.editNote!.privacity}');
      print('priv:${agreementTypePrivacitySelected.id}');
    }
  }

  @override
  void dispose() {
    ctrlNote.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return _wrapperForm(
        context,
        Column(
          spacing: 15.0,
          children: [
            Row(
              children: [
                Expanded(
                  child: InputDescription(
                    hintText: 'Escribe la nota que deseas agregar.',
                    labelText: 'Nota:',
                    textEditingController: ctrlNote,
                    onChanged: (value) {
                      ctrlNote.value;
                    },
                  ),
                ),
              ],
            ),
            Row(children: [
              Expanded(
                  child: DropdownSelect(
                label: 'Privacidad:',
                value: lisTypePrivacityAgreement.firstWhere(
                  (element) => element.id == agreementTypePrivacitySelected.id,
                  orElse: () =>
                      lisTypePrivacityAgreement.first, // valor por defecto
                ),
                items: lisTypePrivacityAgreement.map((element) {
                  return DropdownMenuItem(
                    value: element,
                    child: OptionSelect(
                      nameOption: element.text,
                    ),
                  );
                }).toList(),
                onChanged: (newValue) {
                  agreementTypePrivacitySelected =
                      newValue as OptionSelectModel;
                },
              )),
              const Expanded(flex: 3, child: SizedBox())
            ]),
            Row(
              spacing: 20.0,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SizedBox(
                  width: 150.0,
                  child: BtnCancelSecond(
                      text: 'Cancelar',
                      onTap: () {
                        widget.editNote == null
                            ? widget.onClose()
                            : widget.onCloseEdit();
                      }),
                ),
                SizedBox(
                    width: 150.0,
                    child:
                        Consumer<MeetProvider>(builder: (context, provider, _) {
                      return BtnSaveSecond(
                          loading: provider.isCreatingMeet,
                          text:
                              provider.isCreatingMeet ? "Guardando" : 'Guardar',
                          showBoxShadow: false,
                          onTap: () async {
                            // Modo EDICIÓN
                            if (widget.editNote != null) {
                              final updatedAgreement = Agreement(
                                agreementId: widget.editNote!.agreementId,
                                reunionId: widget.agenda.reunionId,
                                agendaId: widget.agenda.id,
                                name: ctrlNote.text,
                                type: 'Nota',
                                privacity: agreementTypePrivacitySelected.id,
                                responsibleId: widget.editNote!.responsibleId,
                                responsibleFullName:
                                    widget.editNote!.responsibleFullName,
                                limitDate: null,
                                projectId: null,
                                taskId: null,
                                areaId: null,
                                areaName: null,
                              );

                              final success = await context
                                  .read<AgreementProvider>()
                                  .updateAgreement(context, updatedAgreement);

                              if (success) {
                                widget.onEdit(updatedAgreement);
                                widget.onClose();
                                // Limpiar el formulario
                                ctrlNote.clear();
                              }
                              return;
                            }
                            final person =
                                context.read<MeetProvider>().personalId;
                            final newAgreement = await context
                                .read<AgreementProvider>()
                                .createAgreement(
                                    context,
                                    widget.agenda.reunionId ?? '',
                                    widget.agenda.id ?? 0,
                                    ctrlNote.text,
                                    'Nota', // agreementTypeSelected.id,
                                    agreementTypePrivacitySelected.id,
                                    person,
                                    context
                                        .read<MeetProvider>()
                                        .listPerson
                                        .where((element) =>
                                            element.personalId == person)
                                        .first
                                        .personalNombreCompleto,
                                    '',
                                    null,
                                    null,
                                    null,
                                    null);
                            if (newAgreement != null) {
                              widget.onCreated(newAgreement);
                              ctrlNote.clear();
                              widget.onClose();
                            }
                          });
                    })),
              ],
            ),
          ],
        ));
  }
}

Widget _wrapperForm(BuildContext context, Widget child) {
  return Container(
      padding: const EdgeInsets.all(15.0),
      decoration: BoxDecoration(
        color: AppColors.firstBackgroundContainer(context),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: child);
}
