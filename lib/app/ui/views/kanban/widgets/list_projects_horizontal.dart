import 'package:app_tasking/app/ui/views/kanban/kanban_provider.dart';
import 'package:app_tasking/core/helpers/helpers.dart';
import 'package:app_tasking/core/theme/app_colors.dart';
import 'package:app_tasking/core/theme/app_text_color.dart';
import 'package:app_tasking/core/theme/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:provider/provider.dart';

/* String route =
    'http://localhost/AppTaskingGX18NETFrameworkSQLServer/PhotoPersonal/'; */
/*  String route =
    'https://app.task-ing.com/qa/PhotoPersonal/'; */
  
  // String route =
  //   'https://app.task-ing.com/vs1/PhotoPersonal/';
  String route =
    'https://app.task-ing.com/demo/PhotoPersonal/';
    
 
class ListProjectsHorizontal extends StatelessWidget {
  const ListProjectsHorizontal({super.key});

  @override
  Widget build(BuildContext context) {
    final kanbanProvider =
        Provider.of<KanbanProvider>(context, listen: true);

    return kanbanProvider.isGettingProjects
        ? const Center(child: CircularProgressIndicator())
        : kanbanProvider.listProyects.isEmpty
            ? const Center(
                child: Text('No hay proyectos con el filtro seleccionado'),
              )
            : ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: kanbanProvider.listProyects.length,
                itemBuilder: (context, index) {
                  final project = kanbanProvider.listProyects[index];
                  return InkWell(
                      borderRadius: BorderRadius.circular(8),
                      onTap: () {
                       /*  kanbanProvider.getListOfTask(
                          context,
                          project,
                        ); */
                        kanbanProvider.proyectSelected(index);
                      },
                      child: Container(
                        margin: const EdgeInsets.all(8.0),
                        padding: const EdgeInsets.all(5.0),
                        width: 350.0,
                        decoration: BoxDecoration(
                            color: AppColors.listHorizProjectCardColor(context),
                            borderRadius: BorderRadius.circular(8.0),
                            boxShadow: const [
                              BoxShadow(
                                color: Color.fromRGBO(0, 0, 0, 0.1),
                                spreadRadius: 0,
                                blurRadius: 5,
                                offset:
                                    Offset(5, 5), // changes position of shadow
                              ),
                            ]),
                        child: Column(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                    Helpers.capitalize(
                                        project.campanaNombre ?? ''),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: AppTextStyle(context).bold15(
                                        fontWeight: FontWeight.w500,
                                        color: index ==
                                                kanbanProvider.indexKanban
                                            ? AppTextColor.textKanbanColor
                                            : AppTextColor
                                                .textKanbanNoSelectedColor)),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      spacing: 3.0,
                                      children: [
                                        _customPersonsProject(
                                            project.responsableNombre ?? '',
                                            project.responsablePhoto ?? '',
                                            project.supervisorNombre ?? '',
                                            project.supervisorPhoto ?? '',
                                            project.firstParticipantFullName ??
                                                '',
                                            project.firstParticipantPhoto ?? '',
                                            project.secondParticipantFullName ??
                                                '',
                                            project.secondParticipantPhoto ??
                                                '',
                                            context),
                                        SizedBox(
                                          width: 100.0,
                                          child: Text(
                                            Helpers.capitalize(
                                                    project.clienteNombre ?? '')
                                                .trim(),
                                            overflow: TextOverflow.ellipsis,
                                            style: AppTextStyle(context).bold13(
                                                color: index ==
                                                        kanbanProvider
                                                            .indexKanban
                                                    ? AppTextColor
                                                        .textClientSelected(
                                                            context)
                                                    : AppTextColor
                                                        .textClientNotSelected(
                                                            context)),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        _indicators(
                                            Bootstrap.funnel,
                                            project.numberTask.toString(),
                                            index,
                                            kanbanProvider.indexKanban,
                                            context),
                                        const SizedBox(
                                          width: 10.0,
                                        ),
                                        _indicators(
                                            Bootstrap.chat_left,
                                            project.numberNewComments
                                                .toString(),
                                            index,
                                            kanbanProvider.indexKanban,
                                            context),
                                        _editIcon(
                                            Bootstrap.pencil_square,
                                            index,
                                            kanbanProvider.indexKanban,
                                            () {

                                            }),
                                      ],
                                    )
                                  ],
                                ),
                              ],
                            ),
                            // const SizedBox(height: 10.0),
                            Align(
                                alignment: Alignment.bottomCenter,
                                child: AnimatedContainer(
                                  color: AppColors.primary(context),
                                  height: index == kanbanProvider.indexKanban
                                      ? 4.0
                                      : 0.0,
                                  duration: const Duration(milliseconds: 400),
                                  width: index == kanbanProvider.indexKanban
                                      ? 350.0
                                      : 0.0,
                                )
                                )
                          ],
                        ),
                        /* Column(
                      children: [
                        Expanded(
                          child: Text(project.campanaNombre ?? '',
                              overflow: TextOverflow.clip,
                              style: AppTextStyle(context)
                                  .bold13(color: index == kanbanProvider.indexKanban
                            ? Colors.white :AppColors.textBasic(context))),
                        ),
                        
                      ],
                    )), */
                      ));
                },
              );
  }
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
            left: 45.0,
            child: _circlePerson(const Color.fromRGBO(240, 240, 240, 1),
                secondParticipant, secondParticipantPhoto, context)),
        Positioned(
            left: 30,
            child: _circlePerson(const Color.fromRGBO(235, 235, 235, 1),
                firstParticipant, firstParticipantPhoto, context)),
        Positioned(
            left: 15,
            child: _circlePerson(const Color.fromRGBO(227, 227, 227, 1),
                supervisor, supervisorPhoto, context)),
        Positioned(
            left: 0,
            child: _circlePerson(const Color.fromRGBO(217, 217, 217, 1),
                responsible, responsiblePhoto, context))
      ],
    ),
  );
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

Widget _indicators(IconData icon, String text, int index, int indexKanban,
    BuildContext context) {
  return Row(
    spacing: 2.0,
    children: [
      Icon(
        icon,
        color: index == indexKanban
            ? AppTextColor.textKanbanColor
            : AppTextColor.textKanbanNoSelectedColor,
        size: 18.0,
      ),
      Text(
        text,
        style: AppTextStyle(context).bold13(
          color: index == indexKanban
              ? AppTextColor.textKanbanColor
              : AppTextColor.textKanbanNoSelectedColor,
        ),
      ),
    ],
  );
}

Widget _editIcon(IconData icon, int index, int indexKanban, Function ontap) {
  return Row(
    spacing: 2.0,
    children: [
      IconButton(
        icon: Icon(
          icon,
          color: index == indexKanban
              ? AppTextColor.textKanbanColor
              : AppTextColor.textKanbanNoSelectedColor,
          size: 18.0,
        ),
        onPressed: () => ontap(),
      ),
    ],
  );
}
