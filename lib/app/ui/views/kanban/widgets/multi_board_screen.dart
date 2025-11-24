import 'package:app_tasking/domain/entities/task.dart';
import 'package:app_tasking/infrastructure/models/response/response_list_task_model.dart';
import 'package:app_tasking/app/ui/components/popup/popup_general.dart';
import 'package:app_tasking/app/ui/views/kanban/kanban_provider.dart';
import 'package:app_tasking/app/ui/views/kanban/webview/webview_collaboration.dart';
import 'package:app_tasking/core/helpers/helpers.dart';
import 'package:app_tasking/core/theme/app_colors.dart';
import 'package:app_tasking/core/theme/app_text_style.dart';
import 'package:app_tasking/infrastructure/models/task_model.dart';
import 'package:flutter/material.dart';
import 'package:appflowy_board/appflowy_board.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

/* String route =
    'http://localhost/AppTaskingGX18NETFrameworkSQLServer/PhotoPersonal/'; */
/* String route =
    'https://app.task-ing.com/qa/PhotoPersonal/'; */
// String route =
//     'https://app.task-ing.com/vs1/PhotoPersonal/';
String route =
    'https://app.task-ing.com/demo/PhotoPersonal/';
    

class MultiBoardScreen extends StatefulWidget {
  const MultiBoardScreen({super.key});

  @override
  State<MultiBoardScreen> createState() => _MultiBoardScreenState();
}

class _MultiBoardScreenState extends State<MultiBoardScreen> {
  late AppFlowyBoardController controller;
  late AppFlowyBoardScrollController boardController;
  Key boardKey = UniqueKey(); // y en el build

