import 'package:app_tasking/app/ui/components/btn/btn_cancel_second.dart';
import 'package:app_tasking/app/ui/components/btn/btn_save_second.dart';
import 'package:app_tasking/app/ui/components/popup/side_panel_container.dart';
import 'package:app_tasking/app/ui/views/meet/btn/btn_meet_gen.dart';
import 'package:app_tasking/app/ui/views/meet/meet_provider.dart';
import 'package:app_tasking/app/ui/views/meet/widgets/meet_detail.dart';
import 'package:app_tasking/app/ui/views/meet/widgets/new_meet.dart';
import 'package:app_tasking/core/helpers/helpers.dart';
import 'package:app_tasking/core/theme/app_colors.dart';
import 'package:app_tasking/core/theme/app_text_style.dart';
import 'package:app_tasking/domain/entities/meet.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MeetExpandableTable extends StatelessWidget {
  const MeetExpandableTable({super.key});

  @override
  Widget build(BuildContext context) {
    final meetProvider = Provider.of<MeetProvider>(context);
    return ListView.builder(
      itemCount: meetProvider.listMeet.length,
      itemBuilder: (context, index) {
        final meet = meetProvider.listMeet[index];
        return Container(
            decoration: BoxDecoration(
                color: AppColors.backgroundColor(context),
                borderRadius: BorderRadius.circular(10.0)),
            margin: const EdgeInsets.all(10.0),
            child: MeetExpandableTile(meet: meet));
      },
    );
  }
}

class MeetExpandableTile extends StatefulWidget {
  final Meet meet;

  const MeetExpandableTile({super.key, required this.meet});

  @override
  State<MeetExpandableTile> createState() => _MeetExpandableTileState();
}

class _MeetExpandableTileState extends State<MeetExpandableTile> {
  bool isLoadingChildren = false;
  List<Meet> childMeetings = [];

