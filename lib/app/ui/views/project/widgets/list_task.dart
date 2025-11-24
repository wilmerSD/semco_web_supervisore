import 'package:app_tasking/app/ui/views/home/home_provider.dart';
import 'package:app_tasking/app/ui/views/project/project_provider.dart';
import 'package:app_tasking/app/ui/views/subtask/subtask_provider.dart';
import 'package:app_tasking/app/ui/views/task/task_provider.dart';
import 'package:app_tasking/core/helpers/helpers.dart';
import 'package:app_tasking/core/routes/app_routes_map.dart';
import 'package:app_tasking/core/routes/app_routes_name.dart';
import 'package:app_tasking/core/theme/app_colors.dart';
import 'package:app_tasking/core/theme/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class ListTask extends StatelessWidget {
  const ListTask({super.key});

  @override
  Widget build(BuildContext context) {
    final projectProvider = Provider.of<ProjectProvider>(context);
    final taskController = Provider.of<TaskProvider>(context, listen: false);
    final homeProvider = Provider.of<HomeProvider>(context, listen: false);
    final subtaskProvider =
        Provider.of<SubtaskProvider>(context, listen: false);
    // taskController.prueba();
    // taskController.onInit();
    return projectProvider.isLoading
        ? const Center(child: CircularProgressIndicator())
        : Container(
            padding: const EdgeInsetsDirectional.all(10.0),
            decoration: BoxDecoration(
              color: AppColors.listProyectsColor(context),
              boxShadow: [
                BoxShadow(
                  color: AppColors.shadowListColor(context),
                  blurRadius: 5.0,
                  spreadRadius: 0.2,
                  // offset: Offset(0, 0),
                )
              ],
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: projectProvider.listTask.isEmpty
                ? Center(
                    child: Text(
                        "Este proyecto está esperando por sus primeras tareas. 🚀",
                        style: AppTextStyle(context).bold18(
                            color: AppColors.textBasic(context),
                            fontWeight: FontWeight.w400)),
                  )
                : ListView.builder(
                    itemCount: projectProvider.listTask.length,
                    itemBuilder: (context, index) {
                      final task = projectProvider.listTask[index];
                      return InkWell(
                        onTap: () {
                          taskController.taskObject = task;
                          taskController.proyectObject =
                              projectProvider.listProyectObject;
                          taskController.getCustomData(
                              task.ordenProduccionId ?? '',
                              projectProvider.listProyectObject.clienteid ?? '',
                              projectProvider.listProyectObject.campanaid ??
                                  '');
                          taskController.getListSubTask(
                              homeProvider.personalId,
                              task.ordenProduccionId,
                              projectProvider.listProyectObject.campanaid,
                              projectProvider.listProyectObject.clienteid,
                              projectProvider.listProyectObject.companiaid);
                          taskController.getListNotes(task.ordenProduccionId);
                          taskController.getCheckList(
                              task.ordenProduccionId ?? '',
                              projectProvider.listProyectObject.campanaid ?? '',
                              projectProvider.listProyectObject.clienteid ?? '',
                              projectProvider.listProyectObject.companiaid ??
                                  '');
                          subtaskProvider.campanaId =
                              projectProvider.listProyectObject.campanaid ?? '';
                          context.push(AppRoutesName.TASK);
                        },
                        child: Container(
                          margin: const EdgeInsets.all(5.0),
                          padding: const EdgeInsetsDirectional.all(10.0),
                          decoration: BoxDecoration(
                            color: AppColors.listProyectsColor(context),
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.shadowListColor(context),
                                blurRadius: 2.0,
                                spreadRadius: 0.1,
                              )
                            ],
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                      child: Text(
                                    task.ordenProduccionTrabajoRealizar ?? '',
                                    overflow: TextOverflow.ellipsis,
                                    style: AppTextStyle(context).bold14(
                                        color: AppColors.textBasic(context),
                                        fontWeight: FontWeight.w500),
                                  ))
                                ],
                              ),
                              Text(task.ordenResponsableFullNames ?? '',
                                  overflow: TextOverflow.fade,
                                  style: AppTextStyle(context).bold14(
                                      color: AppColors.textBasic(context),
                                      fontWeight: FontWeight.w400)),
                            ],
                          ),
                        ),
                      );
                    }),
          );
  }
}
