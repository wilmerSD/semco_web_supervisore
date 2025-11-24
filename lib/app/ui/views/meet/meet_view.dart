import 'package:app_tasking/app/providers/project_provider.dart';
import 'package:app_tasking/app/ui/components/custom_app_bar.dart';
import 'package:app_tasking/app/ui/views/meet/meet_provider.dart';
import 'package:app_tasking/app/ui/views/meet/views/meet_view_desktop.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MeetView extends StatefulWidget {
  const MeetView({super.key});

  @override
  State<MeetView> createState() => _MeetViewState();
}

class _MeetViewState extends State<MeetView> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final meetProvider = Provider.of<MeetProvider>(context, listen: false);
      meetProvider.onInit();
      context.read<ProjectProviderP>().getListProjects();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // final meetProvider = Provider.of<MeetProvider>(context);
    // print('principan meet'+ meetProvider.typeView.toString());
    // print(meetProvider.listMeet.length);
    return Scaffold(
        appBar: CustomAppBar(
          context: context,
        ),
        body: const Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.0),
          child: Column(
            children: [
              Expanded(child: MeetViewDesktop()),
            ],
          ),
        ));
  }
}
