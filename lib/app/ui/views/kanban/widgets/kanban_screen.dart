import 'package:app_tasking/domain/entities/task.dart';
import 'package:app_tasking/infrastructure/models/response/response_list_task_model.dart';
import 'package:app_tasking/app/ui/views/kanban/kanban_provider.dart';
import 'package:app_tasking/core/helpers/helpers.dart';
import 'package:app_tasking/core/theme/app_colors.dart';
import 'package:app_tasking/core/theme/app_text_style.dart';
import 'package:app_tasking/infrastructure/models/task_model.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:provider/provider.dart';

class KanbanScreen extends StatefulWidget {
  const KanbanScreen({super.key});

  @override
  _KanbanScreenState createState() => _KanbanScreenState();
}

class _KanbanScreenState extends State<KanbanScreen> {
  List<TaskModel> toDo = [];
  List<TaskModel> inWork = [];
  List<TaskModel> underReview = [];
  List<TaskModel> finished = [];

  @override
  Widget build(BuildContext context) {
    final kanbanProvider =
        Provider.of<KanbanProvider>(context, listen: true);

    return Row(
      // scrollDirection: Axis.horizontal,
      children: [
        _buildSection("POR HACER", kanbanProvider.subTaskToDo, 'toDo'),
        _buildSection("EN TRABAJO", kanbanProvider.subTaskInWork, 'inWork'),
        _buildSection(
            "EN REVISION", kanbanProvider.subTaskInRevision, 'underReview'),
        _buildSection(
            "FINALIZADO", kanbanProvider.subTaskFinished, 'finished'),
      ],
    );
  }

  // Este es el método para remover la tarea de la lista original
  void _removeTaskFromList(Task task, String fromList) {
    final kanbanProvider =
        Provider.of<KanbanProvider>(context, listen: false);
    kanbanProvider.removeTask(task, fromList);
  }

