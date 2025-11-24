import 'package:app_tasking/app/ui/views/home/home_provider.dart';
import 'package:app_tasking/app/ui/views/kanban/kanban_provider.dart';
import 'package:app_tasking/app/ui/views/kanban/widgets/multi_board_screen.dart';
import 'package:app_tasking/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
class KanbanView extends StatefulWidget {
  const KanbanView({super.key});

  @override
  State<KanbanView> createState() => _KanbanViewState();
}

class _KanbanViewState extends State<KanbanView> {
 

  @override
  Widget build(BuildContext context) {
    final kanbanController =
        Provider.of<KanbanProvider>(context, listen: true);

    final homeProvider = Provider.of<HomeProvider>(context);
    return Scaffold(
      body: Container(
        color: AppColors.backgroundKanbanColor(context),
        child: Column(
          children: [
            const SizedBox(
              height: 10.0,
            ),
            //Guardar esto para cuando este la migración
            /* showProjects == '1'
                ? const SizedBox()
                : AnimatedOpacity(
                    opacity: homecontroller.showProjectInKanban ? 1.0 : 0.0,
                    duration: const Duration(milliseconds: 500),
                    child: AnimatedContainer(
                      margin: const EdgeInsets.symmetric(horizontal: 10.0),
                      decoration: BoxDecoration(
                          color: AppColors.groupBackgroundKanbanColor(context),
                          borderRadius: BorderRadius.circular(8.0)),
                      curve: Curves.easeInOut,
                      duration: const Duration(milliseconds: 200),
                      height: homecontroller.showProjectInKanban ? 115.0 : 0.0,
                      child: Align(
                        alignment: Alignment.center,
                        child: SizedBox(
                          height: 100.0,
                          child: kanbanController.responseWhenNoProject.isEmpty
                              ? ListProjects()
                              : Text(kanbanController.responseWhenNoProject),
                        ),
                      ),
                    ),
                  ), */
            Expanded(
                child: kanbanController.isGettingListOfTask
                    ? const Center(
                        child: CircularProgressIndicator(
                        color: AppColors.primaryConst,
                      ))
                    : Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 10.0, vertical: 10.0),
                        child: MultiBoardScreen())),
          ],
        ),
      ),
    );
  }
}