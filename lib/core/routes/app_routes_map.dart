import 'package:app_tasking/app/ui/views/chat/chat_view.dart';
import 'package:app_tasking/app/ui/views/chat/widgets/chat_message.dart';
import 'package:app_tasking/app/ui/views/chat/widgets/info_contacto.dart';
import 'package:app_tasking/app/ui/views/gantt/gantt_view.dart';
import 'package:app_tasking/app/ui/views/home/home_view.dart';
import 'package:app_tasking/app/ui/views/home/widgets/new_proyect.dart';
import 'package:app_tasking/app/ui/views/kanban/kanban_view.dart';
import 'package:app_tasking/app/ui/views/login/login_view.dart';
import 'package:app_tasking/app/ui/views/meet/meet_view.dart';
import 'package:app_tasking/app/ui/views/meet/widgets/new_meet.dart';
import 'package:app_tasking/app/ui/views/myprofile/myprofile_view.dart';
import 'package:app_tasking/app/ui/views/project/project_view.dart';
import 'package:app_tasking/app/ui/views/recoverpass/recover_password_view.dart';
import 'package:app_tasking/app/ui/views/splash/splash_view.dart';
import 'package:app_tasking/app/ui/views/subtask/subtask_view.dart';
import 'package:app_tasking/app/ui/views/task/task_view.dart';
import 'package:app_tasking/app/ui/views/task/widgets/new_task.dart';
import 'package:app_tasking/core/routes/app_routes_name.dart';
import 'package:flutter/material.dart';

class AppRoutes {
  static Map<String, WidgetBuilder> get routes {
    return {
      AppRoutesName.SPLASH: (context) => const SplashView(),
      AppRoutesName.LOGIN: (context) => const LoginView(),
      AppRoutesName.RECOVERPASS: (context) => const RecoverPasswordView(),
      AppRoutesName.HOME: (context) => const HomeView(),
      AppRoutesName.MYPROFILE: (context) => const MyprofileView(),
      AppRoutesName.TASK: (context) => const TaskView(),
      AppRoutesName.SUBTASK: (context) => const SubtaskView(),
      AppRoutesName.KANBAN: (context) => const KanbanView(),
      AppRoutesName.GANTT: (context) => const GanttView(),
      AppRoutesName.CHAT: (context) => const ChatView(),
      AppRoutesName.NEWPROYECT: (context) => const NewProyect(),
      AppRoutesName.NEWTASK: (context) => const NewTask(),
      AppRoutesName.MEET: (context) => const MeetView(),
      AppRoutesName.NEWMEET:(context) =>const NewMeet(),
      AppRoutesName.CHATMESSAGE:(context) => const ChatMessage(),
      AppRoutesName.INFOCONTACTO:(context) => const InfoContacto(),
      AppRoutesName.PROJECT: (context) => const ProjectView(),
    };
  }
}
