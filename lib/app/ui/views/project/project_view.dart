import 'package:app_tasking/app/ui/components/icon_wrapper.dart';
import 'package:app_tasking/app/ui/components/modal_new_note.dart';
import 'package:app_tasking/app/ui/components/text_wrapper_btn.dart';
import 'package:app_tasking/app/ui/views/project/project_provider.dart';
import 'package:app_tasking/app/ui/views/project/widgets/header_project.dart';
import 'package:app_tasking/app/ui/views/project/widgets/list_notes_project.dart';
import 'package:app_tasking/app/ui/views/project/widgets/list_task.dart';
import 'package:app_tasking/app/ui/views/project/widgets/select_type_note_project.dart';
import 'package:app_tasking/app/ui/views/task/widgets/pop_up_new_task.dart';
import 'package:app_tasking/core/theme/app_colors.dart';
import 'package:app_tasking/core/theme/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:provider/provider.dart';

class ProjectView extends StatelessWidget {
  const ProjectView({super.key});

  @override
  Widget build(BuildContext context) {
    final projectProvider = Provider.of<ProjectProvider>(context);
    return Scaffold(
        backgroundColor: AppColors.backgroundColor(context),
        appBar: AppBar(
          backgroundColor: AppColors.primary(context),
          // title: Text("Proyecto", style: AppTextStyle(context).bold18(fontWeight: FontWeight.w500, color: AppColors.textBasic(context)),)
        ),
        body: Padding(
          padding: const EdgeInsetsDirectional.all(10.0),
          child: Column(
            children: [
              HeaderProject(),
              SizedBox(
                height: 15.0.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      IconButton(
                          onPressed: () => projectProvider.visibleTask(),
                          icon: projectProvider.isVisibleTask
                              ? Icon(Bootstrap.arrow_up_short)
                              : Icon(Bootstrap.arrow_down_short)),
                      TextWrapperBtn(
                        isMini: true,
                        onTap: () => projectProvider.visibleTask(),
                        child: Text("Tareas",
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
                              color: AppColors.primary(context), size: 22.0)),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 5.0.h,
              ),
              projectProvider.isVisibleTask
                  ? Flexible(child: ListTask())
                  : SizedBox(),
              SizedBox(
                height: 10.0.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      IconButton(
                          onPressed: () => projectProvider.visibleNotes(),
                          icon: projectProvider.isVisibleNotes
                              ? Icon(Bootstrap.arrow_up_short)
                              : Icon(Bootstrap.arrow_down_short)),
                      TextWrapperBtn(
                        onTap: () => projectProvider.visibleNotes(),
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
                          content: SelectTypeNoteProject(),
                          title: 'Nuevo',
                        ),
                        child: Icon(Bootstrap.plus_circle_fill,
                            color: AppColors.primary(context), size: 22.0),
                      ),
                    ],
                  )
                ],
              ),
              SizedBox(
                height: 10.0.h,
              ),
              Visibility(
                visible: projectProvider.isVisibleNotes,
                child: Expanded(child: ListNotesProject()),
                replacement: SizedBox(),
              ),
            ],
          ),
        ));
  }
}