  @override
  void initState() {
    List<Task> subtaskToDo = [];
    List<Task> subTaskInWork = [];
    List<Task> subTaskInRevision = [];
    List<Task> subTaskFinished = [];

    List<Task> originalSubtaskToDo = [];
    List<Task> originalSubTaskInWork = [];
    List<Task> originalSubTaskInRevision = [];
    List<Task> originalSubTaskFinished = [];

    controller = AppFlowyBoardController(
      onMoveGroup: (fromGroupId, fromIndex, toGroupId, toIndex) {
        debugPrint('Move item from $fromIndex to $toIndex❤️');
      },
      onMoveGroupItem: (groupId, fromIndex, toIndex) {
        debugPrint('Move $groupId:$fromIndex to $groupId:$toIndex😁');
        // Elegimos la lista según el grupo
        List<Task> currentList;
        switch (groupId) {
          case 'toDo':
            currentList = originalSubtaskToDo;
            break;
          case 'inWork':
            currentList = originalSubTaskInWork;
            break;
          case 'underReview':
            currentList = originalSubTaskInRevision;
            break;
          case 'finished':
            currentList = originalSubTaskFinished;
            break;
          default:
            return;
        }

        switch (groupId) {
          case 'toDo':
            originalSubtaskToDo = currentList;
            break;
          case 'inWork':
            originalSubTaskInWork = currentList;
            break;
          case 'underReview':
            originalSubTaskInRevision = currentList;
            break;
          case 'finished':
            originalSubTaskFinished = currentList;
            break;
          default:
            return;
        }

        if (fromIndex < 0 || fromIndex >= currentList.length) return;
        if (toIndex < 0 || toIndex > currentList.length) return;

        // Extraemos la tarea y la volvemos a insertar en la nueva posición
        final task = currentList.removeAt(fromIndex);
        currentList.insert(toIndex, task);
         WidgetsBinding.instance.addPostFrameCallback((_) {
          final kanbanProvider =
              Provider.of<KanbanProvider>(context, listen: false);
            kanbanProvider.updateIndexTaskSubTask(currentList);
          
        });
      },
      onMoveGroupItemToGroup: (fromGroupId, fromIndex, toGroupId, toIndex) {
        debugPrint('Move $fromGroupId:$fromIndex to $toGroupId:$toIndex😒');

        WidgetsBinding.instance.addPostFrameCallback((_) async{
          final kanbanProvider =
              Provider.of<KanbanProvider>(context, listen: false);
          Task taskMoved = Task();
          switch (fromGroupId) {
            case 'toDo':
              taskMoved = originalSubtaskToDo[fromIndex];
              originalSubtaskToDo.removeAt(fromIndex);
              break;
            case 'inWork':
              taskMoved = originalSubTaskInWork[fromIndex];
              originalSubTaskInWork.removeAt(fromIndex);
              break;
            case 'underReview':
              taskMoved = originalSubTaskInRevision[fromIndex];
              originalSubTaskInRevision.removeAt(fromIndex);
              break;
            case 'finished':
              taskMoved = originalSubTaskFinished[fromIndex];
              originalSubTaskFinished.removeAt(fromIndex);
              break;
            default:
              return;
          }
           List<Task> currentList2;
          // 2. Insertar en el nuevo grupo en la posición adecuada
          switch (toGroupId) {
            case 'toDo':
              originalSubtaskToDo.insert(toIndex, taskMoved);
              currentList2 = originalSubtaskToDo;
              break;
            case 'inWork':
              originalSubTaskInWork.insert(toIndex, taskMoved);
              currentList2 = originalSubTaskInWork;
              break;
            case 'underReview':
              originalSubTaskInRevision.insert(toIndex, taskMoved);
              currentList2 = originalSubTaskInRevision;
              break;
            case 'finished':
              originalSubTaskFinished.insert(toIndex, taskMoved);
              currentList2 = originalSubTaskFinished;
              break;
            default:
              return;
          }
          await kanbanProvider.updateStateKanban(
              taskMoved, toGroupId);
          kanbanProvider.updateIndexTaskSubTask(currentList2);
          setState(() {});
        });
      },
    );
    controller.enableGroupDragging(false);
    boardController = AppFlowyBoardScrollController();

    // Esperar hasta que el build inicial esté completo para acceder al contexto
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final kanbanProvider =
          Provider.of<KanbanProvider>(context, listen: false);
      // kanbanProvider.addListener(updateBoard)
      // controller.groupDatas.clear();
      subtaskToDo = kanbanProvider.subTaskToDo;
      subTaskInWork = kanbanProvider.subTaskInWork;
      subTaskInRevision = kanbanProvider.subTaskInRevision;
      subTaskFinished = kanbanProvider.subTaskFinished;

      final toDo = AppFlowyGroupData(
          id: "toDo",
          name: "POR HACER",
          items: List<AppFlowyGroupItem>.from(
              kanbanProvider.subTaskToDo.map((subTask) {
            return RichTextItem(
                idItem: subTask.id ?? '',
                title: subTask.ordenProduccionTrabajoRealizar ?? 'Sin título',
                project: subTask.ordenProdCampanaName ?? '',
                advance: subTask.ordenAvance ?? 0,
                endDate: subTask.ordenFechaFin ?? '',
                numberNewComments: subTask.ordenNumberNewComment ?? 0,
                priority: subTask.ordenPrioridad ?? '',
                responsible: subTask.ordenResponsableFullNames ?? '',
                supervisor: subTask.ordenSupervisorFullNames ?? '',
                firstParticipant: subTask.ordenFirstParticipantFullName ?? '',
                secondParticipant: subTask.ordenSecondParticipantFullName ?? '',
                responsiblePhoto: subTask.ordenResponsablePhoto ?? '',
                supervisorPhoto: subTask.ordenSupervisorPhoto ?? '',
                firstParticipantPhoto: subTask.ordenFirstParticipantPhoto ?? '',
                secondParticipantPhoto:
                    subTask.ordenSecondParticipantPhoto ?? '',
                taskObject: subTask);
          })));

      final groupInWork = AppFlowyGroupData(
          id: "inWork",
          name: "EN TRABAJO",
          items: List<AppFlowyGroupItem>.from(
              kanbanProvider.subTaskInWork.map((subTask) {
            return RichTextItem(
                idItem: subTask.id ?? '',
                title: subTask.ordenProduccionTrabajoRealizar ?? 'Sin título',
                project: subTask.ordenProdCampanaName ?? '',
                advance: subTask.ordenAvance ?? 0,
                endDate: subTask.ordenFechaFin ?? '',
                numberNewComments: subTask.ordenNumberNewComment ?? 0,
                priority: subTask.ordenPrioridad ?? '',
                responsible: subTask.ordenResponsableFullNames ?? '',
                supervisor: subTask.ordenSupervisorFullNames ?? '',
                firstParticipant: subTask.ordenFirstParticipantFullName ?? '',
                secondParticipant: subTask.ordenSecondParticipantFullName ?? '',
                responsiblePhoto: subTask.ordenResponsablePhoto ?? '',
                supervisorPhoto: subTask.ordenSupervisorPhoto ?? '',
                firstParticipantPhoto: subTask.ordenFirstParticipantPhoto ?? '',
                secondParticipantPhoto:
                    subTask.ordenSecondParticipantPhoto ?? '',
                taskObject: subTask);
          })));

      final inRevision = AppFlowyGroupData(
          id: "underReview",
          name: "EN REVISIÓN",
          items: List<AppFlowyGroupItem>.from(
              kanbanProvider.subTaskInRevision.map((subTask) {
            return RichTextItem(
                idItem: subTask.id ?? '',
                title: subTask.ordenProduccionTrabajoRealizar ?? 'Sin título',
                project: subTask.ordenProdCampanaName ?? '',
                advance: subTask.ordenAvance ?? 0,
                endDate: subTask.ordenFechaFin ?? '',
                numberNewComments: subTask.ordenNumberNewComment ?? 0,
                priority: subTask.ordenPrioridad ?? '',
                responsible: subTask.ordenResponsableFullNames ?? '',
                supervisor: subTask.ordenSupervisorFullNames ?? '',
                firstParticipant: subTask.ordenFirstParticipantFullName ?? '',
                secondParticipant: subTask.ordenSecondParticipantFullName ?? '',
                responsiblePhoto: subTask.ordenResponsablePhoto ?? '',
                supervisorPhoto: subTask.ordenSupervisorPhoto ?? '',
                firstParticipantPhoto: subTask.ordenFirstParticipantPhoto ?? '',
                secondParticipantPhoto:
                    subTask.ordenSecondParticipantPhoto ?? '',
                taskObject: subTask);
          })));

      final finished = AppFlowyGroupData(
          id: "finished",
          name: "TERMINADO",
          items: List<AppFlowyGroupItem>.from(
              kanbanProvider.subTaskFinished.map((subTask) {
            return RichTextItem(
                idItem: subTask.id ?? '',
                title: subTask.ordenProduccionTrabajoRealizar ?? 'Sin título',
                project: subTask.ordenProdCampanaName ?? '',
                advance: subTask.ordenAvance ?? 0,
                endDate: subTask.ordenFechaFin ?? '',
                numberNewComments: subTask.ordenNumberNewComment ?? 0,
                priority: subTask.ordenPrioridad ?? '',
                responsible: subTask.ordenResponsableFullNames ?? '',
                supervisor: subTask.ordenSupervisorFullNames ?? '',
                firstParticipant: subTask.ordenFirstParticipantFullName ?? '',
                secondParticipant: subTask.ordenSecondParticipantFullName ?? '',
                responsiblePhoto: subTask.ordenResponsablePhoto ?? '',
                supervisorPhoto: subTask.ordenSupervisorPhoto ?? '',
                firstParticipantPhoto: subTask.ordenFirstParticipantPhoto ?? '',
                secondParticipantPhoto:
                    subTask.ordenSecondParticipantPhoto ?? '',
                taskObject: subTask);
          })));

      originalSubtaskToDo = subtaskToDo;
      originalSubTaskInWork = subTaskInWork;
      originalSubTaskInRevision = subTaskInRevision;
      originalSubTaskFinished = subTaskFinished;

      toDo.draggable = false;
      groupInWork.draggable = false;
      inRevision.draggable = false;
      finished.draggable = false;
      // controller.groupDatas.clear();
      // Agregar el grupo al controller
      setState(() {
        boardKey = UniqueKey();
        controller.addGroup(toDo);
        controller.addGroup(groupInWork);
        controller.addGroup(inRevision);
        controller.addGroup(finished);
      });
      /*  controller.addGroup(toDo);
      controller.addGroup(groupInWork);
      controller.addGroup(inRevision);
      controller.addGroup(finished); */
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final config = AppFlowyBoardConfig(
      groupBackgroundColor: AppColors.groupBackgroundKanbanColor(context),
    );

    // controller.addListener(listener)
    final double width = MediaQuery.of(context).size.width;
    final kanbanProvider = Provider.of<KanbanProvider>(context);
    final lengthSubTaskToDo = context.watch<KanbanProvider>().subTaskToDo.length;
    final lengthSubTaskInWork = context.watch<KanbanProvider>().subTaskInWork.length;
    final lengthSubTaskInRevision = context.watch<KanbanProvider>().subTaskInRevision.length;
    final lengthSubTaskFinished = context.watch<KanbanProvider>().subTaskFinished.length;

    return kanbanProvider.isGettingListOfTask
        ? const Center(
            child: Text('Cargando'),
          )
        : AppFlowyBoard(
            key: boardKey,
            groupConstraints: BoxConstraints(maxWidth: (width / 4) - 5),
            controller: controller,
            cardBuilder: (context, group, groupItem) {
              if (groupItem is RichTextItem) {
                return AppFlowyGroupCard(
                  decoration: BoxDecoration(
                    color: AppColors.listKanbanColor(context),
                    borderRadius: BorderRadius.circular(10.0),
                    boxShadow: const [
                      BoxShadow(
                        color: Color.fromRGBO(0, 0, 0, 0.1),
                        spreadRadius: 0,
                        blurRadius: 5,
                        offset: Offset(5, 5), // changes position of shadow
                      ),
                    ],
                  ),
                  key: ValueKey(groupItem.id),
                  child: _buildCard(groupItem),
                  //  boxConstraints: const BoxConstraints(minHeight: 0),
                );
              }

              // Agrega un manejo genérico para ítems no reconocidos
              return AppFlowyGroupCard(
                key: ValueKey(groupItem.id),
                child: const Text('Item no reconocido'),
              );
            },
            boardScrollController: boardController,
            headerBuilder: (context, columnData) {
              return AppFlowyGroupHeader(
                // icon: const Icon(Icons.lightbulb_circle),
                title: Expanded(
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 12.0,
                      ),
                      Row(
                        children: [
                          Expanded(
                              child: Text(
                            columnData.headerData.groupName,
                            style: AppTextStyle(context).bold18(
                                fontWeight: FontWeight.bold,
                                color: getColorTittleHeader(
                                    columnData.headerData.groupName)),
                          )),
                          Text(
                            columnData.headerData.groupName == 'POR HACER'
                                ? lengthSubTaskToDo.toString()//kanbanProvider.subTaskToDo.length.toString()
                                : columnData.headerData.groupName ==
                                        'EN TRABAJO'
                                    ? lengthSubTaskInWork.toString()// kanbanProvider.subTaskInWork.length.toString()
                                    : columnData.headerData.groupName ==
                                            'EN REVISIÓN'
                                        ? lengthSubTaskInRevision.toString()//kanbanProvider.subTaskInRevision.length.toString()
                                        : lengthSubTaskFinished.toString(),//kanbanProvider.subTaskFinished.length.toString(),
                            style: AppTextStyle(context).bold18(
                                fontWeight: FontWeight.bold,
                                color: getColorTittleHeader(
                                    columnData.headerData.groupName)),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      const Divider(
                        height: 1.0,
                      )
                    ],
                  ),
                ),
                //  addIcon: const Icon(Icons.add, size: 20),
                // moreIcon: const Icon(Icons.more_horiz, size: 20),
                height: 55.0,
                margin: config.groupBodyPadding,
              );
            },
            config: config);
  }

