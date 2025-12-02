import 'package:app_tasking/app/ui/components/btn/btn_cancel_second.dart';
import 'package:app_tasking/app/ui/components/btn/btn_gen.dart';
import 'package:app_tasking/app/ui/components/btn/btn_save_second.dart';
import 'package:app_tasking/app/ui/components/horizontal_person_list.dart';
import 'package:app_tasking/app/ui/components/popup/side_panel_container.dart';
import 'package:app_tasking/app/ui/views/meet/btn/btn_meet_gen.dart';
import 'package:app_tasking/app/ui/views/meet/meet_provider.dart';
import 'package:app_tasking/app/ui/views/meet/views/timeline_horizontal.dart';
import 'package:app_tasking/app/ui/views/meet/widgets/list_agenda.dart';
import 'package:app_tasking/app/ui/views/meet/widgets/new_meet.dart';
import 'package:app_tasking/core/helpers/helpers.dart';
import 'package:app_tasking/core/theme/app_colors.dart';
import 'package:app_tasking/core/theme/app_text_style.dart';
import 'package:app_tasking/domain/entities/meet.dart';
import 'package:app_tasking/domain/entities/participant.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:provider/provider.dart';
import 'package:timelines_plus/timelines_plus.dart';

class MeetDetail extends StatelessWidget {
  final Meet meet;
  final VoidCallback? onDeleted;
  final Meet parentMeet;
  const MeetDetail(this.meet,
      {super.key, this.onDeleted, required this.parentMeet});

