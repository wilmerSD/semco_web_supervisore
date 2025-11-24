import 'package:app_tasking/core/network/dio_client.dart';
import 'package:app_tasking/core/network/dio_config.dart';
import 'package:app_tasking/domain/datasources/chat_datasource.dart';
import 'package:app_tasking/domain/entities/chat.dart';
import 'package:app_tasking/infrastructure/mappers/chat_mapper.dart';
import 'package:app_tasking/infrastructure/models/response/response_list_chats_model.dart';

class ChatdbDatasource extends ChatDatasource {
  late DioClient dioClient;

  ChatdbDatasource() {
    final dio = DioConfig.initialize();
    dioClient = DioClient(dio);
  }

  @override
  Future<List<Chat>> getListChats(String personalId) async {
    try {
      final response = await dioClient.get(
          path: "/APITaskingv1/GetProcGetChats",
          queryParameters: {"Personalid": personalId});
      final chatResponse = ResponseListChatsModel.fromJson(response);
      if (chatResponse.data == null) return [];
      final chats = chatResponse.data!
          .map((data) => ChatMapper.chatResponseToEntity(data))
          .toList();
      return chats;
    } catch (e) {
     
      return [];
    }
  }
}

