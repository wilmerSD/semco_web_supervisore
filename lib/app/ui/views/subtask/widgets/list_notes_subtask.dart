import 'package:app_tasking/app/ui/components/alert_dialog_comp.dart';
import 'package:app_tasking/app/ui/components/custom_note.dart';
import 'package:app_tasking/app/ui/views/subtask/subtask_provider.dart';
import 'package:app_tasking/core/helpers/helpers.dart';
import 'package:app_tasking/core/theme/app_colors.dart';
import 'package:app_tasking/core/theme/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:provider/provider.dart';

class ListNotesSubtask extends StatelessWidget {
  const ListNotesSubtask({super.key});

  @override
  Widget build(BuildContext context) {
    final subtaskProvider = Provider.of<SubtaskProvider>(context);
    return subtaskProvider.isGetListNotes
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
            child: subtaskProvider.listNotesSubTask.isEmpty
                ? Center(
                    child: Text(
                        "Este proyecto está esperando por sus primeros apuntes. 🚀",
                        style: AppTextStyle(context).bold18(
                            color: AppColors.textBasic(context),
                            fontWeight: FontWeight.w400)),
                  )
                : ListView.builder(
                    itemCount: subtaskProvider.listNotesSubTask.length,
                    itemBuilder: (context, index) {
                      final task = subtaskProvider.listNotesSubTask[index];
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
