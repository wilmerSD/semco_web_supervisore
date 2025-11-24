import 'package:app_tasking/app/ui/views/subtask/subtask_provider.dart';
import 'package:app_tasking/app/ui/views/task/task_provider.dart';
import 'package:app_tasking/core/routes/app_routes_name.dart';
import 'package:app_tasking/core/theme/app_colors.dart';
import 'package:app_tasking/core/theme/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class ListSubTask extends StatelessWidget {
  const ListSubTask({super.key});

  @override
  Widget build(BuildContext context) {
    final taskProvider = Provider.of<TaskProvider>(context);
    final subtaskProvider = Provider.of<SubtaskProvider>(context);
    return taskProvider.isGetListSubtask
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
            child: taskProvider.listSubtask.isEmpty
                ? Center(
                    child: Text(
                        "Este proyecto está esperando por sus primeras sub-tareas. 🚀",
                        style: AppTextStyle(context).bold18(
                            color: AppColors.textBasic(context),
                            fontWeight: FontWeight.w400)),
                  )
                : ListView.builder(
                    itemCount: taskProvider.listSubtask.length,
                    itemBuilder: (context, index) {
                      final task = taskProvider.listSubtask[index];
                      return InkWell(
                        onTap: () {
                          subtaskProvider.subTaskObject = task;
                          // debugPrint(subtaskProvider.subTaskObject.ordenAvance);
                          subtaskProvider.getCustomData(
                              task.ordenProduccionId ?? '',
                              taskProvider.clienteId,
                              taskProvider.companiaId);
                          subtaskProvider.getListNotes(task.ordenProduccionId,
                              taskProvider.clienteId, taskProvider.companiaId);
                          subtaskProvider.getCheckListSubTask(
                              task.ordenProduccionId ?? '',
                              '',
                              taskProvider.clienteId,
                              taskProvider.companiaId);
                          context.push(AppRoutesName.SUBTASK);
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
