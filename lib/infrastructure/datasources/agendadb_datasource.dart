import 'package:app_tasking/core/network/dio_client.dart';
import 'package:app_tasking/core/network/dio_config.dart';
import 'package:app_tasking/domain/datasources/agenda_datasource.dart';
import 'package:app_tasking/domain/entities/agenda.dart';
import 'package:app_tasking/infrastructure/mappers/agenda_mapper.dart';
import 'package:app_tasking/infrastructure/models/response/response_agenda.dart';
import 'package:flutter/widgets.dart';

class AgendadbDatasource extends AgendaDatasource {
  late DioClient dioClient;

  AgendadbDatasource() {
    final dio = DioConfig.initialize();
    dioClient = DioClient(dio);
  }

  @override
  Future<List<Agenda>> getAgenda(String reunionId) async {
    try {
      final response = await dioClient.get(
          path: "/APIMeet/getAgenda",
          queryParameters: {"reunionId": reunionId});

      final agendaResponse = ResponseAgenda.fromJson(response);
      if (agendaResponse.data == null || agendaResponse.success != true) {
        return [];
      }

      final agenda = agendaResponse.data!
          .map((resp) => AgendaMapper.agendaResponseToEntity(resp))
          .toList();
      return agenda;
    } catch (e) {
      debugPrint('error en datasource list areas$e');
      return [];
    }
  }
}
