import 'package:app_tasking/domain/datasources/chat_datasource.dart';
import 'package:app_tasking/domain/entities/chat.dart';
import 'package:app_tasking/domain/repositories/chat_repository.dart';

class ChatRepositoryImpl extends ChatRepository {
  final ChatDatasource chatDatasource;
  ChatRepositoryImpl(this.chatDatasource);
  @override
  Future<List<Chat>> getListChats(String personalId) {
    return chatDatasource.getListChats(personalId);
  }
}
