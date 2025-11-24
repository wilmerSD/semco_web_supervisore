import 'package:app_tasking/app/ui/views/task/task_provider.dart';
import 'package:app_tasking/app/ui/views/task/widgets/new_evaluation_task.dart';
import 'package:app_tasking/app/ui/views/task/widgets/new_comment_task.dart';
import 'package:app_tasking/app/ui/views/task/widgets/new_note_task.dart';
import 'package:app_tasking/app/ui/views/task/widgets/new_report_task.dart';
import 'package:app_tasking/core/theme/app_colors.dart';
import 'package:app_tasking/core/theme/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class SelectTypeNoteTask extends StatelessWidget {
  const SelectTypeNoteTask({super.key});

  @override
  Widget build(BuildContext context) {
    final taskProvider = Provider.of<TaskProvider>(context);
    Widget newComment = InkWell(
      onTap: () {
        taskProvider.selectTypeNote(0, context);
        print("Selecciono comentario 0");
      },
      child: AnimatedContainer(
        curve: Curves.easeInOut,
        duration: const Duration(milliseconds: 500),
        padding: EdgeInsets.symmetric(horizontal: 5.0),
        height: 40.0.h,
        width: 90.0.w,
        child: Center(
          child: Text(
            "Comentario",
            style: AppTextStyle(context)
                .bold13(color: Colors.white, fontWeight: FontWeight.w600),
          ),
        ),
        decoration: BoxDecoration(
          color: taskProvider.optionTypeNote == 0
              ? AppColors.commentColor(context)
              : AppColors.commentColorSec(context),
          borderRadius: BorderRadius.circular(10.0),
          /* border: Border.all(
            color: AppColors.primary(context),
            width: 1,
          ), */
        ),
      ),
    );
    Widget newNote = InkWell(
      onTap: () {
        taskProvider.selectTypeNote(1, context);
        print("Selecciono nota 1");
      },
      child: AnimatedContainer(
        curve: Curves.easeInOut,
        duration: const Duration(milliseconds: 500),
        padding: EdgeInsets.symmetric(horizontal: 5.0),
        height: 40.0.h,
        width: 90.0.w,
        child: Center(
            child: Text("Nota",
                style: AppTextStyle(context)
                    .bold13(color: Colors.white, fontWeight: FontWeight.w600))),
        decoration: BoxDecoration(
          color: taskProvider.optionTypeNote == 1
              ? AppColors.noteColor(context)
              : AppColors.noteColorSec(context),
          borderRadius: BorderRadius.circular(10.0),
          /* border: Border.all(
            color: AppColors.primary(context),
            width: 1,
          ), */
        ),
      ),
    );
    Widget newReport = InkWell(
      onTap: () {
        taskProvider.selectTypeNote(2, context);
        print("Selecciono reporte 2");
      },
      child: AnimatedContainer(
          curve: Curves.easeInOut,
          duration: const Duration(milliseconds: 500),
          padding: EdgeInsets.symmetric(horizontal: 5.0),
          height: 40.0.h,
          width: 90.0.w,
          child: Center(
              child: Text("Reporte",
                  style: AppTextStyle(context).bold13(
                      color: Colors.white, fontWeight: FontWeight.w600))),
          decoration: BoxDecoration(
            color: taskProvider.optionTypeNote == 2
                ? AppColors.reportColor(context)
                : AppColors.reportColorSec(context),
            borderRadius: BorderRadius.circular(10.0),
            /* border: Border.all(
              color: AppColors.primary(context),
              width: 1,
            ), */
          )),
    );
    Widget newEvaluation = InkWell(
      onTap: () {
        taskProvider.selectTypeNote(4, context);
      },
      child: AnimatedContainer(
          curve: Curves.easeInOut,
          duration: const Duration(milliseconds: 500),
          padding: EdgeInsets.symmetric(horizontal: 5.0.w),
          height: 40.0.h,
          width: 90.0.w,
          child: Center(
              child: Text("Evaluación",
                  style: AppTextStyle(context).bold13(
                      color: Colors.white, fontWeight: FontWeight.w600))),
          decoration: BoxDecoration(
            color: taskProvider.optionTypeNote == 4
                ? AppColors.evaluationColor(context)
                : AppColors.evaluationColorSec(context),
            borderRadius: BorderRadius.circular(10.0),
            /* border: Border.all(
              color: taskProvider.optionTypeNote == 3 ? AppColors.primary(context): Colors.transparent,
              width: 1,
            ), */
          )),
    );

    return Column(
      spacing: 10.0.h,
      children: [
        SizedBox(
                height: 40.0.h,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    newComment,
                    SizedBox(width: 10.0.w,),
                    newNote,
                    SizedBox(width: 10.0.w,),
                    newReport,
                    SizedBox(width: 10.0.w,),
                    newEvaluation,
                  ],
                ),
              ),
        // taskProvider.taskObject.ordenAvance == 100
        //     ? SizedBox(
        //         height: 20.0.h,
        //         child: ListView(
        //           scrollDirection: Axis.horizontal,
        //           children: [
        //             newComment,
        //             newNote,
        //             newReport,
        //             newEvaluation,
        //           ],
        //         ),
        //       )
        //     : Row(
        //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //         children: [
        //           newComment,
        //           newNote,
        //           newReport,
        //         ],
        //       ),
        taskProvider.optionTypeNote == 0
            ? NewCommentTask()
            : taskProvider.optionTypeNote == 1
                ? NewNoteTask()
                : taskProvider.optionTypeNote == 2
                    ? NewReportTask()
                    : taskProvider.optionTypeNote == 4
                        ? NewEvaluationTask()
                        : SizedBox()
      ],
    );
  }
}
