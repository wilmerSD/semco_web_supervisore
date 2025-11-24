import 'package:app_tasking/app/ui/components/btn/btn_cancel_second.dart';
import 'package:app_tasking/app/ui/components/btn/btn_save_second.dart';
import 'package:app_tasking/app/ui/components/custom_icon_button.dart';
import 'package:app_tasking/app/ui/components/dropdown/dropdown_select.dart';
import 'package:app_tasking/app/ui/components/dropdown/option_select.dart';
import 'package:app_tasking/app/ui/components/input/input_description.dart';
import 'package:app_tasking/app/ui/components/input/web_date_picker_field.dart';
import 'package:app_tasking/app/ui/components/rotating_icon.dart';
import 'package:app_tasking/app/ui/views/meet/agreement_provider.dart';
import 'package:app_tasking/app/ui/views/meet/btn/btn_meet_gen.dart';
import 'package:app_tasking/app/ui/views/meet/meet_provider.dart';
import 'package:app_tasking/core/helpers/helpers.dart';
import 'package:app_tasking/core/theme/app_colors.dart';
import 'package:app_tasking/core/theme/app_text_style.dart';
import 'package:app_tasking/domain/entities/agenda.dart';
import 'package:app_tasking/domain/entities/agreement.dart';
import 'package:app_tasking/domain/entities/area.dart';
import 'package:app_tasking/domain/entities/person.dart';
import 'package:app_tasking/domain/entities/project.dart';
import 'package:app_tasking/domain/entities/task.dart';
import 'package:app_tasking/infrastructure/models/option__select_model.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:provider/provider.dart';

class AgreementView extends StatelessWidget {
  const AgreementView({super.key});

