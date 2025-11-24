import 'package:app_tasking/app/ui/views/subtask/subtask_provider.dart';
import 'package:app_tasking/core/helpers/helpers.dart';
import 'package:app_tasking/core/theme/app_colors.dart';
import 'package:app_tasking/core/theme/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ListCheckListSubtask extends StatelessWidget {
  const ListCheckListSubtask({super.key});

  @override
  Widget build(BuildContext context) {
    final subtaskProvider = Provider.of<SubtaskProvider>(context);
    return subtaskProvider.isGettingCheckSubTask
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
            child: subtaskProvider.checkListSubTask.isEmpty
                ? Center(
                    child: Text(
                        "Este proyecto está esperando por sus primeras checklist. 🚀",
                        style: AppTextStyle(context).bold18(
                            color: AppColors.textBasic(context),
                            fontWeight: FontWeight.w400)),
                  )
                : ListView.builder(
                    itemCount: subtaskProvider.checkListSubTask.length,
                    itemBuilder: (context, index) {
                      final checkListSubTask =
                          subtaskProvider.checkListSubTask[index];
                      return Row(
                        children: [
                          Checkbox(
                              value: checkListSubTask.taskCheckState,
                              onChanged: (_) {},
                              activeColor: AppColors.primary(context)),
                          Text(Helpers.capitalize(
                              checkListSubTask.taskCheckName ?? '')),
                        ],
                      );
                    }),
          );
  }
}