  Future<void> _loadChildren() async {
    setState(() => isLoadingChildren = true);
    final meetChild = await context
        .read<MeetProvider>()
        .getMeetingsChild(reunionId: widget.meet.reunionId ?? '');
    setState(() {
      childMeetings = meetChild;
      isLoadingChildren = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        dividerColor: Colors.transparent, // 🔥 elimina las líneas grises
        splashColor: Colors.transparent, // quita el efecto splash
        highlightColor: Colors.transparent, // quita el highlight al tocar
      ),
      child: ExpansionTile(
        // leading: const Icon(Bootstrap.caret_up_fill), // 🔥 icono a la izquierda
        // trailing: const Icon(Icons.arrow_drop_down_circle), // icono personalizado
        onExpansionChanged: (bool expanded) {
          if (expanded) {
            _loadChildren();
          }
          /* if (expanded && childMeetings.isEmpty) {
            _loadChildren();
          } */
        },
        title: Row(
          children: [
            SizedBox(
              width: 370.0,
              child: Text(widget.meet.reunionTitulo ?? '',
                  style: const TextStyle()),
            ),
            const SizedBox(width: 8),
            SizedBox(
                width: 300.0,
                child: Text(widget.meet.reunionClienteNombre ?? '')),
            const SizedBox(width: 8),
            Text("${widget.meet.reunionQuantityChildrend}"),
            Expanded(
                child: Center(
              child: Text(Helpers.formatRangeDate(
                  widget.meet.reunionOldestDate ?? '',
                  widget.meet.reunionNewestDate ?? '')),
            )),
            Expanded(
              child: Center(
                child: SizedBox(
                  width: 200,
                  child: BtnMeetGen(
                    text: 'Agendar reunión',
                    onTap: () {
                      context
                          .read<MeetProvider>()
                          .toCreateInBaseMeet(widget.meet);
                      showSidePanel(context,
                          title: 'Nueva reunión',
                          child: const NewMeet(),
                          floatingActionButton: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20.0, vertical: 15.0),
                            color: AppColors.backgroundColor(context),
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
                                    child: Consumer<MeetProvider>(
                                        builder: (context, provider, _) {
                                      return BtnSaveSecond(
                                        loading: provider.isCreatingMeet,
                                        text: provider.isCreatingMeet
                                            ? "Guardando"
                                            : 'Guardar',
                                        showBoxShadow: false,
                                        onTap: () {
                                          // print('Tratando de guardar')
                                          provider.createMeet(context);
                                        },
                                      );
                                    })),
                              ],
                            ),
                          ));
                    },
                  ),
                ),
              ),
            )
          ],
        ),
        children: [
          if (isLoadingChildren)
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Center(child: CircularProgressIndicator()),
            )
          else if (childMeetings.isEmpty)
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text('Sin reuniones asociadas'),
            )
          else
            Container(
              margin:
                  const EdgeInsets.only(left: 50.0, right: 50.0, bottom: 20.0),
              padding: const EdgeInsets.only(left: 15.0, top: 15.0),
              decoration: BoxDecoration(
                  color: AppColors.firstBackgroundContainer(context),
                  borderRadius: BorderRadius.circular(5.0)),
              child: Column(
                spacing: 10.0,
                children: [
                  Row(
                    children: [
                      _subTittleChild(context, 'N.', width: 50.0),
                      _subTittleChild(context, 'Nombre', width: 350.0),
                      _subTittleChild(context, 'Área de trabajo', width: 250),
                      _subTittleChild(context, 'Estado', width: 100),
                      _subTittleChild(
                        context,
                        'Fecha',
                      ),
                      _subTittleChild(
                        context,
                        'Hora',
                      ),
                      _subTittleChild(
                        context,
                        'Ubicación',
                      ),
                    ],
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: childMeetings.length,
                    itemBuilder: (context, index) {
                      final childMeet = childMeetings[index];
                      return Padding(
                        padding:
                            const EdgeInsets.only(bottom: 10.0, right: 10.0),
                        child: Row(
                          children: [
                            _contentChild(context, '0${index + 1}',
                                width: 50.0),
                            _contentChild(
                                context, childMeet.reunionTitulo ?? '',
                                width: 350.0),
                            _contentChild(
                                context, childMeet.reunionClienteNombre ?? '',
                                width: 250.0),
                            _contentChild(context, childMeet.meetStateDesc!,
                                width: 100.0),
                            _contentChild(
                                context,
                                Helpers.formateDateTimeEsp(
                                    childMeet.reunionFecha)),
                            _contentChild(
                                context,
                                Helpers.getRangoHora(
                                    reunionHoraIni:
                                        childMeet.reunionHoraIni ?? '',
                                    reunionTotalHoras:
                                        childMeet.reunionTotalHoras ?? 0,
                                    reunionMinutos:
                                        childMeet.reunionMinutos ?? 0)),
                            _contentChild(
                                context, childMeet.reunionLugar ?? ''),
                            Expanded(
                              child: _btnsByState(
                                context,
                                childMeet,
                                widget.meet,
                                () {
                                  setState(() {
                                    childMeetings.remove(childMeet);
                                  });
                                },
                              ),
                            )
                          ],
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

Widget _subTittleChild(BuildContext context, String text,
    {double? width = 200.0}) {
  return SizedBox(
    width: width,
    child: Text(text,
        style: AppTextStyle(context).bold14(fontWeight: FontWeight.bold)),
  );
}

Widget _contentChild(BuildContext context, String text,
    {double? width = 200.0}) {
  return SizedBox(
    width: width,
    child: Text(
      text,
      style: AppTextStyle(context).bold14(),
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
    ),
  );
}

Widget _btnsByState(
    BuildContext context, Meet childMeet, Meet meet, VoidCallback onDeleted) {
  final normalizedState = childMeet.reunionStateMeet!.trim().toLowerCase();

  return Row(
    children: [
      normalizedState == 'pendiente'
          ? Expanded(
              child: Row(
                spacing: 15.0,
                children: [
                  Expanded(
                    child: BtnMeetGen(
                      text: 'Ver',
                      onTap: () {
                        context.read<MeetProvider>().getDetailMeet(childMeet);
                        showSidePanel(
                          context,
                          // title: 'Detalle',
                          child: MeetDetail(
                            childMeet,
                            onDeleted: onDeleted,
                            parentMeet: meet,
                          ),
                        );
                      },
                    ),
                  ),
                  Expanded(
                    child: BtnMeetGen(
                      text: 'Aceptar',
                      onTap: () {
                        context.read<MeetProvider>().postResponseMeet(
                            context, childMeet.reunionId ?? '', 'Aceptado');
                      },
                    ),
                  ),
                  Expanded(
                    child: BtnMeetGen(
                      text: 'Rechazar',
                      onTap: () {
                        context.read<MeetProvider>().postResponseMeet(
                            context, childMeet.reunionId ?? '', 'Rechazado');
                      },
                    ),
                  )
                ],
              ),
            )
          : normalizedState == 'aceptado'
              ? Expanded(
                  child: Row(
                  spacing: 15.0,
                  children: [
                    const Expanded(child: SizedBox()),
                    Expanded(
                      child: BtnMeetGen(
                        text: 'Ver',
                        onTap: () {
                          context.read<MeetProvider>().getDetailMeet(childMeet);
                          showSidePanel(
                            context,
                            // title: 'Detalle',
                            child: MeetDetail(
                              childMeet,
                              parentMeet: meet,
                              onDeleted: onDeleted,
                            ),
                          );
                        },
                      ),
                    ),
                    Expanded(
                      child: BtnMeetGen(
                        text: 'Rechazar',
                        onTap: () {
                          context.read<MeetProvider>().postResponseMeet(
                              context, childMeet.reunionId ?? '', 'Rechazado');
                        },
                      ),
                    )
                    // const Expanded(child: SizedBox()),
                  ],
                ))
              : normalizedState == 'rechazado'
                  ? Expanded(
                      child: Row(spacing: 15.0, children: [
                        Expanded(
                          child: BtnMeetGen(
                            text: 'Ver',
                            onTap: () {
                              context
                                  .read<MeetProvider>()
                                  .getDetailMeet(childMeet);
                              showSidePanel(
                                context,
                                // title: 'Detalle',
                                child: MeetDetail(
                                  childMeet,
                                  onDeleted: onDeleted,
                                  parentMeet: meet,
                                ),
                              );
                            },
                          ),
                        ),
                        Expanded(
                          child: BtnMeetGen(
                            text: 'Aceptar',
                            onTap: () {
                              context.read<MeetProvider>().postResponseMeet(
                                  context,
                                  childMeet.reunionId ?? '',
                                  'Aceptado');
                            },
                          ),
                        )
                      ]),
                    )
                  : normalizedState == 'finalizado'
                      ? Expanded(
                          child: Row(
                          children: [
                            const Expanded(child: SizedBox()),
                            Expanded(
                              child: BtnMeetGen(
                                text: 'Ver acta',
                                onTap: () {
                                  context
                                      .read<MeetProvider>()
                                      .getDetailMeet(childMeet);
                                  showSidePanel(
                                    context,
                                    // title: 'Detalle',
                                    child: MeetDetail(
                                      childMeet,
                                      parentMeet: meet,
                                      onDeleted: onDeleted,
                                    ),
                                  );
                                },
                              ),
                            ),
                            const Expanded(child: SizedBox()),
                          ],
                        ))
                      : Expanded(
                          child: Row(
                          children: [
                            const Expanded(child: SizedBox()),
                            Expanded(
                              child: BtnMeetGen(
                                text: 'Ver',
                                onTap: () {
                                  context
                                      .read<MeetProvider>()
                                      .getDetailMeet(childMeet);
                                  showSidePanel(
                                    context,
                                    // title: 'Detalle',
                                    child: MeetDetail(
                                      childMeet,
                                      parentMeet: meet,
                                      onDeleted: onDeleted,
                                    ),
                                  );
                                },
                              ),
                            ),
                            const Expanded(child: SizedBox()),
                          ],
                        ))

      //Boton de "ver" para todos
      //Botones de aceptar y rechazar cuando salga pendiente
      //Solo boton de ver acta cuando este finalizado
    ],
  );
}
