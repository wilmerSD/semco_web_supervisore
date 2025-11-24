import 'package:app_tasking/domain/entities/chat.dart';
import 'package:app_tasking/infrastructure/datasources/chatdb_datasource.dart';
import 'package:app_tasking/infrastructure/models/response/response_list_chats_model.dart';
import 'package:app_tasking/infrastructure/repositories/chat_repository_impl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class ChatProvider with ChangeNotifier {
  //INSTANCIAS
  final FlutterSecureStorage secureStorage = const FlutterSecureStorage();
  ResponseListChatsModel responseListChats = ResponseListChatsModel();

  ChatRepositoryImpl chatRepositoryImpl =
      ChatRepositoryImpl(ChatdbDatasource());
  //VARIABLES
  String personalId = '';
  List<Chat> chats = [];
  bool isGetListChats = false;
  //FUNCIONES
  Future<void> getDataPersonal() async {
    // username = await secureStorage.read(key: 'kUserName') ?? "";
    // password = await secureStorage.read(key: 'kPassword') ?? "";
    personalId = await secureStorage.read(key: 'kIdUser') ?? '';
  }

  Future<void> getListChats() async {
    await getDataPersonal();
    isGetListChats = true;
    try {
      final response = await chatRepositoryImpl.getListChats(personalId);
      if (response.isEmpty) {
        return;
      }
      chats.addAll(response);
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      isGetListChats = false;
      notifyListeners();
    }
  }
}
