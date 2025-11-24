import 'package:app_tasking/app/providers/project_provider.dart';
import 'package:app_tasking/app/ui/views/chat/chat_provider.dart';
import 'package:app_tasking/app/ui/views/gantt/gantt_provider.dart';
import 'package:app_tasking/app/ui/views/home/home_provider.dart';
import 'package:app_tasking/app/ui/views/kanban/kanban_provider.dart';
import 'package:app_tasking/app/ui/views/meet/agreement_provider.dart';
import 'package:app_tasking/app/ui/views/meet/meet_provider.dart';
import 'package:app_tasking/app/ui/views/myprofile/myprofile_provider.dart';
import 'package:app_tasking/app/ui/views/project/project_provider.dart';
import 'package:app_tasking/app/ui/views/recoverpass/recover_password_provider.dart';
import 'package:app_tasking/app/ui/views/subtask/subtask_provider.dart';
import 'package:app_tasking/app/ui/views/task/task_provider.dart';
import 'package:app_tasking/core/config/app_config.dart';
import 'package:app_tasking/core/config/theme_app.dart';
import 'package:app_tasking/core/helpers/constant.dart';
import 'package:app_tasking/core/routes/go_router_app.dart';
import 'package:app_tasking/preferences/shared_preferences.dart';
import 'package:app_tasking/preferences/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:provider/provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() async {
  WidgetsFlutterBinding
      .ensureInitialized(); // Necesario para inicializar dependencias antes de runApp()

  AppConfig.initialize();

  await PreferencesUser.init();
  await initializeDateFormatting("ES", null);

  runApp(MultiProvider(providers: [
    ChangeNotifierProvider<RecoverPasswordProvider>(
        create: (_) => RecoverPasswordProvider()),
    ChangeNotifierProvider<HomeProvider>(create: (_) => HomeProvider()),
    ChangeNotifierProvider<TaskProvider>(create: (_) => TaskProvider()),
    ChangeNotifierProvider<SubtaskProvider>(create: (_) => SubtaskProvider()),
    ChangeNotifierProvider<MyprofileProvider>(
        create: (_) => MyprofileProvider()),
    ChangeNotifierProvider<KanbanProvider>(create: (_) => KanbanProvider()),
    ChangeNotifierProvider<GanttProvider>(create: (_) => GanttProvider()),
    ChangeNotifierProvider<AgreementProvider>(create: (_) => AgreementProvider()),
    ChangeNotifierProvider<ChatProvider>(
      create: (_) => ChatProvider(),
    ),
    ChangeNotifierProvider<MeetProvider>(
      create: (_) => MeetProvider(),
    ),
    ChangeNotifierProvider(
        create: (_) => ThemeProvider(darkMode: PreferencesUser().themeBool)),
    ChangeNotifierProvider<ProjectProvider>(
      create: (_) => ProjectProvider(),
    ),
    ChangeNotifierProvider<ProjectProviderP>(
      create: (_) => ProjectProviderP(),
    ),
    
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application. MaterialApp
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(720, 1280) /* ScreenUtil.defaultSize */,
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) => MaterialApp.router(
        locale:
            const Locale('es', 'ES'), // Aplica el idioma español globalmente
        supportedLocales: const [
          Locale('es', 'ES'), // Español
          Locale('en', 'US'), // Inglés
        ],
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
          DefaultWidgetsLocalizations.delegate,
        ],
        debugShowCheckedModeBanner: false,
        title: nameSystem,
        theme: ThemeApp(
                darkMode:
                    Provider.of<ThemeProvider>(context, listen: true).themeDark)
            .getTheme(),
        routerConfig: appRouter,
      ),
    );
  }
}
