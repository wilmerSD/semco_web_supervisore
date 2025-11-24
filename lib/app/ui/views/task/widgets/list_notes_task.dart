import 'package:app_tasking/app/ui/components/alert_dialog_comp.dart';
import 'package:app_tasking/app/ui/components/custom_note.dart';
import 'package:app_tasking/app/ui/views/task/task_provider.dart';
import 'package:app_tasking/core/helpers/helpers.dart';
import 'package:app_tasking/core/theme/app_colors.dart';
import 'package:app_tasking/core/theme/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:provider/provider.dart';

class ListNotesTask extends StatelessWidget {
  const ListNotesTask({super.key});

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
            child: taskProvider.listNotes.isEmpty
                ? Center(
                    child: Text(
                        "Este proyecto está esperando por sus primeros apuntes. 🚀",
                        style: AppTextStyle(context).bold18(
                            color: AppColors.textBasic(context),
                            fontWeight: FontWeight.w400)),
                  )
                : ListView.builder(
                    itemCount: taskProvider.listNotes.length,
                    itemBuilder: (context, index) {
                      final task = taskProvider.listNotes[index];
                      return InkWell(
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialogComp(
                                  headerTitle: '',
                                  widgetContent: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.only(left: 8.0),
                                            child: Text(task.comePersonaFullNames ?? '', style: AppTextStyle(context).bold18(color: AppColors.textBasic(context)),)),
                                          IconButton(
                                            onPressed: () => Navigator.of(context).pop(),
                                            icon: const Icon(Bootstrap.x_circle))
                                        ],
                                      ),
                                      CustomNote(
                                          comment: task.comeComentario ?? '',
                                          typeNote: task.comeTipo ?? 4,
                                          maxLines: null),
                                    ],
                                  ),
                                  date: Text(Helpers.formattedDateToDMA(task.comeDate)),
                                );
                              },
                            );
                          },
                          child: CustomNote(
                            comment: task.comeComentario ?? '',
                            typeNote: task.comeTipo ?? 4,
                            maxLines: 3,
                          ));
                    }),
          );
  }
}