  @override
  Widget build(BuildContext context) {
    final meetProvider = Provider.of<MeetProvider>(context);
    final currentParticipant = meetProvider.participantsDetail.firstWhere(
        (p) => p.personalId == meetProvider.personalId,
        orElse: () => Participant());

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
      decoration: BoxDecoration(
        color: AppColors.backgroundColor(context),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Row(
        spacing: 20.0,
        children: [
          Expanded(
            child: Column(
              spacing: 20.0,
              children: [
                // Container(
                //   width: double.infinity,
                //   height: 50.0,
                //   padding: const EdgeInsets.symmetric(horizontal: 10.0),
                //   decoration: BoxDecoration(
                //     borderRadius: BorderRadius.circular(8.0),
                //     color: AppColors.firstBackgroundContainer(context),
                //   ),
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //     children: [
                //       Align(
                //           alignment: Alignment.centerLeft,
                //           child: _tittle(context, meet.reunionTitulo ?? '')),
                //       SizedBox(
                //           width: 120,
                //           height: 38,
                //           child: BtnSaveSecond(
                //             text: 'Agendar reunión',
                //             onTap: () {
                //               context
                //                   .read<MeetProvider>()
                //                   .toCreateInBaseMeet(meet);
                //               showSidePanel(context,
                //                   title: 'Nueva reunión',
                //                   child: const NewMeet(),
                //                   floatingActionButton:
                //                       const BtnsSaveAndCancelMeet());
                //             },
                //           )),
                //     ],
                //   ),
                // ),
                Container(
                  padding: const EdgeInsets.all(20.0),
                  decoration: BoxDecoration(
                    color: AppColors.firstBackgroundContainer(context),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Column(
                    spacing: 15.0,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextButton.icon(
                            onPressed: () {
                              meetProvider.showDetailHeaderMeet();
                            },
                            icon: Icon(
                                meetProvider.showDetailHeader
                                    ? Bootstrap.caret_down_fill
                                    : Bootstrap.caret_up_fill,
                                color: AppColors.primaryConst),
                            label: _tittle(
                              context,
                              meet.reunionTitulo ?? '',
                            ),
                          ),
                          // Align(
                          //     alignment: Alignment.centerLeft,
                          //     child:
                          //         _tittle(context, meet.reunionTitulo ?? '')),
                          SizedBox(
                              width: 120,
                              height: 38,
                              child: BtnSaveSecond(
                                text: 'Agendar reunión',
                                onTap: () {
                                  context
                                      .read<MeetProvider>()
                                      .toCreateInBaseMeet(meet);
                                  showSidePanel(context,
                                      title: 'Nueva reunión',
                                      child: const NewMeet(),
                                      floatingActionButton:
                                          const BtnsSaveAndCancelMeet());
                                },
                              )),
                        ],
                      ),
                      if (meetProvider.showDetailHeader)
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              spacing: 12.0,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      spacing: 10.0,
                                      children: [
                                        _labelFirstColumn(
                                          context,
                                          'Ubicación: ',
                                        ),
                                        SelectableText(
                                          meet.reunionLugar ?? '',
                                          style: AppTextStyle(
                                            context,
                                          ).bold14(fontWeight: FontWeight.w300),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                if (meet.reunionClienteNombre!.isNotEmpty)
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        spacing: 10.0,
                                        children: [
                                          _labelFirstColumn(
                                            context,
                                            'Área de trabajo: ',
                                          ),
                                          _textValue(
                                            context,
                                            meet.reunionClienteNombre ?? '',
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                Row(
                                  spacing: 10.0,
                                  children: [
                                    _labelFirstColumn(
                                      context,
                                      'Participantes ',
                                    ),
                                    const SizedBox(
                                      width: 200,
                                      child: HorizontalPersonList(),
                                    )
                                  ],
                                ),
                              ],
                            ),
                            // const Spacer(),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              spacing: 12.0,
                              children: [
                                Row(
                                  spacing: 10.0,
                                  children: [
                                    _labelFirstColumn(
                                      context,
                                      'Estado de la reunión: ',
                                    ),
                                    _textValue(
                                      context,
                                      meet.reunionGrupoPro ?? '',
                                    ),
                                  ],
                                ),
                                if (meet.reunionProyectoNombre?.isNotEmpty ??
                                    false)
                                  Row(
                                    spacing: 10.0,
                                    children: [
                                      _labelFirstColumn(
                                        context,
                                        'Proyecto: ',
                                      ),
                                      _textValue(
                                          context, meet.reunionProyectoNombre!),
                                    ],
                                  ),
                                Row(
                                  spacing: 10.0,
                                  children: [
                                    _labelFirstColumn(
                                      context,
                                      'Horario: ',
                                    ),
                                    _textValue(
                                        context,
                                        Helpers.getRangoHora(
                                            reunionHoraIni:
                                                meet.reunionHoraIni ?? '',
                                            reunionTotalHoras:
                                                meet.reunionTotalHoras ?? 0,
                                            reunionMinutos:
                                                meet.reunionMinutos ?? 0)),
                                  ],
                                ),
                              ],
                            ),

                            Column()
                          ],
                        ),
                      //Asunto
                      if (meetProvider.showDetailHeader)
                        Row(
                          spacing: 10.0,
                          children: [
                            _labelFirstColumn(
                              context,
                              'Asunto ',
                            ),
                            SizedBox(
                              width: 800,
                              child: _textValue(
                                context,
                                meet.reunionAsunto ?? '',
                              ),
                            )
                          ],
                        ),
                      //Botones
                      if (meetProvider.showDetailHeader)
                        if (meet.reunionStateMeet != 'Finalizado')
                          Row(
                            spacing: 10.0,
                            children: [
                              if (currentParticipant.state == 'Rechazado' ||
                                  currentParticipant.state == 'Pendiente')
                                SizedBox(
                                    width: 120,
                                    height: 38,
                                    child: BtnSaveSecond(
                                      text: 'Asistiré',
                                      onTap: () async {
                                        // print(meet.reunionStateMeet);
                                        final response = await context
                                            .read<MeetProvider>()
                                            .postResponseMeet(
                                                context,
                                                meet.reunionId ?? '',
                                                'Aceptado');
                                        if (response) {
                                          currentParticipant.state = 'Aceptado';
                                        }
                                      },
                                    )),
                              if (currentParticipant.state == 'Aceptado' ||
                                  currentParticipant.state == 'Pendiente')
                                SizedBox(
                                  width: 130.0,
                                  child: BtnGen(
                                    border: false,
                                    color: AppColors.backgroundColor(context),
                                    text: 'Rechazar',
                                    onTap: () async {
                                      final response = await context
                                          .read<MeetProvider>()
                                          .postResponseMeet(
                                              context,
                                              meet.reunionId ?? '',
                                              'Rechazado');
                                      if (response) {
                                        currentParticipant.state = 'Rechazado';
                                      }
                                    },
                                  ),
                                ),
                              if (currentParticipant.rol == 'Organizador')
                                Row(
                                  spacing: 10.0,
                                  children: [
                                    SizedBox(
                                      width: 130.0,
                                      child: BtnGen(
                                        border: false,
                                        color:
                                            AppColors.backgroundColor(context),
                                        text: 'Editar',
                                        onTap: () {
                                          context
                                              .read<MeetProvider>()
                                              .toCreateInBaseMeet(meet,
                                                  isEdit: true);
                                          showSidePanel(context,
                                              title: 'Editar reunión',
                                              child: const NewMeet(),
                                              floatingActionButton: Container(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 20.0,
                                                        vertical: 15.0),
                                                color:
                                                    AppColors.backgroundColor(
                                                        context),
                                                // margin: EdgeInsets.only(top: 100),
                                                child: Row(
                                                  spacing: 20.0,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                  children: [
                                                    SizedBox(
                                                      width: 150.0,
                                                      child: BtnCancelSecond(
                                                        text: 'Cancelar',
                                                        onTap: () =>
                                                            Navigator.pop(
                                                                context),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                        width: 150.0,
                                                        child: Consumer<
                                                                MeetProvider>(
                                                            builder: (context,
                                                                provider, _) {
                                                          return BtnSaveSecond(
                                                            loading: provider
                                                                .isCreatingMeet,
                                                            text: provider
                                                                    .isCreatingMeet
                                                                ? "Guardando"
                                                                : 'Guardar',
                                                            showBoxShadow:
                                                                false,
                                                            onTap: () {
                                                              // print('Tratando de guardar')
                                                              provider.saveMeet(
                                                                  context,
                                                                  meet: meet);
                                                            },
                                                          );
                                                        })),
                                                  ],
                                                ),
                                              ));
                                        },
                                      ),
                                    ),
                                    //Dar esta opcion solo si es el organizador o creador
                                    SizedBox(
                                      width: 130.0,
                                      child: BtnGen(
                                        text: 'Eliminar',
                                        onTap: () async {
                                          final ok =
                                              await meetProvider.deleteMeet(
                                                  context,
                                                  meet.reunionId ?? '',
                                                  parentMeet.reunionId ?? '');
                                          if (ok) {
                                            // meetProvider.listMeet.removeWhere(
                                            //     (m) =>
                                            //         m.reunionId ==
                                            //         meet.reunionId);
                                            print('aqui esta');
                                            onDeleted!(); // 👈 avisar al padre
                                            print('aqui esta2');
                                            Navigator.pop(
                                                context); // cerrar popup
                                          }
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              SizedBox(
                                width: 130.0,
                                child: BtnGen(
                                  text: 'Finalizar reunión',
                                  onTap: () {
                                    meetProvider.updateState(
                                        context, meet.reunionId ?? '');
                                  },
                                ),
                              ),
                            ],
                          ),
                    ],
                  ),
                ),
                Consumer<MeetProvider>(builder: (context, meetProvider, _) {
                  return Expanded(
                      child: Container(
                    padding: const EdgeInsets.all(20.0),
                    decoration: BoxDecoration(
                      color: AppColors.firstBackgroundContainer(context),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: 10.0,
                      children: [
                        Row(
                          children: [
                            _tittle(
                              context,
                              'Agenda',
                            ),
                            // IconButton(
                            //     onPressed: () {
                            //       meetProvider.getAgenda(meet.reunionId ?? '');
                            //     },
                            //     icon: Icon(
                            //       Bootstrap.arrow_clockwise,
                            //       size: 15,
                            //       color: AppColors.primaryConst,
                            //     ))
                          ],
                        ),
                        meetProvider.isGettingAgenda
                            ? const Center(
                                child: CircularProgressIndicator(),
                              )
                            : meetProvider.listAgenda.isEmpty
                                ? Center(
                                    child: Column(
                                      spacing: 10.0,
                                      children: [
                                        const Text(
                                            'No hay agenda para esta reunión'),
                                        SizedBox(
                                            width: 120,
                                            height: 38,
                                            child: BtnSaveSecond(
                                              text: 'Agregar agenda',
                                              onTap: () {
                                                context
                                                    .read<MeetProvider>()
                                                    .toCreateInBaseMeet(meet,
                                                        isEdit: true);
                                                showSidePanel(context,
                                                    title: 'Editar reunión',
                                                    child: const NewMeet(),
                                                    floatingActionButton:
                                                        Container(
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                          horizontal: 20.0,
                                                          vertical: 15.0),
                                                      color: AppColors
                                                          .backgroundColor(
                                                              context),
                                                      // margin: EdgeInsets.only(top: 100),
                                                      child: Row(
                                                        spacing: 20.0,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .end,
                                                        children: [
                                                          SizedBox(
                                                            width: 150.0,
                                                            child:
                                                                BtnCancelSecond(
                                                              text: 'Cancelar',
                                                              onTap: () =>
                                                                  Navigator.pop(
                                                                      context),
                                                            ),
                                                          ),
                                                          SizedBox(
                                                              width: 150.0,
                                                              child: Consumer<
                                                                      MeetProvider>(
                                                                  builder:
                                                                      (context,
                                                                          provider,
                                                                          _) {
                                                                return BtnSaveSecond(
                                                                  loading: provider
                                                                      .isCreatingMeet,
                                                                  text: provider
                                                                          .isCreatingMeet
                                                                      ? "Guardando"
                                                                      : 'Guardar',
                                                                  showBoxShadow:
                                                                      false,
                                                                  onTap: () {
                                                                    // print('Tratando de guardar')
                                                                    provider.saveMeet(
                                                                        context,
                                                                        meet:
                                                                            meet);
                                                                  },
                                                                );
                                                              })),
                                                        ],
                                                      ),
                                                    ));
                                              },
                                            )),
                                      ],
                                    ),
                                  )
                                : meetProvider.showAgenda
                                    ? /* Expanded(
                                        // height:  meetProvider.listAgenda.length * 10,
                                        child: ListView.builder(
                                            itemCount:
                                                meetProvider.listAgenda.length,
                                            itemBuilder: (context, index) {
                                              final agenda = meetProvider
                                                  .listAgenda[index];
                                              return _listAgenda(
                                                  context,
                                                  '0${index + 1}',
                                                  agenda.tittle,
                                                  agenda.associatedTypeName,
                                                  agenda.responsibleNames,
                                                  agenda.dateCreation);
                                            }),
                                      ) */
                                    const Expanded(child: ListAgenda())
                                    : const SizedBox()
                      ],
                    ),
                  ));
                }),
                Consumer<MeetProvider>(builder: (context, meetProvider, _) {
                  return Container(
                    // height: 100,
                    width: double.infinity,
                    padding: const EdgeInsets.all(20.0),
                    decoration: BoxDecoration(
                      color: AppColors.firstBackgroundContainer(context),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: 10.0,
                      children: [
                        TextButton.icon(
                          onPressed: () {
                            context
                                .read<MeetProvider>()
                                .showOrHideRelatedMeeting();
                          },
                          icon: Icon(
                              meetProvider.showRelatedMeetings
                                  ? Bootstrap.caret_down_fill
                                  : Bootstrap.caret_up_fill,
                              color: AppColors.primaryConst),
                          label: _tittle(
                            context,
                            'Reuniones conexas',
                          ),
                        ),
                        if (meetProvider.showRelatedMeetings)
                          Container(
                            height: 200,
                            width: 500,
                            child: HorizontalTimeline(
                              events: meetProvider.childrenMeets
                                  .map(
                                    (m) => TimelineEvent(
                                      title: m.reunionTitulo ?? '',
                                      date: m.meetStateDesc ?? '',
                                    ),
                                  )
                                  .toList(),
                            ),
                          )
                        // Container(
                        //   height: 200,
                        //   width: 500,
                        //   child: TimelineHorizontal(
                        //         events: meetProvider.childrenMeets.map((m) =>
                        //           TimelineEvent(
                        //             title: m.title,
                        //             date: m.date,
                        //           ),
                        //         ).toList(),
                        //       )
                        // )
                        // Container(
                        //   color: Colors.amber,
                        //   height: 100,
                        //   // child: Expanded(

                        //   //   child: SingleChildScrollView(
                        //   //     scrollDirection: Axis.horizontal,
                        //   //     // child: Center(
                        //   //     //   child: RoadmapTimeline(),
                        //   //     // ), // 👈 sin Expanded
                        //   //   ),
                        //   // ),
                        // )
                      ],
                    ),
                  );
                })
              ],
            ),
          ),
        ],
      ),
    );
  }
}

Widget _labelFirstColumn(BuildContext context, String text) {
  return SizedBox(
    width: 150.0,
    child: Text(
      text,
      style: AppTextStyle(context).bold15(),
    ),
  );
}

Widget _textValue(BuildContext context, String text) {
  return Text(
    text,
    style: AppTextStyle(
      context,
    ).bold14(fontWeight: FontWeight.w300),
  );
}

Widget _tittle(BuildContext context, String text) {
  return Text(text,
      style: AppTextStyle(
        context,
      ).bold18(color: AppColors.primaryConst));
}

Widget _listAgenda(
  BuildContext context,
  String index,
  String? tittle,
  String? nameAsociated,
  String? responsibleName,
  DateTime? dateCreated,
) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 8.0),
    child: Row(
      spacing: 20.0,
      children: [
        //TODO:Trabajarlo con expanded y flex
        Text(
          index,
          overflow: TextOverflow.ellipsis,
        ),
        Expanded(
            flex: 2,
            child: Text(tittle ?? '', overflow: TextOverflow.ellipsis)),
        Expanded(child: Text(nameAsociated ?? '')),
        Expanded(child: Text(responsibleName ?? '')),
        Expanded(child: Text(Helpers.formateDateTimeEsp(dateCreated))),
      ],
    ),
  );
}

class HorizontalTimeline extends StatelessWidget {
  final List<TimelineEvent> events;

  const HorizontalTimeline({super.key, required this.events});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 220,
      child: Stack(
        children: [
          /// ─────────────────────────────────────────────
          /// Línea horizontal detrás de los puntos
          /// ─────────────────────────────────────────────
          Positioned.fill(
            child: Center(
              child: Container(
                height: 2,
                color: Colors.orange.withOpacity(0.4),
              ),
            ),
          ),

          /// ─────────────────────────────────────────────
          /// Lista horizontal con puntos + contenido
          /// ─────────────────────────────────────────────
          ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            itemCount: events.length,
            itemBuilder: (context, index) {
              final event = events[index];
              final isUp = index % 2 == 0;

              return SizedBox(
                width: 120,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (isUp) _eventCard(event),

                    // Punto de línea
                    const DotIndicator(
                      size: 16,
                      color: Colors.orange,
                    ),

                    if (!isUp) _eventCard(event),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _eventCard(TimelineEvent event) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Column(
        children: [
          Text(
            event.title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            event.date,
            style: const TextStyle(
              fontSize: 11,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}

// class TimelineEvent {
//   final String title;
//   final String date;

//   TimelineEvent({required this.title, required this.date});
// }
