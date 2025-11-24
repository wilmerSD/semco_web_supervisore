import 'package:app_tasking/app/ui/components/custom_app_bar.dart';
import 'package:app_tasking/app/ui/components/header/header_options_chat.dart';
import 'package:app_tasking/app/ui/views/chat/chat_provider.dart';
import 'package:app_tasking/app/ui/views/chat/widgets/filter_chat.dart';
import 'package:app_tasking/app/ui/views/chat/widgets/list_chats.dart';
import 'package:app_tasking/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:provider/provider.dart';

class ChatView extends StatelessWidget {
  const ChatView({super.key});

  @override
  Widget build(BuildContext context) {
    final chatProvider = Provider.of<ChatProvider>(context);

    return Scaffold(
        appBar: CustomAppBar(
          context: context,
        ),
        body: const Padding(
          padding:  EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            children: [
              HeaderOptionsChat(),
              FilterChat(),
              Expanded(child: ListChats())
            ],
          ),
        ),
        floatingActionButton: InkWell(
            onTap: () => chatProvider.getListChats(),
            child: Container(
              height: 35,
              decoration: BoxDecoration(
                  color: AppColors.primarySec,
                  borderRadius: BorderRadius.circular(8)),
              child: const Padding(
                  padding: EdgeInsets.all(10),
                  child: Icon(EvaIcons.message_square_outline)),
            )));
  }
}
