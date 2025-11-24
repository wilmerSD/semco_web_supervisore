import 'package:app_tasking/domain/entities/chat.dart';
import 'package:app_tasking/infrastructure/models/chat_model.dart';

class ChatMapper {
  static Chat chatResponseToEntity(ChatModel chat) => Chat(
    chatName: chat.chatName ?? '',
    chatPhoto: chat.chatPhoto ?? '' ,
    chatLastMessage: chat.chatLastMessage ?? '' ,
  );
}
