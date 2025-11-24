import 'package:app_tasking/app/ui/views/home/home_provider.dart';
import 'package:app_tasking/app/ui/views/project/project_provider.dart';
import 'package:app_tasking/core/routes/app_routes_name.dart';
import 'package:app_tasking/core/theme/app_colors.dart';
import 'package:app_tasking/core/theme/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class ListProyectsDetailed extends StatelessWidget {
  const ListProyectsDetailed({super.key});

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      final homeProvider = Provider.of<HomeProvider>(context);
      final projectProvider =
          Provider.of<ProjectProvider>(context, listen: true);

      return homeProvider.isGettingProjects
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: homeProvider.listProyects.length,
              itemBuilder: (context, index) {
                final project = homeProvider.listProyects[index];
                return InkWell(
                  onTap: () {
                    projectProvider.getListOfTask(
                        context,
                        project,
                        homeProvider.personalId,
                        project.campanaid,
                        project.clienteid,
                        project.companiaid);
                    projectProvider.getListNotes(project.campanaid,
                        project.clienteid, project.companiaid);
                    context.go(AppRoutesName.PROJECT);
                  },
                  child: Container(
                      margin: EdgeInsets.only(bottom: 13.0.h),
                      padding: EdgeInsets.only(bottom: 13.0.h),
                      decoration: const BoxDecoration(
                          border: Border(
                        bottom: BorderSide(
                          width: 0.5,
                          color: Colors.blueGrey,
                        ),
                      )),
                      child: Row(
                        children: [
                          Expanded(
                            // flex: project.numberNewTask == 0 ? 11 : 8,
                            child: Text(project.campanaNombre ?? '',
                                overflow: TextOverflow.ellipsis,
                                style: AppTextStyle(context).bold13(
                                    color: AppColors.textBasic(context))),
                          ),
                          SizedBox(
                            width: 10.w,
                          ),
                          Text(
                            '${homeProvider.percentageFormatted(project.campanaAvance ?? '0.000')}%',
                            style: AppTextStyle(context)
                                .bold13(color: AppColors.textBasic(context)),
                          ),
                          project.numberNewTask == 0
                              ? const SizedBox()
                              : SizedBox(
                                  width: 10.w,
                                ),
                          project.numberNewTask == 0
                              ? const SizedBox()
                              : const Icon(
                                  Icons.folder_outlined,
                                  color: Color.fromRGBO(255, 0, 0, 1),
                                ),
                          project.numberNewReports == 0
                              ? const SizedBox()
                              : SizedBox(
                                  width: 8.w,
                                ),
                          project.numberNewReports == 0
                              ? const SizedBox()
                              : const Icon(
                                  Icons.check_box_outlined,
                                  color: Color.fromRGBO(249, 122, 32, 1),
                                ),
                          project.numberNewComments == 0 ||
                                  project.numberNewNotes == 0
                              ? const SizedBox()
                              : SizedBox(
                                  width: 8.w,
                                ),
                          project.numberNewComments == 0 ||
                                  project.numberNewNotes == 0
                              ? SizedBox()
                              : Icon(
                                  Icons.message_outlined,
                                  color: AppColors.primary(context),
                                ),
                        ],
                      )),
                );
              },
            );
    });
  }
}
