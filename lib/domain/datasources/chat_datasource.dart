import 'package:app_tasking/domain/entities/chat.dart';

abstract class ChatDatasource {
  Future<List<Chat>> getListChats(
    String personalId,
  );
}
