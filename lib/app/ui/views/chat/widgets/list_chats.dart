import 'package:app_tasking/app/ui/views/chat/chat_provider.dart';
import 'package:app_tasking/core/routes/app_routes_name.dart';
import 'package:app_tasking/core/theme/app_colors.dart';
import 'package:app_tasking/core/theme/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class ListChats extends StatelessWidget {
  const ListChats({super.key});

  @override
  Widget build(BuildContext context) {
    final chatProvider = Provider.of<ChatProvider>(context);
    return Container(
      padding: const EdgeInsetsDirectional.all(10.0),
      decoration: BoxDecoration(
        color: AppColors.listProyectsColor(context),
        // boxShadow: [
        //   BoxShadow(
        //     color: AppColors.shadowListColor(context),
        //     blurRadius: 5.0,
        //     spreadRadius: 0.2,
        //     // offset: Offset(0, 0),
        //   )
        // ],
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: chatProvider.chats.isEmpty
          ? Center(
              child: Text("Comienza a chatear con tu equipo. 🚀",
                  style: AppTextStyle(context).bold18(
                      color: AppColors.textBasic(context),
                      fontWeight: FontWeight.w400)),
            )
          : ListView.builder(
              itemCount: chatProvider.chats.length,
              itemBuilder: (context, index) {
                final chats = chatProvider.chats[index];
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InkWell(
                      onTap: () => context.push(AppRoutesName.CHATMESSAGE),
                      child: CircleAvatar(
                        radius: 30,
                        child: chats.chatPhoto!.isEmpty
                            ? const Icon(Icons.person_2_outlined)
                            : const Icon(Icons.person),
                      ),
                    ),
                    InkWell(
                      onTap: () => context.push(AppRoutesName.CHATMESSAGE),
                      child: Column(
                        children: [
                          Text(
                            chats.chatName ?? '',
                            style: AppTextStyle(context)
                                .bold14(fontWeight: FontWeight.w600),
                          ),
                          Text(chats.chatLastMessage ?? '')
                        ],
                      ),
                    )
                  ],
                );
              }),
    );
  }
}
