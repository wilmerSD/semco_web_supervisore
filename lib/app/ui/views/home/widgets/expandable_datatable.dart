import 'package:app_tasking/domain/entities/project.dart';
import 'package:app_tasking/infrastructure/models/project_model.dart';
import 'package:app_tasking/infrastructure/models/response/response_list_proyects_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_expandable_table/flutter_expandable_table.dart';

// Modelos de ejemplo (adáptalos a los tuyos)
class DataTask {
  final String id;
  final String? taskName;
  List<DataSubTask>? children;
  DataTask({required this.id, this.taskName, this.children});
}

class DataSubTask {
  final String id;
  final String? subTaskName;
  DataSubTask({required this.id, this.subTaskName});
}

// Widget que renderiza la tabla de proyectos y dispara callbacks para cargar hijos
class ProjectsExpandableTable extends StatelessWidget {
  final List<Project> projects; // tu clase existente
  final Future<List<DataTask>> Function(String projectId) loadTasks;
  final Future<List<DataSubTask>> Function(String taskId)? loadSubTasks;

  const ProjectsExpandableTable({
    Key? key,
    required this.projects,
    required this.loadTasks,
    this.loadSubTasks,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final headers = <ExpandableTableHeader>[
      ExpandableTableHeader(
          cell: ExpandableTableCell(
              child: Padding(
        padding: const EdgeInsets.all(0.0),
        child: Text('Cliente', style: TextStyle(fontWeight: FontWeight.bold)),
      ))),
      ExpandableTableHeader(
          cell: ExpandableTableCell(
              child: Padding(
        padding: const EdgeInsets.all(0.0),
        child: Text('Estado', style: TextStyle(fontWeight: FontWeight.bold)),
      ))),
    ];

    final rows = projects.map((p) => _projectRow(p)).toList();
    print(rows);
    return ExpandableTable(
      headers: headers,
      rows: rows,
      firstColumnWidth: 320,
      defaultsColumnWidth: 160,
      firstHeaderCell: ExpandableTableCell(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child:
              Text('Proyecto', style: TextStyle(fontWeight: FontWeight.bold)),
        ),
      ),
    );
  }

  ExpandableTableRow _projectRow(Project proyecto) {
    return ExpandableTableRow(
      // desactivamos la expansión automática para controlar cuándo expandir
      disableDefaultOnTapExpansion: true,

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
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text('Cargando tareas...'),
                      ),
                    ),
                  )
                ];
                row.notifyListeners();

                try {
                  final tasks = await loadTasks(proyecto.id!);
                  // mapeamos cada task a una ExpandableTableRow
                  final taskRows = tasks.map((t) => _taskRow(t)).toList();
                  row.children = taskRows;
                } catch (e) {
                  row.children = [
                    ExpandableTableRow(
                      firstCell: ExpandableTableCell(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
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
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(proyecto.campanaNombre ?? 'Sin nombre'),
            ),
          );
        },
      ),
      // otras columnas de la fila de proyecto
      cells: [
        ExpandableTableCell(
            child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(proyecto.clienteNombre ?? ''),
        )),
        ExpandableTableCell(
            child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(proyecto.campanaEstado ?? ''),
        )),
      ],
    );
  }

  ExpandableTableRow _taskRow(DataTask task) {
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
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text('Cargando subtareas...'),
                      ),
                    ),
                  )
                ];
                row.notifyListeners();

                try {
                  if (loadSubTasks != null) {
                    final subs = await loadSubTasks!(task.id);
                    row.children = subs.map((s) {
                      return ExpandableTableRow(
                        firstCell: ExpandableTableCell(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(s.subTaskName ?? ''),
                          ),
                        ),
                      );
                    }).toList();
                  } else {
                    row.children = []; // no hay subtasks configuradas
                  }
                } catch (e) {
                  row.children = [
                    ExpandableTableRow(
                      firstCell: ExpandableTableCell(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text('Error al cargar subtareas'),
                        ),
                      ),
                    )
                  ];
                }
              }
              row.toggleExpand();
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(task.taskName ?? ''),
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