  @override
  Widget build(BuildContext context) {
    final meetProvider = Provider.of<MeetProvider>(context);
    return ListView.builder(
      itemCount: meetProvider.listAgenda.length,
      itemBuilder: (context, index) {
        final agenda = meetProvider.listAgenda[index];
        return AgendaExpandableTile(agenda: agenda);
        return Container(
            decoration: BoxDecoration(color: Colors.amber
                // borderRadius: BorderRadius.circular(10.0)),
                // margin: const EdgeInsets.all(10.0),
                ),
            child: AgendaExpandableTile(agenda: agenda));
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
          // if (isLoadingChildren)
          //   const Padding(
          //     padding: EdgeInsets.all(16.0),
          //     child: Center(child: CircularProgressIndicator()),
          //   )
          // else if (agreements.isEmpty)
          //   const Padding(
          //     padding: EdgeInsets.all(16.0),
          //     child: Text('Sin acuerdos asociados'),
          //   )
          // else
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
                : agreements.isEmpty
                    ? Column(
                        spacing: 20.0,
                        children: [
                          const Center(
                            child: Text('Sin acuerdos asociados'),
                          ),
                          _AgreementForm(widget.agenda, _addAgreement)
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
                                  flex: 4,
                                  child:
                                      _subTittleChild(context, 'Descripción')),
                              Expanded(
                                  flex: 2,
                                  child: _subTittleChild(context, 'Tipo')),
                              Expanded(
                                  flex: 2,
                                  child:
                                      _subTittleChild(context, 'Asignado a')),
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
                            itemCount: agreements.length,
                            itemBuilder: (context, index) {
                              final agreement = agreements[index];
                              return Padding(
                                padding: const EdgeInsets.only(
                                    bottom: 20.0, right: 10.0),
                                child: Row(
                                  spacing: 15.0,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Expanded(
                                        flex: 4,
                                        child: _contentChild(context,
                                            agreement.name?.trim() ?? '')),
                                    Expanded(
                                        flex: 2,
                                        child: _contentChild(
                                            context, agreement.type ?? '')),
                                    Expanded(
                                        flex: 2,
                                        child: _contentChild(context, '')),
                                    Expanded(
                                        flex: 2,
                                        child: _contentChild(
                                            context,
                                            agreement.responsibleFullName ??
                                                '')),
                                    Expanded(
                                        flex: 1,
                                        child: _contentChild(
                                            context,
                                            agreement.limitDate ?? ''
                                            /* Helpers.ddMMyyyy(
                                                agreement.limitDate) */)),
                                    // Expanded(child: child)
                                    Container(
                                      // color: Colors.amber,

                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          CustomIconButton(
                                              onPressed: () {},
                                              iconData:
                                                  Bootstrap.pencil_square),
                                          CustomIconButton(
                                            onPressed: () {},
                                            iconData: Bootstrap.trash3,
                                            color: Colors.red,
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              );
                            },
                          ),
                          _AgreementForm(
                            widget.agenda,
                            _addAgreement,
                          )
                        ],
                      ),
          ),
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

class _AgreementForm extends StatefulWidget {
  final Agenda agenda;
  final Function(Agreement) onCreated; // 👈 callback
  const _AgreementForm(this.agenda, this.onCreated);

  @override
  State<_AgreementForm> createState() => _AgreementFormState();
}

class _AgreementFormState extends State<_AgreementForm> {
  final descController = TextEditingController();
  final TextEditingController ctrlDateLimitAgreement =
      TextEditingController(text: Helpers.dateToStringTimeDMY(DateTime.now()));
  Person personResponsible = Person(
    personalId: '-1',
    personalNombreCompleto: 'Seleccionar',
  );
  OptionSelectModel agreementTypeSelected =
      OptionSelectModel(id: 'Nota', text: 'Nota');
  OptionSelectModel agreementTypePrivacitySelected =
      OptionSelectModel(id: 'Publica', text: 'Pública');

  Project projectMeet = Project(
    campanaid: '0',
    campanaNombre: 'Seleccionar',
  );
  Task currentTaskAgenda = Task(
    id: '0',
    ordenProduccionTrabajoRealizar: 'Seleccionar',
  );
  Area clientMeet = Area(
    clienteId: '0',
    clienteNombre: 'Seleccionar',
  );
  @override
  void dispose() {
    descController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final meetProvider = context.read<MeetProvider>();
    return Column(
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
              ),
            ),
          ],
        ),
        Row(
          spacing: 15.0,
          children: [
            Expanded(
                child: DropdownSelect(
              label: 'Privacidad:',
              value: meetProvider.lisTypePrivacityAgreement.firstWhere(
                (element) => element.id == agreementTypePrivacitySelected.id,
                orElse: () => meetProvider
                    .lisTypePrivacityAgreement.first, // valor por defecto
              ),
              items: meetProvider.lisTypePrivacityAgreement.map((element) {
                return DropdownMenuItem(
                  value: element,
                  child: OptionSelect(
                    nameOption: element.text,
                  ),
                );
              }).toList(),
              onChanged: (newValue) {
                meetProvider.updateTypeOfMeet();
                agreementTypePrivacitySelected = newValue as OptionSelectModel;
              },
            )),
            Expanded(
                child: DropdownSelect(
              label: 'Tipo:',
              value: meetProvider.lisTypeAgreement.firstWhere(
                (element) => element.id == agreementTypeSelected.id,
                orElse: () =>
                    meetProvider.lisTypeAgreement.first, // valor por defecto
              ),
              items: meetProvider.lisTypeAgreement.map((element) {
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
            Expanded(
              child: DropdownSelect(
                label: 'Responsable:',
                value: meetProvider.listPersonResponsible.firstWhere(
                  (element) =>
                      element.personalId == personResponsible.personalId,
                  orElse: () => meetProvider
                      .listPersonResponsible.first, // valor por defecto
                ),
                items: meetProvider.listPersonResponsible.map((element) {
                  return DropdownMenuItem(
                    value: element,
                    child: OptionSelect(
                      nameOption: element.personalNombreCompleto,
                    ),
                  );
                }).toList(),
                onChanged: (newValue) {
                  personResponsible = newValue as Person;
                  print(personResponsible.personalNombreCompleto);
                },
              ),
            ),
            Expanded(
              child: SizedBox(
                  // width: 250.0,
                  height: 80.0,
                  child: WebDatePickerField(
                    label: 'Fecha límite',
                    icon: Bootstrap.calendar_event,
                    controller: ctrlDateLimitAgreement,
                    onDateSelected: (range) {
                      // print('Seleccionado: ${range.start}');
                      // meetProvider.justUpdateUi();
                    },
                  )),
            )
          ],
        ),
        if (agreementTypeSelected.id == 'Tarea')
          Row(
            spacing: 15.0,
            children: [
              Expanded(
                  child: DropdownSelect(
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
                onChanged: (newValue) {
                  clientMeet = newValue as Area;
                },
              )),

              //Deberian salirme solo los proyectos asociados al cliente seleccionado
              Expanded(
                  child: DropdownSelect(
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
                onChanged: (newValue) {
                  projectMeet = newValue as Project;
                  meetProvider.getTasks(project: projectMeet);
                },
              )),
              //Trabajar con selector para que no se actualice toda la vista
              Expanded(
                  child: DropdownSelect(
                label: 'Tarea:',
                // helperText: 'Proyecto:',
                icon: Bootstrap.duffle,
                value: meetProvider.listTaskAgenda.firstWhere(
                  (element) =>
                      element.ordenProduccionId ==
                      currentTaskAgenda.ordenProduccionId,
                  orElse: () =>
                      meetProvider.listTaskAgenda.first, // valor por defecto
                ),
                items: meetProvider.listTaskAgenda.map((element) {
                  return DropdownMenuItem(
                    value: element,
                    child: OptionSelect(
                        nameOption:
                            element.ordenProduccionTrabajoRealizar ?? ''),
                  );
                }).toList(),
                onChanged: (newValue) {
                  currentTaskAgenda = newValue as Task;
                  meetProvider.getListSubTask(
                      currentTaskAgenda); //Función para traer subtareas
                },
              )),
              //Trabajar con selector para que no se actualice toda la vista
              //Evaluar si se necesita otro combobox para subtarea
              Expanded(
                  child: DropdownSelect(
                label: 'Sub Tarea:',
                // helperText: 'Proyecto:',
                icon: Bootstrap.duffle,
                value: meetProvider.listTaskAgenda.firstWhere(
                  (element) =>
                      element.ordenProduccionId ==
                      meetProvider.currentTaskAgenda.ordenProduccionId,
                  orElse: () =>
                      meetProvider.listTaskAgenda.first, // valor por defecto
                ),
                items: meetProvider.listTaskAgenda.map((element) {
                  return DropdownMenuItem(
                    value: element,
                    child: OptionSelect(
                        nameOption:
                            element.ordenProduccionTrabajoRealizar ?? ''),
                  );
                }).toList(),
                onChanged: (newValue) {
                  meetProvider.currentTaskAgenda = newValue as Task;
                  print(meetProvider.currentTaskAgenda.id);
                  print('ui');
                },
              )),
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
                onTap: () => Navigator.pop(context),
              ),
            ),
            SizedBox(
                width: 150.0,
                child: Consumer<MeetProvider>(builder: (context, provider, _) {
                  return BtnSaveSecond(
                      loading: provider.isCreatingMeet,
                      text: provider.isCreatingMeet ? "Guardando" : 'Guardar',
                      showBoxShadow: false,
                      onTap: () async {
                        final newAgreement = await context
                            .read<AgreementProvider>()
                            .createAgreement(
                              widget.agenda.reunionId ?? '',
                              widget.agenda.id ?? 0,
                              descController.text,
                              agreementTypeSelected.id,
                              agreementTypePrivacitySelected.id,
                              personResponsible.personalId ?? '',
                              personResponsible.personalNombreCompleto ?? '',
                              ctrlDateLimitAgreement.text,
                              agreementTypeSelected.id != 'Tarea'
                                  ? null
                                  : projectMeet.campanaid ?? '',
                              agreementTypeSelected.id != 'Tarea'
                                  ? null
                                  : currentTaskAgenda.id,
                            );

                        final agreement = Agreement(
                          reunionId: widget.agenda.reunionId ?? '',
                          agendaId: widget.agenda.id ?? 0,
                          agreementId: newAgreement.agreementId,
                          name: descController.text,
                          privatity: agreementTypePrivacitySelected
                              .id, // "Pública" y "Privada: ,
                          type: agreementTypeSelected.id, //"Acuerdo" y "Nota: ,
                          responsibleId: personResponsible.personalId ?? '',
                          responsibleFullName:
                              personResponsible.personalNombreCompleto ?? '',
                          limitDate: ctrlDateLimitAgreement.text,
                          projectId: agreementTypeSelected.id != 'Tarea'
                              ? null
                              : projectMeet.campanaid ?? '',
                          taskId: agreementTypeSelected.id != 'Tarea'
                              ? null
                              : currentTaskAgenda.id,
                        );

                        widget.onCreated(agreement); // 👈 Notificar al padre

                        // context.read<AgreementProvider>().createAgreement(
                        //       widget.agenda.reunionId ?? '',
                        //       widget.agenda.id ?? 0,
                        //       descController.text,
                        //       agreementTypeSelected.id,
                        //       agreementTypePrivacitySelected.id,
                        //       personResponsible.personalId ?? '',
                        //       personResponsible.personalNombreCompleto ?? '',
                        //       ctrlDateLimitAgreement.text,
                        //       agreementTypeSelected.id != '2'
                        //           ? null
                        //           : projectMeet.companiaid ?? '',
                        //       agreementTypeSelected.id != '2'
                        //           ? null
                        //           : currentTaskAgenda.id,
                        //     );
                      });
                })),
          ],
        ),
      ],
    );
  }
}
