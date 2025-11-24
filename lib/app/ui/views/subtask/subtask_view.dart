import 'package:app_tasking/app/ui/components/icon_wrapper.dart';
import 'package:app_tasking/app/ui/components/modal_new_note.dart';
import 'package:app_tasking/app/ui/components/text_wrapper_btn.dart';
import 'package:app_tasking/app/ui/views/subtask/subtask_provider.dart';
import 'package:app_tasking/app/ui/views/subtask/widgets/header_subtask.dart';
import 'package:app_tasking/app/ui/views/subtask/widgets/list_notes_subtask.dart';
import 'package:app_tasking/app/ui/views/subtask/widgets/list_checklist_subtask.dart';
import 'package:app_tasking/app/ui/views/subtask/widgets/select_type_note.dart';
import 'package:app_tasking/core/theme/app_colors.dart';
import 'package:app_tasking/core/theme/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:provider/provider.dart';

class SubtaskView extends StatelessWidget {
  const SubtaskView({super.key});

  @override
  Widget build(BuildContext context) {
    final subtaskProvider = Provider.of<SubtaskProvider>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primary(context),
        /* title: Row(
            children: [
              TextWrapperBtn(
                onTap: () => Helpers.goToProject(context),
                child: Text("Proyecto /", style: AppTextStyle(context).bold18(fontWeight: FontWeight.w400,color: AppColors.textBasic(context)),)),
              TextWrapperBtn(
                onTap: () => Helpers.goToTasks(context),
                child: Text(" Tarea /", style: AppTextStyle(context).bold18(fontWeight: FontWeight.w400, color: AppColors.textBasic(context)),)),
              Text(" Sub-tarea", style: AppTextStyle(context).bold18(fontWeight: FontWeight.w500, color: AppColors.textBasic(context)),),

            ],
          ) */
      ),
      body: Padding(
        padding: const EdgeInsetsDirectional.all(10.0),
        child: Column(
          children: [
            HeaderSubtask(),
            SizedBox(
              height: 15.0.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    IconButton(
                        onPressed: () =>
                            subtaskProvider.updateShowCheckList(),
                        icon: subtaskProvider.isShowCheckList
                            ? Icon(Bootstrap.arrow_up_short)
                              : Icon(Bootstrap.arrow_down_short)),
                    TextWrapperBtn(
                      onTap: () {
                        subtaskProvider.updateShowCheckList();
                      },
                      isMini: true,
                      child: Text("CheckList:",
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
                      onTap: () {},
                      child: Icon(Bootstrap.plus_circle_fill,
                          color: AppColors.primary(context), size: 20.0),
                    )
                  ],
                )
              ],
            ),
            SizedBox(
              height: 15.0.h,
            ),
            subtaskProvider.isShowCheckList
                ? Expanded(child: Visibility(child: ListCheckListSubtask()))
                : Container(),
            SizedBox(
              height: 15.0.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    IconButton(
                        onPressed: () =>
                            subtaskProvider.updateShowListNotes(),
                        icon: subtaskProvider.isShowListNotes
                            ? Icon(Bootstrap.arrow_up_short)
                              : Icon(Bootstrap.arrow_down_short)),
                    TextWrapperBtn(
                      isMini: true,
                      onTap: () {
                        subtaskProvider.updateShowListNotes();
                      },
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
                      onTap: () =>
                          /*   popUpNewNote(); */
                          ModalUtils.getShowModalBS(
                        context,
                        content: SelectTypeNote(),
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
              height: 15.0.h,
            ),
            subtaskProvider.isShowListNotes
                ? Expanded(child: ListNotesSubtask())
                : SizedBox(),
          ],
        ),
      ),
    );
  }
}
