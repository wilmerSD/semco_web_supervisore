import 'package:app_tasking/app/providers/project_provider.dart';
import 'package:app_tasking/app/ui/components/card_swiper_projects.dart';
import 'package:app_tasking/app/ui/components/custom_app_bar.dart';
import 'package:app_tasking/app/ui/components/dropdown/dropdown_select.dart';
import 'package:app_tasking/app/ui/components/dropdown/option_select.dart';
import 'package:app_tasking/app/ui/components/header/header_options_home.dart';
import 'package:app_tasking/app/ui/components/horizontal_projects_list.dart';
import 'package:app_tasking/app/ui/components/input/web_date_picker_field.dart';
import 'package:app_tasking/app/ui/components/slider_projects.dart';
import 'package:app_tasking/app/ui/views/home/home_provider.dart';
import 'package:app_tasking/app/ui/views/meet/meet_provider.dart';
import 'package:app_tasking/core/theme/app_colors.dart';
import 'package:app_tasking/core/theme/app_text_style.dart';
import 'package:app_tasking/domain/entities/project.dart';
import 'package:app_tasking/infrastructure/models/option__select_model.dart';
import 'package:app_tasking/infrastructure/models/project_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_expandable_table/flutter_expandable_table.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:provider/provider.dart';

class HomeViewDesktop extends StatelessWidget {
  const HomeViewDesktop({super.key});

  @override
  Widget build(BuildContext context) {
    final homeProvider = Provider.of<HomeProvider>(context);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ProjectProviderP>().getListProjects(context, ProjectModel());
    });
    // Widget search = SizedBox(
    //   height: 40.0,
    //   child: SearchBar(
    //       elevation: WidgetStateProperty.all(0.0),
    //       backgroundColor:
    //           WidgetStateProperty.all(AppColors.backgroundColorSec(context)),
    //       leading: Icon(
    //         Icons.search,
    //         color: AppColors.textBasic(context),
    //       ),
    //       hintStyle: WidgetStateProperty.all(AppTextStyle(context).bold13()),
    //       hintText: "Buscar por nombre",
    //       textStyle: WidgetStateProperty.all(
    //         const TextStyle(
    //           color: Colors.black54,
    //           fontSize: 18,
    //         ),
    //       ),
    //       onSubmitted: (_) {
    //         homeProvider.getListProyects(context, null, null, null, null, null,
    //             null, null, null, null, homeProvider.searchProyectText);
    //       },
    //       onChanged: (value) {
    //         homeProvider.searchProyectText = value;
    //       }),
    // );

    return Scaffold(
      backgroundColor: AppColors.backgroundColor(context),
      appBar: CustomAppBar(
        context: context,
      ),
      body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Selector<HomeProvider, int>(
            selector: (_, provider) => provider.optionProyect,
            builder: (context, value, child) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.start, // Espaciar widgets
                mainAxisSize: MainAxisSize.max,
                children: [
                  const HeaderOptionsHome(),
                  const _HeaderSearch(),
                  // if (homeProvider.optionProyect == 1) const OptionsProyects(),
                  // const OptionDirector(),
                  // homeProvider.optionProyect == 1
                  //     ? const Flexible(
                  //         child: KanbanView(),
                  //       )
                  //     : const Flexible(
                  //         child: GanttView(),
                  //       ),
                  // Container(
                  //     height: 120.0,
                  //     margin: const EdgeInsets.only(top: 10.0),
                  //     padding: const EdgeInsets.symmetric(
                  //         horizontal: 40.0, vertical: 8.0),
                  //     decoration: BoxDecoration(
                  //       borderRadius: BorderRadius.circular(5.0),
                  //       color: AppColors.backgroundContainer(context),
                  //     ),
                  //     child: const HorizontalProjectsList()),
                  if (homeProvider.showProjectsInRow)
                    Container(
                        height: 120.0,
                        margin: const EdgeInsets.only(top: 10.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5.0),
                          color: AppColors.backgroundContainer(context),
                        ),
                        child: context
                                .watch<ProjectProviderP>()
                                .isGettingListProjects
                            ? const Center(child: CircularProgressIndicator())
                            : context
                                    .watch<ProjectProviderP>()
                                    .listProjects
                                    .isEmpty
                                ? const Center(
                                    child: Text(
                                        'No hay proyectos con el filtro seleccionado'),
                                  )
                                : SliderProjects(
                                    projects: context
                                        .watch<ProjectProviderP>()
                                        .listProjects,
                                  )),

                  const SizedBox(
                    height: 15.0,
                  ),
                  const Expanded(child: _Body())
                ],
              );
            },
          )),
      floatingActionButton: Container(
          padding: const EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: AppColors.backgroundColor(context),
            borderRadius: BorderRadius.circular(8.0),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2), // Shadow color
                spreadRadius: 1, // Extends the shadow in all directions
                blurRadius: 1, // Blurs the edges of the shadow
                offset:
                    const Offset(0, 0), // Controls the shadow's position (x, y)
              ),
            ],
          ),
          child: const InkWell(
            child: Text('Comunicator'),
          )),
    );
  }
}

