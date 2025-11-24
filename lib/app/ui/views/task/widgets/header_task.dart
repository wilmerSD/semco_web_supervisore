import 'package:animate_do/animate_do.dart';
import 'package:app_tasking/app/ui/views/task/task_provider.dart';
import 'package:app_tasking/core/helpers/helpers.dart';
import 'package:app_tasking/core/theme/app_colors.dart';
import 'package:app_tasking/core/theme/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:provider/provider.dart';

class HeaderTask extends StatelessWidget {
  const HeaderTask({super.key});

  @override
  Widget build(BuildContext context) {
    final taskProvider = Provider.of<TaskProvider>(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FadeInDown(
          curve: Curves.decelerate,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IconButton(
                  onPressed: () {
                    taskProvider.visibleHeader();
                  },
                  icon: taskProvider.isShowHeaderTask
                      ? Icon(Bootstrap.caret_up_fill)
                      : Icon(Bootstrap.caret_down_fill)),
              taskProvider.taskObject.ordenPrioridad == 'medio' ||
                      taskProvider.taskObject.ordenPrioridad == 'alto'
                  ? Padding(
                      padding: EdgeInsets.only(top: 10, right: 5),
                      child: Icon(Bootstrap.fire, color: Colors.orange))
                  : SizedBox(),
              Text(
                      Helpers.capitalize(taskProvider
                              .taskObject.ordenProduccionTrabajoRealizar ??
                          ''),
                      overflow: TextOverflow.clip,
                      style: AppTextStyle(context).bold18(
                          color: AppColors.textBasic(context),
                          fontWeight: FontWeight.w500),
                    ),
              Expanded(
                child: Padding(
                    padding: EdgeInsets.only(top: 10),
                    child: Text(
                      Helpers.capitalize(taskProvider
                              .taskObject.ordenProduccionTrabajoRealizar ??
                          ''),
                      overflow: TextOverflow.clip,
                      /* style: AppTextStyle(context).bold18(
                          color: AppColors.textBasic(context),
                          fontWeight: FontWeight.w500), */
                    )),
              ),
            ],
          ),
        ),
        FadeInLeft(
          curve: Curves.easeIn,
          delay: Duration(milliseconds: 500),
          duration: Duration(milliseconds: 600),
          child: Row(
            children: [
              Expanded(
                child: LinearProgressIndicator(
                  value: (taskProvider.taskObject.ordenAvance ?? 0) / 100,
                  color: AppColors.primary(context),
                  minHeight: 5.0,
                ),
              ),
              SizedBox(
                width: 10.0.w,
              ),
              Text(("${taskProvider.taskObject.ordenAvance}%")),
            ],
          ),
        ),
        SizedBox(
          height: 10.0.h,
        ),
        taskProvider.isShowHeaderTask
            ? AnimatedContainer(
                duration: Duration(seconds: 10),
                padding: /* taskProvider.animate ? EdgeInsetsDirectional.all(30.0):  */
                    EdgeInsetsDirectional.all(10.0),
                // height: taskController.isShowHeaderTask ? null : 0,
                decoration: BoxDecoration(
                  color: AppColors.listProyectsColor(context),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.shadowListColor(context),
                      blurRadius: 2.0,
                      spreadRadius: 0.2,
                      offset: Offset(0, 0),
                    )
                  ],
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  spacing: 10.0.h,
                  children: [
                    /* FadeIn(
                curve: Curves.easeIn,
                duration: Duration(milliseconds: 300),
                child: Container(
                  padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    color: AppColors.primary(context),
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  child: InkWell(
                    onTap: () {},
                    child: Text(
                      "taskController.listProyectObject.campanaEstado ?? ''",
                      style: AppTextStyle(context).bold13(
                          color: Colors.white, fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10.0.h,
              ), */
                    FadeIn(
                      curve: Curves.easeIn,
                      delay: Duration(milliseconds: 400),
                      duration: Duration(milliseconds: 500),
                      child: Row(
                        children: [
                          Text(
                            "Responsable:",
                            style: AppTextStyle(context)
                                .bold15(color: AppColors.textBasic(context)),
                          ),
                          SizedBox(
                            width: 8.0.w,
                          ),
                          Text(
                            taskProvider.taskObject.ordenResponsableFullNames ?? '',
                            overflow: TextOverflow.fade,
                          ),
                        ],
                      ),
                    ),
                    FadeIn(
                      curve: Curves.easeIn,
                      delay: Duration(milliseconds: 600),
                      duration: Duration(milliseconds: 600),
                      child: Container(
                        padding: EdgeInsetsDirectional.all(10.0),
                        decoration: BoxDecoration(
                          color: AppColors.listProyectsColor(context),
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.shadowListColor(context),
                              blurRadius: 2.0,
                              spreadRadius: 0.2,
                              offset: Offset(0, 1),
                            )
                          ],
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Text(
                                  "Desde: ",
                                  style: AppTextStyle(context).bold15(
                                      color: AppColors.textBasic(context)),
                                ),
                                Text(Helpers.formatStringDateToddmmyy(
                                    taskProvider
                                            .taskObject.ordenFechaInicio ??
                                        '')),
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  "Hasta: ",
                                  style: AppTextStyle(context).bold15(
                                      color: AppColors.textBasic(context)),
                                ),
                                Text(Helpers.formatStringDateToddmmyy(
                                    taskProvider.taskObject.ordenFechaFin ??
                                        '')),
                                // Text(taskController.listProyectObject.campanaFechaFin ?? ''),
                              ],
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              )
            : SizedBox()
      ],
    );
  }
}
