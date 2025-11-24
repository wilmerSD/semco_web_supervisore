import 'package:app_tasking/app/ui/views/chat/chat_view.dart';
import 'package:app_tasking/app/ui/views/home/home_view.dart';
import 'package:app_tasking/app/ui/views/kanban/kanban_view.dart';
import 'package:app_tasking/app/ui/views/login/login_view.dart';
import 'package:app_tasking/app/ui/views/meet/meet_view.dart';
import 'package:app_tasking/app/ui/views/myprofile/myprofile_view.dart';
import 'package:app_tasking/app/ui/views/project/project_view.dart';
import 'package:app_tasking/app/ui/views/splash/splash_view.dart';
import 'package:app_tasking/app/ui/views/subtask/subtask_view.dart';
import 'package:app_tasking/app/ui/views/task/task_view.dart';
import 'package:app_tasking/core/routes/app_routes_name.dart';
import 'package:go_router/go_router.dart';

/// The route configuration.
final GoRouter appRouter = GoRouter(
  initialLocation: '/',
  routes: <RouteBase>[
    GoRoute(path: '/', builder: (context, state) => const SplashView()),
    GoRoute(path: AppRoutesName.LOGIN, builder: (context, state) => const LoginView(),),
    GoRoute(path: AppRoutesName.HOME, builder: (context, state) => const HomeView(),),
    GoRoute(path: AppRoutesName.PROJECT, builder: (context, state) => const ProjectView(),),
    GoRoute(path: AppRoutesName.TASK, builder: (context, state) => const TaskView(),),
    GoRoute(path: AppRoutesName.SUBTASK, builder: (context, state) => const SubtaskView(),),
    GoRoute(path: AppRoutesName.KANBAN, builder: (context, state) => const KanbanView(),),
    GoRoute(path: AppRoutesName.CHAT, builder: (context, state) => const ChatView(),),
    GoRoute(path: AppRoutesName.MYPROFILE, builder: (context, state) => const MyprofileView(),),
    GoRoute(path: AppRoutesName.MEET, builder: (context, state) => const MeetView(),),
  ],
);