class _HeaderSearch extends StatelessWidget {
  const _HeaderSearch();

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(8.0),
        margin: const EdgeInsets.only(top: 10.0),
        decoration: BoxDecoration(
            color: AppColors.backgroundContainer(context),
            borderRadius: BorderRadius.circular(5.0)),
        child: Column(
          children: [
            Row(
              spacing: 15.0,
              children: [
                _filterProject(),
                _filterWorkspace(),
                _filterDate(),
                _filterStateProject(),
                const Spacer(),
                _showOrHideProjectRow()
              ],
            ),
          ],
        ));
  }
}

Widget _filterProject() {
  return Consumer<HomeProvider>(
    builder: (context, meetProvider, _) {
      return SizedBox(
        height: 40.0,
        width: 250.0,
        child: DropdownSelect(
          // helperText: 'Tarea de:',
          label: 'Tipo de participación',
          icon: Bootstrap.duffle,
          value: meetProvider.listTypeParticipation.firstWhere(
            (element) => element.id == meetProvider.typeParticipation.id,
            orElse: () =>
                meetProvider.listTypeParticipation.first, // valor por defecto
          ),
          items: meetProvider.listTypeParticipation.map((element) {
            return DropdownMenuItem(
              value: element,
              child: OptionSelect(
                nameOption: element.text,
              ),
            );
          }).toList(),
          onChanged: (newValue) {
            meetProvider.typeParticipation = newValue as OptionSelectModel;
          },
        ),
      );
    },
  );
}

Widget _filterWorkspace() {
  return Consumer<HomeProvider>(
    builder: (context, meetProvider, _) {
      return SizedBox(
        height: 40.0,
        width: 250.0,
        child: DropdownSelect(
          // helperText: 'Tarea de:',
          label: 'Espacio de trabajo',
          icon: Bootstrap.duffle,
          value: meetProvider.listTypeParticipation.firstWhere(
            (element) => element.id == meetProvider.typeParticipation.id,
            orElse: () =>
                meetProvider.listTypeParticipation.first, // valor por defecto
          ),
          items: meetProvider.listTypeParticipation.map((element) {
            return DropdownMenuItem(
              value: element,
              child: OptionSelect(
                nameOption: element.text,
              ),
            );
          }).toList(),
          onChanged: (newValue) {
            meetProvider.typeParticipation = newValue as OptionSelectModel;
          },
        ),
      );
    },
  );
}

Widget _filterDate() {
  return SizedBox(
    width: 250.0,
    height: 40,
    child: Selector<HomeProvider, TextEditingController>(
      selector: (_, provider) => provider.ctrlDateFilter,
      builder: (context, ctrlDateMeet, _) {
        return WebDatePickerField(
          label: 'Fecha fin',
          // helperText: 'Fecha fin',
          icon: Bootstrap.calendar_event,
          controller: ctrlDateMeet,
          onDateSelected: (range) {
            print('Seleccionado: ${range.start}');
            // context.read<MeetProvider>().justUpdateUi(); // opcional
          },
        );
      },
    ),
  );
}

Widget _filterStateProject() {
  return Consumer<HomeProvider>(
    builder: (context, meetProvider, _) {
      return SizedBox(
        height: 40.0,
        width: 250.0,
        child: DropdownSelect(
          // helperText: 'Tarea de:',
          label: 'Estado de proyecto',
          icon: Bootstrap.duffle,
          value: meetProvider.listTypeParticipation.firstWhere(
            (element) => element.id == meetProvider.typeParticipation.id,
            orElse: () =>
                meetProvider.listTypeParticipation.first, // valor por defecto
          ),
          items: meetProvider.listTypeParticipation.map((element) {
            return DropdownMenuItem(
              value: element,
              child: OptionSelect(
                nameOption: element.text,
              ),
            );
          }).toList(),
          onChanged: (newValue) {
            meetProvider.typeParticipation = newValue as OptionSelectModel;
          },
        ),
      );
    },
  );
}