  Widget _buildCard(AppFlowyGroupItem item) {
    if (item is TextItem) {
      return Align(
        alignment: Alignment.centerLeft,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 30.0),
          child: Text(item.s),
        ),
      );
    }

    if (item is RichTextItem) {
      return RichTextCard(item: item);
    }

    throw UnimplementedError();
  }
}

class RichTextCard extends StatefulWidget {
  final RichTextItem item;
  const RichTextCard({
    required this.item,
    super.key,
  });

  @override
  State<RichTextCard> createState() => _RichTextCardState();
}

class _RichTextCardState extends State<RichTextCard> {
  @override
  Widget build(BuildContext context) {
    final bool isPriority =
        widget.item.priority == 'medio' || widget.item.priority == 'alto';
    final textSpace = isPriority ? '      ' : '';
    double heightScreen = MediaQuery.of(context).size.height;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 5.0,
        children: [
          Stack(
            children: [
              Text(
                textSpace + Helpers.capitalize(widget.item.title.trim()),
                style: AppTextStyle(context).bold15(
                    color: AppColors.textBasic(context),
                    fontWeight: FontWeight.bold),
                textAlign: TextAlign.left,
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
              ),
              widget.item.priority == 'alto'
                  ? const Icon(
                      Bootstrap.fire,
                      color: Colors.orange,
                      size: 18.0,
                    )
                  : const SizedBox(),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: Text(
                  Helpers.capitalize(widget.item.project.trim()),
                  style: AppTextStyle(context).bold13(
                      fontWeight: FontWeight.w500,
                      color: AppColors.textBasic(context)),
                  maxLines: 1,
                ),
              ),
              Text(Helpers.formatDateddMMString(widget.item.endDate),
                  style: AppTextStyle(context).bold12(
                      fontWeight: FontWeight.w500,
                      color: AppColors.textBasic(context)))
            ],
          ),
          Row(
            spacing: 10.0,
            children: [
              Expanded(
                child: LinearProgressIndicator(
                  borderRadius: BorderRadius.circular(8),
                  value: widget.item.advance / 100,
                  backgroundColor: Colors.grey[300],
                  color: AppColors.primary(context),
                  minHeight: 6.0,
                ),
              ),
              Text('${widget.item.advance} %')
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                spacing: 5.0,
                children: [
                  _customPersonsProject(
                      widget.item.responsible,
                      widget.item.responsiblePhoto,
                      widget.item.supervisor,
                      widget.item.supervisorPhoto,
                      widget.item.firstParticipant,
                      widget.item.firstParticipantPhoto,
                      widget.item.secondParticipant,
                      widget.item.secondParticipantPhoto,
                      context),
                  Row(
                    spacing: 2.0,
                    children: [
                      Icon(
                        Icons.access_time,
                        color: Helpers.getDaysRemainingColor(
                            widget.item.endDate, context),
                        size: 18.0,
                      ),
                      Text(
                          '${Helpers.getDaysRemaining(widget.item.endDate)} días',
                          style: AppTextStyle(context).bold13(
                              color: Helpers.getDaysRemainingColor(
                                  widget.item.endDate, context))),
                    ],
                  ),
                ],
              ),
              InkWell(
                child: Row(
                  spacing: 3.0,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Icon(
                      Bootstrap.chat_left,
                      size: 14.0,
                    ),
                    Text(widget.item.numberNewComments.toString())
                  ],
                ),
                onTap: () {
                  print( widget.item.taskObject.campanaId);
                  print( widget.item.taskObject.clienteId);
                  print( widget.item.taskObject.companiaId);
                  print( widget.item.taskObject.ordenProduccionId);
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return PopupGeneral(
                            scrollable: true,
                            onTapButton: () => {},
                            title: "",//Datos del proyecto
                            content: SizedBox(
                                height: heightScreen - 100.0,
                                width: 1000.0,
                                child: WebviewCollaboration(
                                  projectId:
                                      widget.item.taskObject.campanaId ?? '',
                                  clienteId:
                                      widget.item.taskObject.clienteId ?? '',
                                  companiaId:
                                      widget.item.taskObject.companiaId ?? '',
                                  taskId: widget
                                          .item.taskObject.ordenProduccionId ??
                                      '',
                                )));
                      });
                },
              )
            ],
          ),
        ],
      ),
    );
  }
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

