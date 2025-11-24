import 'package:app_tasking/app/ui/components/custom_app_bar.dart';
import 'package:app_tasking/app/ui/components/header/header_options_home.dart';
import 'package:app_tasking/app/ui/views/gantt/gantt_view.dart';
import 'package:app_tasking/app/ui/views/home/home_provider.dart';
import 'package:app_tasking/app/ui/views/home/modeview/list_projects_director.dart';
import 'package:app_tasking/app/ui/views/home/modeview/list_proyects_compact.dart';
import 'package:app_tasking/app/ui/views/home/modeview/list_proyects_detailed.dart';
import 'package:app_tasking/app/ui/views/home/widgets/option_director.dart';
import 'package:app_tasking/app/ui/views/home/widgets/options_proyects.dart';
import 'package:app_tasking/app/ui/views/kanban/kanban_view.dart';
import 'package:app_tasking/core/theme/app_colors.dart';
import 'package:app_tasking/core/theme/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeViewMobile extends StatelessWidget {
  const HomeViewMobile({super.key});

  @override
  Widget build(BuildContext context) {
    final homeProvider = Provider.of<HomeProvider>(context);

    Widget customBody = Column(
      mainAxisAlignment: MainAxisAlignment.start, // Espaciar widgets
      mainAxisSize: MainAxisSize.max,
      children: [
        const HeaderOptionsHome(),
        homeProvider.optionProyect == 1
            ? const OptionsProyects()
            : const SizedBox(),
        //  const OptionDirector(),
        homeProvider.optionProyect == 0
            ? const OptionDirector()
            : const SizedBox(),
        homeProvider.optionProyect == 0
            ? Flexible(
                fit: FlexFit.tight,
                child: homeProvider.listType == 1
                    ? const ListProjectsDirector()
                    : homeProvider.listType == 2
                        ? const SizedBox()
                        : homeProvider.listType == 3
                            ? ListProyectsCompact()
                            : ListProyectsDetailed())
            : homeProvider.optionProyect == 1
                ? const Flexible(
                    child: KanbanView(),
                  )
                : const Flexible(
                    child: GanttView(),
                  )
      ],
    );

    return Scaffold(
      backgroundColor: AppColors.backgroundColor(context),
      appBar: CustomAppBar(
        context: context,
      ),
      body: Padding(
        padding:const EdgeInsets.symmetric(horizontal: 20.0),
        child: customBody),
      floatingActionButton: Container(
          padding: const EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: AppColors.backgroundColor(context),
            borderRadius: BorderRadius.circular(8.0),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2), // Shadow color
                spreadRadius: 1, // Extends the shadow in all directions
                blurRadius: 1, // Blurs the edges of the shadow
                offset:const  Offset(0, 0), // Controls the shadow's position (x, y)
              ),
            ],
          ),
          child: const InkWell(
            child: Text('Comunicator'),
          )),
    );
  }
}
