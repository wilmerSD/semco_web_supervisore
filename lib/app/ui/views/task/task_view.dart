import 'package:app_tasking/app/ui/components/icon_wrapper.dart';
import 'package:app_tasking/app/ui/components/modal_new_note.dart';
import 'package:app_tasking/app/ui/components/text_wrapper_btn.dart';
import 'package:app_tasking/app/ui/views/task/task_provider.dart';
import 'package:app_tasking/app/ui/views/task/widgets/check_list_task.dart';
import 'package:app_tasking/app/ui/views/task/widgets/header_task.dart';
import 'package:app_tasking/app/ui/views/task/widgets/list_notes_task.dart';
import 'package:app_tasking/app/ui/views/task/widgets/list_subtask.dart';
import 'package:app_tasking/app/ui/views/task/widgets/pop_up_new_task.dart';
import 'package:app_tasking/app/ui/views/task/widgets/select_type_note_task.dart';
import 'package:app_tasking/core/theme/app_colors.dart';
import 'package:app_tasking/core/theme/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:provider/provider.dart';

class TaskView extends StatelessWidget {
  const TaskView({super.key});

  @override
  Widget build(BuildContext context) {
    final taskProvider = Provider.of<TaskProvider>(context);
    return Scaffold(
        backgroundColor: AppColors.backgroundColor(context),
        appBar: AppBar(
            backgroundColor: AppColors.primary(context),
          /*   title: Row(
              children: [
                TextWrapperBtn(
                    onTap: () => Helpers.goToProject(context),
                    child: Text(
                      "Proyecto /",
                      style: AppTextStyle(context).bold18(
                          fontWeight: FontWeight.w400,
                          color: AppColors.textBasic(context)),
                    )),
                Text(
                  " Tarea",
                  style: AppTextStyle(context).bold18(
                      fontWeight: FontWeight.w500,
                      color: AppColors.textBasic(context)),
                ),
              ],
            ) */),
        body: Padding(
          padding: const EdgeInsetsDirectional.all(10.0),
          child: Column(
            children: [
              HeaderTask(),
              SizedBox(
                height: 15.0.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      IconButton(
                          onPressed: () => taskProvider.visibleCheckList(),
                          icon: taskProvider.isShowCheckList
                              ? Icon(Bootstrap.arrow_up_short)
                              : Icon(Bootstrap.arrow_down_short)),
                      TextWrapperBtn(
                        isMini: true,
                        onTap: () => taskProvider.visibleCheckList(),
                        child: Text("Checklist",
                            style: AppTextStyle(context).bold13(
                                color: AppColors.primary(context),
                                fontWeight: FontWeight.w600)),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      IconWrapper(
                        onTap: () {},
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 5),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: const Color.fromARGB(255, 161, 161, 161),
                          ),
                          child: Icon(
                            Icons.filter_list_sharp,
                            size: 22.0,
                          ),
                        ),
                      ),
                      IconWrapper(
                        onTap: () => popUpNewTask(context),
                        child: Icon(Bootstrap.plus_circle_fill,
                            color: AppColors.primary(context), size: 20.0),
                      )
                    ],
                  ),
                ],
              ),
              taskProvider.isShowCheckList
                  ? Expanded(child: CheckListTask())
                  : SizedBox(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      IconButton(
                          onPressed: () => taskProvider.visibleTask(),
                          icon: taskProvider.isVisibleTask
                              ? Icon(Bootstrap.arrow_up_short)
                              : Icon(Bootstrap.arrow_down_short)),
                      TextWrapperBtn(
                        isMini: true,
                        onTap: () => taskProvider.visibleTask(),
                        child: Text("Sub-Tareas",
                            style: AppTextStyle(context).bold13(
                                color: AppColors.primary(context),
                                fontWeight: FontWeight.w600)),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      IconWrapper(
                        onTap: () {},
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 5),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: const Color.fromARGB(255, 161, 161, 161),
                          ),
                          child: Icon(
                            Icons.filter_list_sharp,
                            size: 22.0,
                          ),
                        ),
                      ),
                      IconWrapper(
                        onTap: () => popUpNewTask(context),
                        child: Icon(Bootstrap.plus_circle_fill,
                            color: AppColors.primary(context), size: 20.0),
                      )
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 5.0.h,
              ),
              taskProvider.isVisibleTask
                  ? Flexible(child: ListSubTask())
                  : SizedBox(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      IconButton(
                          onPressed: () => taskProvider.visibleNotes(),
                          icon: taskProvider.isVisibleNotes
                              ? Icon(Bootstrap.arrow_up_short)
                              : Icon(Bootstrap.arrow_down_short)),
                      TextWrapperBtn(
                        onTap: () => taskProvider.visibleNotes(),
                        isMini: true,
                        child: Text("Apuntes",
                            style: AppTextStyle(context).bold13(
                                color: AppColors.primary(context),
                                fontWeight: FontWeight.w600)),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      IconWrapper(
                        onTap: () {},
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 5),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: const Color.fromARGB(255, 161, 161, 161),
                          ),
                          child: Icon(
                            Icons.filter_list_sharp,
                            size: 22.0,
                          ),
                        ),
                      ),
                      IconWrapper(
                        onTap: () => ModalUtils.getShowModalBS(
                          context,
                          content: SelectTypeNoteTask(),
                          title: 'Nuevo',
                        ),
                        child: Icon(Bootstrap.plus_circle_fill,
                            color: AppColors.primary(context), size: 20.0),
                      ),
                    ],
                  )
                ],
              ),
              SizedBox(
                height: 10.0.h,
              ),
              Visibility(
                visible: taskProvider.isVisibleNotes,
                child: Expanded(child: ListNotesTask()),
                replacement: SizedBox(),
              ),
            ],
          ),
        ));
  }
}
