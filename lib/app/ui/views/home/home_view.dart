import 'package:app_tasking/app/ui/views/home/home_provider.dart';
import 'package:app_tasking/app/ui/views/home/views/home_view_desktop.dart';
import 'package:app_tasking/app/ui/views/home/views/home_view_mobile.dart';
import 'package:app_tasking/app/ui/views/home/views/home_view_tablet.dart';
import 'package:app_tasking/core/helpers/responsive.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  void initState() {
    super.initState();
    // Esperar hasta que el build inicial esté completo para acceder al contexto
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final homeProvider = Provider.of<HomeProvider>(context, listen: false);
      homeProvider.onInit(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Responsive.isDesktop(context)
        ? const HomeViewDesktop()
        : Responsive.isTablet(context)
            ? const HomeViewTablet()
            : const HomeViewMobile();
  }
}