Widget _filterStateTask() {
  return Consumer<HomeProvider>(
    builder: (context, meetProvider, _) {
      return SizedBox(
        height: 40.0,
        width: 250.0,
        child: DropdownSelect(
          // helperText: 'Tarea de:',
          label: 'Estado de tareas',
          icon: Bootstrap.duffle,
          value: meetProvider.listTypeParticipation.firstWhere(
            (element) => element.id == meetProvider.typeParticipation.id,
            orElse: () =>
                meetProvider.listTypeParticipation.first, // valor por defecto
          ),
          items: meetProvider.listTypeParticipation.map((element) {
            return DropdownMenuItem(
              value: element,
              child: OptionSelect(
                nameOption: element.text,
              ),
            );
          }).toList(),
          onChanged: (newValue) {
            meetProvider.typeParticipation = newValue as OptionSelectModel;
          },
        ),
      );
    },
  );
}

Widget _showOrHideProjectRow() {
  return Selector<HomeProvider, bool>(
      selector: (_, provider) => provider.showProjectsInRow,
      builder: (context, showProjectsInRow, _) {
        return InkWell(
          borderRadius: BorderRadius.circular(8),
          onTap: () {
            context.read<HomeProvider>().showOrHideProjectsRow();
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: AppColors.primaryConst,
            ),
            child: Row(
              spacing: 4,
              children: [
                Icon(
                  showProjectsInRow ? Bootstrap.eye_slash : Bootstrap.eye,
                  size: 18.0,
                  color: AppColors.secondaryConst,
                ),
                Text(
                  showProjectsInRow ? 'Ocultar proyectos' : 'Mostrar proyectos',
                  style: AppTextStyle(context).bold15(
                      color: AppColors.secondaryConst,
                      fontWeight: FontWeight.w300),
                )
              ],
            ),
          ),
        );
      });
}

class _Body extends StatelessWidget {
  const _Body();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10.0),
      decoration: BoxDecoration(
          color: AppColors.backgroundContainer(context),
          borderRadius: BorderRadius.circular(5.0)),
      child: Column(
        children: [
          Row(
            children: [
              _tittleList(context, 'Proyecto', 300),
              _tittleList(context, 'Espacio', 100),
              _tittleList(context, 'Fecha fin', 100),
              _tittleList(context, '#Atrasados', 80),
              _tittleList(context, '#Riesgo', 100),
              _tittleList(context, '#Tareas', 100),
              _tittleList(context, '#Comentarios', 100),
              _tittleList(context, '%Avance', 100),
              _tittleList(context, 'Responsable', 300),
              _tittleList(context, 'Estado de tarea', 120),
              _tittleList(context, 'Estado kanban', 120),
              _tittleList(context, 'Copiar', 50),
              _tittleList(context, 'Tarea', 50),
              _tittleList(context, 'Comentar', 70),
              _tittleList(context, 'Gannt', 50),
            ],
          ),
          //Lista de archivos en vertical estilo director
          _ProjectExpandableTable(),
        ],
      ),
    );
  }
}

Widget _tittleList(BuildContext context, String text, double width) {
  return SizedBox(
      width: width,
      child: Text(
        text,
        style: AppTextStyle(context).bold15(),
      ));
}

class _ProjectExpandableTable extends StatelessWidget {
  const _ProjectExpandableTable();

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

// Widget que renderiza la tabla de proyectos y dispara callbacks para cargar hijos
class MeetsExpandableTable extends StatelessWidget {
  final List<Project> projects; // tu clase existente
  final Future<List<Project>> Function(String projectId) loadTask;

  const MeetsExpandableTable({
    super.key,
    required this.projects,
    required this.loadTask,
  });

  @override
  Widget build(BuildContext context) {
    final homeProvider = Provider.of<HomeProvider>(context);
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

    final rows = homeProvider.listProyects.map((p) => _projectRow(p)).toList();

    if (homeProvider.isGettingProjects) {
      return const Center(child: CircularProgressIndicator());
    }

    if (homeProvider.listProyects.isEmpty) {
      return const Center(child: Text("No hay proyectos"));
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

  ExpandableTableRow _projectRow(Project project) {
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
                  final projects = await loadTask(project.campanaid!);
                  // mapeamos cada task a una ExpandableTableRow
                  final taskRows = projects.map((t) => _taskRow(t)).toList();
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
                  Text(project.campanaNombre ?? 'Sin nombre'),
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
          Text(project.campanaEstados ?? 'Desconocido'),
        )),
        ExpandableTableCell(
            child: _custonRow(
          Text(project.campanaNombre ?? ''),
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

  ExpandableTableRow _taskRow(Project project) {
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
                        child: Text('Cargando projectos...'),
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
              child: Text(project.campanaNombre ?? ''),
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