class TextItem extends AppFlowyGroupItem {
  final String s;

  TextItem(this.s);

  @override
  String get id => s;
}

class RichTextItem extends AppFlowyGroupItem {
  final String title;
  final String project;
  final String idItem;
  final int advance;
  final String endDate;
  final int numberNewComments;
  final String priority;
  final String responsible;
  final String responsiblePhoto;
  final String supervisor;
  final String supervisorPhoto;
  final String firstParticipant;
  final String firstParticipantPhoto;
  final String secondParticipant;
  final String secondParticipantPhoto;
  final Task taskObject;

  RichTextItem({
    required this.title,
    required this.project,
    required this.idItem,
    required this.advance,
    required this.endDate,
    required this.numberNewComments,
    required this.priority,
    required this.responsible,
    required this.supervisor,
    required this.firstParticipant,
    required this.secondParticipant,
    required this.responsiblePhoto,
    required this.supervisorPhoto,
    required this.firstParticipantPhoto,
    required this.secondParticipantPhoto,
    required this.taskObject,
  });

  @override
  String get id => idItem;
}

Widget _circlePerson(
    Color color, String name, String photo, BuildContext context) {
  return CircleAvatar(
      radius: 10.0,
      backgroundColor: color,
      backgroundImage: photo.isNotEmpty ? NetworkImage(route + photo) : null,
      child: photo.isEmpty
          ? Text(
              Helpers.getInitial(name),
              style: AppTextStyle(context).bold9(fontWeight: FontWeight.bold),
            )
          : const SizedBox());
}

