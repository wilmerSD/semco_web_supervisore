import 'package:app_tasking/app/ui/views/task/task_provider.dart';
import 'package:app_tasking/core/helpers/helpers.dart';
import 'package:app_tasking/core/theme/app_colors.dart';
import 'package:app_tasking/core/theme/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CheckListTask extends StatelessWidget {
  const CheckListTask({super.key});

  @override
  Widget build(BuildContext context) {
    final taskProvider = Provider.of<TaskProvider>(context);
    return taskProvider.isGetListNotes
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
            child: taskProvider.checkListTask.isEmpty
                ? Center(
                    child: Text(
                        "Este proyecto está esperando por sus primeros checklist. 🚀",
                        style: AppTextStyle(context).bold18(
                            color: AppColors.textBasic(context),
                            fontWeight: FontWeight.w400)),
                  )
                : ListView.builder(
                    itemCount: taskProvider.checkListTask.length,
                    itemBuilder: (context, index) {
                      final checkListProject =
                          taskProvider.checkListTask[index];
                      return Row(
                        children: [
                          Checkbox(
                            value: checkListProject.taskCheckState,
                            onChanged: (_) {},
                            activeColor: AppColors.primary(context) 
                          ),
                          Text( Helpers.capitalize(checkListProject.taskCheckName ?? '')),
                        ],
                      );
                    }),
          );
  }
}
