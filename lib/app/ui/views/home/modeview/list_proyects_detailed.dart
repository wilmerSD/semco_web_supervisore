import 'package:app_tasking/app/ui/views/home/home_provider.dart';
import 'package:app_tasking/app/ui/views/project/project_provider.dart';
import 'package:app_tasking/core/helpers/helpers.dart';
import 'package:app_tasking/core/routes/app_routes_name.dart';
import 'package:app_tasking/core/theme/app_colors.dart';
import 'package:app_tasking/core/theme/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:provider/provider.dart';

class ListProyectsCompact extends StatelessWidget {
  const ListProyectsCompact({super.key});

  @override
  Widget build(BuildContext context) {
    final homeProvider = Provider.of<HomeProvider>(context);
    final projectProvider = Provider.of<ProjectProvider>(context);
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
                    project.companiaid,
                  );
                  projectProvider.getListNotes(
                      project.campanaid, project.clienteid, project.companiaid);
                  context.push(AppRoutesName.PROJECT);
                },
                child: Container(
                    margin: const EdgeInsets.only(bottom: 13.0),
                    padding: const EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                        color: AppColors.listProyectsColor(context),
                        borderRadius: BorderRadius.circular(8.0),
                        border: Border.all(
                            color: AppColors.borderListProyectsColor(context))),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 5.0, horizontal: 8.0),
                              decoration: BoxDecoration(
                                  color: AppColors.primary(context),
                                  borderRadius: BorderRadius.circular(5.0)),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Icon(
                                    Icons.calendar_month,
                                    color: Colors.white,
                                    size: 16.0,
                                  ),
                                  const SizedBox(
                                    width: 8.0,
                                  ),
                                  Text(
                                    homeProvider.getEndDateFormatted(
                                        project.campanaFechaFin ?? ''),
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w400,
                                        fontSize: 15.0),
                                  )
                                ],
                              ),
                            ),
                            const SizedBox(
                              width: 10.0,
                            ),
                            Container(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 5.0, horizontal: 8.0),
                                decoration: BoxDecoration(
                                    color: project.campanaEstado == 'Terminado'
                                        ? AppColors.statusFinishedColor(context)
                                        : project.campanaEstado == 'En curso'
                                            ? AppColors.statusInWorkColor(
                                                context)
                                            : project.campanaEstado == 'Anulado'
                                                ? AppColors.statusReviewColor(
                                                    context)
                                                : project.campanaEstado ==
                                                        'Digitado'
                                                    ? AppColors
                                                        .statusReviewColor(
                                                            context)
                                                    : AppColors
                                                        .statusReviewColor(
                                                            context),
                                    borderRadius: BorderRadius.circular(5.0)),
                                child: Row(
                                  children: [
                                    const Icon(
                                      Icons.push_pin,
                                      color: Colors.white,
                                      size: 16.0,
                                    ),
                                    Text(project.campanaEstado ?? '',
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w400,
                                            fontSize: 15.0)),
                                  ],
                                )),
                            const SizedBox(
                              width: 10.0,
                            ),
                            Icon(Icons.access_time,
                                color: AppColors.timeToFinishedColor(context)),
                            const SizedBox(
                              width: 3.0,
                            ),
                            Text(
                                '${homeProvider.getDaysRemaining(project.campanaFechaFin ?? '', project.campanaFechaInicio ?? '')} días',
                                style: AppTextStyle(context).bold13(
                                    color: AppColors.timeToFinishedColor(
                                        context))),
                            const Spacer(),
                            project.campanaEstados == 'medio' ||
                                    project.campanaEstados == 'alto'
                                ? const Icon(
                                    Bootstrap.fire,
                                    color: Colors.orange,
                                  )
                                : const SizedBox()
                          ],
                        ),
                        const SizedBox(
                          height: 5.0,
                        ),
                        Text(Helpers.capitalize(project.campanaNombre ?? ''),
                            overflow: TextOverflow.ellipsis,
                            style: AppTextStyle(context).bold14(
                                fontWeight: FontWeight.w800,
                                color: AppColors.primary(context))),
                        const SizedBox(
                          height: 5.0,
                        ),
                        Row(
                          children: [
                            Expanded(
                              flex: 4,
                              child: LinearProgressIndicator(
                                value: ((double.parse(
                                        project.campanaAvance ?? '0.000')) /
                                    100),
                                backgroundColor: Colors.grey[300],
                                color: AppColors.primary(context),
                                minHeight: 7,
                              ),
                            ),
                            const SizedBox(
                              width: 10.0,
                            ),
                            Text(
                              '${homeProvider.percentageFormatted(project.campanaAvance ?? '0.000')}%',
                              style: AppTextStyle(context)
                                  .bold13(color: AppColors.textBasic(context)),
                            ),
                            // Expanded(flex: 1,child: SizedBox())
                          ],
                        ),
                        Row(
                          children: [
                            Text(Helpers.getInitial(
                                project.supervisorNombre ?? '')),
                            const SizedBox(
                              width: 3.0,
                            ),
                            const Icon(Icons.arrow_forward),
                            const SizedBox(
                              width: 3.0,
                            ),
                            Text(Helpers.getInitial(
                                project.responsableNombre ?? '')),
                            const SizedBox(
                              width: 25.0,
                            ),
                            const SizedBox(
                              width: 25.0,
                            ),
                            const Icon(
                              Bootstrap.folder_plus,
                              color: Colors.red,
                              size: 20.0,
                            ),
                            const SizedBox(
                              width: 3.0,
                            ),
                            Text(project.numberNewTask.toString()),
                            const SizedBox(
                              width: 15.0,
                            ),
                            const Icon(Bootstrap.chat_left,
                                color: Colors.blue, size: 20.0),
                            const SizedBox(
                              width: 3.0,
                            ),
                            Text(project.numberNewComments.toString()),
                            const SizedBox(
                              width: 15.0,
                            ),
                            const Icon(Bootstrap.bookmark,
                                color: Colors.green, size: 20.0),
                            const SizedBox(
                              width: 3.0,
                            ),
                            Text(project.numberNewNotes.toString()),
                            const SizedBox(
                              width: 15.0,
                            ),
                            const Icon(Bootstrap.check2_square,
                                color: Colors.orange, size: 20.0),
                            const SizedBox(
                              width: 3.0,
                            ),
                            Text(project.numberNewReports.toString()),
                          ],
                        )
                      ],
                    )),
              );
            },
          );
  }
}