Widget _customPersonsProject(
    String responsible,
    String responsiblePhoto,
    String supervisor,
    String supervisorPhoto,
    String firstParticipant,
    String firstParticipantPhoto,
    String secondParticipant,
    String secondParticipantPhoto,
    BuildContext context) {
  return SizedBox(
    width: 65.0,
    height: 20.0,
    // color: Colors.grey,
    child: Stack(
      children: [
        Positioned(
            left: 45,
            child: _circlePerson(const Color.fromRGBO(240, 240, 240, 1),
                secondParticipant, secondParticipantPhoto, context)),
        Positioned(
            left: 30,
            child: _circlePerson(const Color.fromRGBO(235, 235, 235, 1),
                firstParticipant, firstParticipantPhoto, context)),
        Positioned(
            left: 15,
            child: _circlePerson(const Color.fromRGBO(227, 227, 227, 1),
                responsible, responsiblePhoto, context)),
        Positioned(
            left: 0,
            child: _circlePerson(const Color.fromRGBO(217, 217, 217, 1),
                supervisor, supervisorPhoto, context))
      ],
    ),
  );
}

Color getColorTittleHeader(String tittle) {
  Color color = Colors.black;
  if (tittle.isEmpty) return color;

  switch (tittle) {
    case 'POR HACER':
      color = const Color.fromRGBO(188, 188, 188, 1);
      break;
    case 'EN TRABAJO':
      color = const Color.fromRGBO(109, 189, 252, 1);
      break;
    case 'EN REVISIÓN':
      color = const Color.fromRGBO(255, 165, 0, 1);
      break;
    case 'TERMINADO':
      color = const Color.fromRGBO(122, 201, 67, 1);
      break;
    default:
      color = const Color.fromRGBO(122, 201, 67, 1);
  }
  return color;
}

Future<void> _openUrl(String url) async {
  final Uri uri = Uri.parse(url);
  if (!await launchUrl(uri)) {
    throw Exception('No se pudo abrir $url');
  }
}
