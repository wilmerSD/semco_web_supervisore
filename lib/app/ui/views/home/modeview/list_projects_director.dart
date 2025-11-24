import 'package:app_tasking/app/ui/views/home/home_provider.dart';
import 'package:app_tasking/app/ui/views/home/widgets/expandable_datatable.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ListProjectsDirector extends StatelessWidget {
  const ListProjectsDirector({super.key});

  @override
  Widget build(BuildContext context) {
    final homeProvider = Provider.of<HomeProvider>(context);
    return ProjectsExpandableTable(
      projects: homeProvider.listProyects,
      loadTasks: (projectId) async {
        return [];
      },
      loadSubTasks: (taskId) async {
        return [];
      },
    );
  }
}
