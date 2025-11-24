import 'package:app_tasking/app/ui/views/meet/meet_provider.dart';
import 'package:app_tasking/core/theme/app_colors.dart';
import 'package:app_tasking/domain/entities/meet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_expandable_table/flutter_expandable_table.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:provider/provider.dart';

// Widget que renderiza la tabla de proyectos y dispara callbacks para cargar hijos
class MeetsExpandableTable extends StatelessWidget {
  final List<Meet> meets; // tu clase existente
  final Future<List<Meet>> Function(String projectId) loadSubMeet;

  const MeetsExpandableTable({
    super.key,
    required this.meets,
    required this.loadSubMeet,
  });

  @override
  Widget build(BuildContext context) {
    final meetProvider = Provider.of<MeetProvider>(context);
    final sizeFour = MediaQuery.of(context).size.width * 0.1625;

    final headers = <ExpandableTableHeader>[
      _customHeader(
        'Área de trabajo',
        sizeFour,
      ),
      _customHeader(
        'Cantidad',
        sizeFour,
      ),
      _customHeader(
        'Intervalo de fechas',
        sizeFour,
      ),
      _customHeader('Comprimir todo', sizeFour),
    ];

    final rows = meetProvider.listMeet.map((p) => _meetRow(p)).toList();

    if (meetProvider.isGetMeetings) {
      return const Center(child: CircularProgressIndicator());
    }

    if (meetProvider.listMeet.isEmpty) {
      return const Center(child: Text("No hay reuniones"));
    }
    return ExpandableTable(
      defaultsRowHeight: 60.0,
      headerHeight: 30.0,
      headers: headers,
      rows: rows,
      firstColumnWidth: MediaQuery.of(context).size.width * 0.35,
      defaultsColumnWidth: 160,
      firstHeaderCell: ExpandableTableCell(
        child: const Padding(
          padding: EdgeInsets.zero,
          child: Text('Nombre', style: TextStyle(fontWeight: FontWeight.bold)),
        ),
      ),
    );
  }

  ExpandableTableRow _meetRow(Meet meet) {
    return ExpandableTableRow(
      // desactivamos la expansión automática para controlar cuándo expandir
      disableDefaultOnTapExpansion: false,

      firstCell: ExpandableTableCell(
        builder: (context, details) {
          final row = details.row!;
          return InkWell(
            onTap: () async {
              // si no tiene hijos, pedimos las tareas vía callback
              if (row.children == null) {
                // placeholder "cargando"
                row.children = [
                  ExpandableTableRow(
                    firstCell: ExpandableTableCell(
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text('Cargando reuniones hijos...'),
                      ),
                    ),
                  )
                ];
                row.notifyListeners();

                try {
                  final tasks = await loadSubMeet(meet.reunionId!);
                  // mapeamos cada task a una ExpandableTableRow
                  final taskRows = tasks.map((t) => _taskRow(t)).toList();
                  row.children = taskRows;
                } catch (e) {
                  row.children = [
                    ExpandableTableRow(
                      firstCell: ExpandableTableCell(
                        child: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text('Error al cargar tareas'),
                        ),
                      ),
                    )
                  ];
                }
              }
              // expandimos / colapsamos manualmente
              row.toggleExpand();
            },
            child: Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 12.0),
              margin: const EdgeInsets.only(top: 2.0, bottom: 2.0, left: 2.0),
              decoration: BoxDecoration(
                  color: AppColors.backgroundColor(context),
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(5.0),
                      bottomLeft: Radius.circular(5.0))),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(
                      Bootstrap.caret_right_fill,
                      size: 20,
                    ),
                    onPressed: () {},
                  ),
                  Text(meet.reunionTitulo ?? 'Sin nombre'),
                ],
              ),
            ),
          );
        },
      ),
      // otras columnas de la fila de meet
      cells: [
        ExpandableTableCell(
            child: _custonRow(
          Text(meet.reunionClienteNombre ?? 'Desconocido'),
        )),
        ExpandableTableCell(
            child: _custonRow(
          Text(meet.reunionText04 ?? ''),
        )),
        ExpandableTableCell(
            child: _custonRow(
          Text(/* meet.reunionClase ?? */ '20 ago 2025 - 15 set 2025'),
        )),
        ExpandableTableCell(
          child: _custonRow(const SizedBox()),
        )
      ],
    );
  }

  ExpandableTableRow _taskRow(Meet task) {
    return ExpandableTableRow(
      disableDefaultOnTapExpansion: true,
      firstCell: ExpandableTableCell(
        builder: (context, details) {
          final row = details.row!;
          return InkWell(
            onTap: () async {
              if (row.children == null) {
                row.children = [
                  ExpandableTableRow(
                    firstCell: ExpandableTableCell(
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text('Cargando subtareas...'),
                      ),
                    ),
                  )
                ];
                row.notifyListeners();
              }
              row.toggleExpand();
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(task.reuniomAreaConoci ?? ''),
            ),
          );
        },
      ),
      cells: [
        // completa columnas si necesitas
      ],
    );
  }
}

ExpandableTableHeader _customHeader(
  String title,
  double sizeWith, {
  EdgeInsetsGeometry padding = const EdgeInsets.all(0.0),
}) {
  return ExpandableTableHeader(
    width: sizeWith,
    cell: ExpandableTableCell(
      child: Padding(
        padding: padding,
        child: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
    ),
  );
}

Widget _custonRow(Widget child) {
  return Builder(
    builder: (context) => Container(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 12.0),
      margin: const EdgeInsets.only(top: 2.0, bottom: 2.0),
      decoration: BoxDecoration(
          color: AppColors.backgroundColor(context),
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(5.0), bottomLeft: Radius.circular(5.0))),
      child: child,
    ),
  );
}