  // Aquí va el resto del código, incluyendo el _buildSection y _buildDraggableCard
  Widget _buildSection(
      String title, List<Task> tasks, String listName) {
    return Expanded(
      child: DragTarget<Map<String, dynamic>>(
        onAcceptWithDetails: (details) {
          final task = details.data['task'] as Task;
          final fromList = details.data['fromList'] as String;

          setState(() {
            _removeTaskFromList(task, fromList);
            tasks.add(task);

            final kanbanController =
                Provider.of<KanbanProvider>(context, listen: false);
            kanbanController.updateStateKanban(task, listName);
          });
        },
        builder: (context, candidateData, rejectedData) {
          return Container(
            margin: const EdgeInsets.all(10.0),
            padding: const EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              color: AppColors.groupBackgroundKanbanColor(context),
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _customTitle(title, context),
                Expanded(
                  child: ListView.separated(
                    separatorBuilder: (context, index) => const SizedBox(
                      height: 10.0,
                    ),
                    itemCount: tasks.length,
                    itemBuilder: (context, index) {
                      return _buildDraggableCard(tasks[index], listName);
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _customTitle(String title, BuildContext context) {
    return title == 'POR HACER'
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title,
                  style: AppTextStyle(context).bold18(
                      fontWeight: FontWeight.bold,
                      color: const Color.fromRGBO(188, 188, 188, 1))),
              const Divider(),
            ],
          )
        : title == 'EN TRABAJO'
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title,
                      style: AppTextStyle(context).bold18(
                          fontWeight: FontWeight.bold,
                          color: const Color.fromRGBO(109, 189, 252, 1))),
                  const Divider(),
                ],
              )
            : title == 'EN REVISION'
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(title,
                          style: AppTextStyle(context).bold18(
                              fontWeight: FontWeight.bold,
                              color: const Color.fromRGBO(255, 165, 0, 1))),
                      const Divider(),
                    ],
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                        Text(title,
                            style: AppTextStyle(context).bold18(
                                fontWeight: FontWeight.bold,
                                color: const Color.fromRGBO(0, 209, 59, 1))),
                        const Divider(),
                      ]);
  }

  // El resto de tu código como _buildDraggableCard, etc.
  Widget _buildDraggableCard(Task task, String sourceList) {
    return Draggable<Map<String, dynamic>>(
      // Usamos un Map para incluir la lista de origen
      data: {
        'task': task,
        'fromList': sourceList
      }, // Incluye la tarea y la lista de origen
      feedback: Material(
        borderRadius: BorderRadius.circular(10.0),
        child: Container(
          width: 300.0,
          padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
          // margin: const EdgeInsets.symmetric(vertical: 5.0),

          decoration: BoxDecoration(
              color: AppColors.primary(context),
              borderRadius: BorderRadius.circular(10.0)),
          child: Column(
            spacing: 5.0,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                Helpers.capitalize(
                    task.ordenProduccionTrabajoRealizar ?? 'Sin tarea'),
                style: AppTextStyle(context)
                    .bold15(color: Colors.white, fontWeight: FontWeight.bold),
              ),
              Text(
                'Campaña de lanzamiento Unity /',
                style: AppTextStyle(context).bold13(
                    fontWeight: FontWeight.w400,
                    color: AppColors.textBasic(context)),
              ),
            ],
          ),
        ),
      ),
      childWhenDragging: Container(
        padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
        decoration: BoxDecoration(
            color: const Color.fromARGB(230, 255, 255, 255),
            borderRadius: BorderRadius.circular(10.0)),
        child: Column(
          spacing: 5.0,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              Helpers.capitalize(
                  task.ordenProduccionTrabajoRealizar ?? 'Sin tarea'),
              style: AppTextStyle(context).bold15(
                  color: const Color.fromARGB(120, 255, 255, 255),
                  fontWeight: FontWeight.bold),
            ),
            Text('Campaña de lanzamiento Unity /',
                style: AppTextStyle(context).bold13(
                  fontWeight: FontWeight.w400,
                  color: const Color.fromARGB(117, 7, 7, 7),
                ) // AppColors.textBasic(context)),
                ),
          ],
        ),
      ),
      child: Container(
        padding: const EdgeInsets.all(10.0),
        margin: const EdgeInsets.symmetric(vertical: 5.0),
        decoration: BoxDecoration(
          color: AppColors.listKanbanColor(context),
          borderRadius: BorderRadius.circular(5.0),
          // boxShadow: [
          //   BoxShadow(color: Colors.grey, blurRadius: 1),
          // ],
        ),
        child: Column(
          spacing: 5.0,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              Helpers.capitalize(
                  task.ordenProduccionTrabajoRealizar ?? 'Sin tarea'),
              style: AppTextStyle(context).bold15(
                  color: AppColors.textBasic(context),
                  fontWeight: FontWeight.bold),
            ),
            Text(
              'Campaña de lanzamiento Unity /',
              style: AppTextStyle(context).bold13(
                  fontWeight: FontWeight.w400,
                  color: AppColors.textBasic(context)),
            ),
            Row(
              spacing: 10.0,
              children: [
                Expanded(
                  child: LinearProgressIndicator(
                    borderRadius: BorderRadius.circular(8),
                    value: task.ordenAvance! / 100,
                    backgroundColor: Colors.grey[300],
                    color: AppColors.primary(context),
                    minHeight: 7,
                  ),
                ),
                const Text('')
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  spacing: 20.0,
                  children: [
                    _customPersonsProject(),
                    Row(
                      spacing: 3.0,
                      children: [
                        Icon(Icons.access_time,
                            color: Helpers.getDaysRemainingColor(
                                task.ordenFechaFin ?? '', context)),
                        Text(
                            '${Helpers.getDaysRemaining(task.ordenFechaFin ?? '')} días',
                            style: AppTextStyle(context).bold13(
                                color: Helpers.getDaysRemainingColor(
                                    task.ordenFechaFin ?? '', context))),
                      ],
                    ),
                    /* _indicators(
                        Bootstrap.clock_history, '1 día', context, Colors.red), */
                  ],
                ),
                _indicators(Bootstrap.chat_left, task.ordenCampo3 ?? '1',
                    context, Colors.black),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

Widget _customPersonsProject() {
  return Container(
    width: 65,
    height: 20,
    // color: Colors.grey,
    child: Stack(
      children: [
        Positioned(
            left: 45,
            child: _circlePerson(const Color.fromRGBO(240, 240, 240, 1))),
        Positioned(
            left: 30,
            child: _circlePerson(const Color.fromRGBO(235, 235, 235, 1))),
        Positioned(
            left: 15,
            child: _circlePerson(const Color.fromRGBO(227, 227, 227, 1))),
        Positioned(
            left: 0,
            child: _circlePerson(const Color.fromRGBO(217, 217, 217, 1)))
        /* Align(alignment: Alignment(0.45, 0), child: _circlePerson(Colors.red)),
        Align(
            alignment: Alignment(0.3, 0), child: _circlePerson(Colors.blue)),
        Align(
            alignment: AlignmentDirectional(0.15, 0),
            child: _circlePerson(Colors.yellow)),
        Align(
          alignment: AlignmentDirectional(0.0, 0),
          child: _circlePerson(Colors.green)), */
      ],
    ),
  );
}

Widget _circlePerson(Color color,) {
  return CircleAvatar(
    radius: 10.0,
    backgroundColor: color,
  );
}

Widget _indicators(
    IconData icon, String text, BuildContext context, Color color) {
  return Row(
    spacing: 2.0,
    children: [
      Icon(
        icon,
        color: color,
        size: 15.0,
      ),
      Text(
        text,
        style: AppTextStyle(context).bold13(color: color),
      ),
    ],
  );
}
