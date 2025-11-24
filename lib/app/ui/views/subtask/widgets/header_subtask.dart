import 'package:animate_do/animate_do.dart';
import 'package:app_tasking/app/ui/views/subtask/subtask_provider.dart';
import 'package:app_tasking/core/helpers/helpers.dart';
import 'package:app_tasking/core/theme/app_colors.dart';
import 'package:app_tasking/core/theme/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:provider/provider.dart';

class HeaderSubtask extends StatelessWidget {
  const HeaderSubtask({super.key});

  @override
  Widget build(BuildContext context) {
    final subtaskProvider = Provider.of<SubtaskProvider>(context);
    return Column(
      children: [
        FadeInDown(
          curve: Curves.decelerate,
          child: Row(
           crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IconButton(
                  onPressed: () {
                    subtaskProvider.visibleHeaderSubTask();
                    print(subtaskProvider.subTaskObject.ordenProEstado);
                  },
                  icon: subtaskProvider.isShowHeaderSubTask
                      ? Icon(Bootstrap.caret_up_fill)
                      : Icon(Bootstrap.caret_down_fill)),
              subtaskProvider.subTaskObject.ordenPrioridad == 'medio' ||
                      subtaskProvider.subTaskObject.ordenPrioridad == 'alto'
                  ? Padding(
                      padding: EdgeInsets.only(top: 10, right: 5),
                      child: Icon(Bootstrap.fire, color: Colors.orange))
                  : SizedBox(),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(top: 10.0),
                  child: Text(
                    Helpers.capitalize(subtaskProvider.subTaskObject.ordenProduccionTrabajoRealizar ?? ''),
                    overflow: TextOverflow.clip,
                    style: AppTextStyle(context).bold18(
                        color: AppColors.textBasic(context),
                        fontWeight: FontWeight.w500),
                  ),
                ),
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
                  borderRadius:BorderRadius.circular(5),
                  value: (subtaskProvider.subTaskObject.ordenAvance ?? 0) / 100,
                  color: AppColors.primary(context),
                  minHeight: 6.0,
                ),
              ),
              SizedBox(
                width: 10.0.w,
              ),
              subtaskProvider.subTaskObject.ordenAvance != null ? Text(("${subtaskProvider.subTaskObject.ordenAvance}%")):const Text("0%"),
              //  Text("${taskController.percentageFormatted(taskController.listProyectObject.campanaAvance ?? '0.0000')}%"),
            ],
          ),
        ),
        SizedBox(
          height: 10.0.h,
        ),
        subtaskProvider.isShowHeaderSubTask ? AnimatedContainer(
          duration: Duration(milliseconds: 400),
          padding: /* taskController.animate ? EdgeInsetsDirectional.all(30.0):  */
              EdgeInsetsDirectional.all(10.0),
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
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Text("Horas trabajadas:",
                          style: AppTextStyle(context)
                              .bold15(color: AppColors.textBasic(context))),
                      Text("10"),
                    ],
                  ),
                ],
              ),
              SizedBox(
                    height: 10.0.h,
                  ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  FadeIn(
                    curve: Curves.easeIn,
                    delay: Duration(milliseconds: 400),
                    duration: Duration(milliseconds: 500),
                    child: Row(
                      children: [
                        Text(
                          "Supervisor:",
                          style: AppTextStyle(context)
                              .bold15(color: AppColors.textBasic(context)),
                        ),
                        SizedBox(
                          width: 8.0.w,
                        ),
                        Text(
                          Helpers.getInitial(subtaskProvider.subTaskObject.ordenSupervisorFullNames ?? ''),
                          overflow: TextOverflow.fade,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10.0.h,
                  ),
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
                          Helpers.getInitial(subtaskProvider.subTaskObject.ordenResponsableFullNames ?? ''),
                          overflow: TextOverflow.fade,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10.0.h,
              ),
              FadeIn(
                curve: Curves.easeIn,
                delay: Duration(milliseconds: 400),
                duration: Duration(milliseconds: 500),
                child: Row(
                  children: [
                    Text(
                      "Fecha:",
                      style: AppTextStyle(context)
                          .bold15(color: AppColors.textBasic(context)),
                    ),
                    SizedBox(
                      width: 8.0.w,
                    ),
                    Text(
                      "23/Ene>31Ene",
                      overflow: TextOverflow.fade,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10.0.h,
              ),
              /* FadeIn(
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
                            style: AppTextStyle(context)
                                .bold15(color: AppColors.textBasic(context)),
                          ),
                          Text(Helpers.formattedDateddmmyy(
                              subtaskProvider.taskObject.ordenFechaInicio)),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            "Hasta: ",
                            style: AppTextStyle(context)
                                .bold15(color: AppColors.textBasic(context)),
                          ),
                          Text(Helpers.formattedDateddmmyy(
                              subtaskProvider.taskObject.ordenFechaFin)),
                          // Text(taskController.listProyectObject.campanaFechaFin ?? ''),
                        ],
                      )
                    ],
                  ),
                ),
              ) */
            ],
          ),
        ): SizedBox()
      ],
    );
  }
}
