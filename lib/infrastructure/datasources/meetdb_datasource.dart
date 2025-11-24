import 'package:app_tasking/core/network/dio_client.dart';
import 'package:app_tasking/core/network/dio_config.dart';
import 'package:app_tasking/domain/datasources/meet_datasource.dart';
import 'package:app_tasking/domain/entities/meet.dart';
import 'package:app_tasking/domain/entities/participant.dart';
import 'package:app_tasking/infrastructure/mappers/meet_mapper.dart';
import 'package:app_tasking/infrastructure/mappers/participant_mapper.dart';
import 'package:app_tasking/infrastructure/models/meet_model.dart';
import 'package:app_tasking/infrastructure/models/response/response_general_model.dart';
import 'package:app_tasking/infrastructure/models/response/response_meet_model.dart';
import 'package:app_tasking/infrastructure/models/response/response_participant_model.dart';
import 'package:flutter/cupertino.dart';

class MeetdbDatasource extends MeetDatasource {
  late DioClient dioClient;
  MeetdbDatasource() {
    final dio = DioConfig.initialize();
    dioClient = DioClient(dio);
  }

  @override
  Future<List<Meet>> getMeetsByPerson(MeetModel request) async {
    try {
      final response = await dioClient.get(
          path: "/APIMeet/GetMeetings", queryParameters: request.toJson());
      final meetResponse = ResponseMeetModel.fromJson(response);
      if (meetResponse.data == null) return [];
      final meets = meetResponse.data!
          .map((resp) => MeetMapper.meetResponseToEntity(resp))
          .toList();
      return meets;
    } catch (e) {
      debugPrint('error obteniendo reuniones $e');
      return [];
    }
  }

  @override
  Future<Meet?> postCreateMeet(MeetModel meet) async {
    try {
      final response = await dioClient.post(
          path: "/APIMeet/CreateMeet", bodyRaw: meet.toJson());
      final meetResponse = ResponseMeetModel.fromJson(response);
      if (meetResponse.success == false) return null;
      final meetCreate =
          Meet(); // MeetMapper.meetResponseToEntity(meetResponse.data);

      return meetCreate;
    } catch (e) {
      debugPrint('error obteniendo reuniones $e');
      return Meet();
    }
  }

  @override
  Future<bool> postResponseMeet(
      String reunionId, String personalId, String stateInvitation) async {
    try {
      final response =
          await dioClient.post(path: "/APIMeet/ResponseMeet", bodyRaw: {
        "reunionId": reunionId,
        "personalId": personalId,
        "stateInvitation": stateInvitation,
      });
      final meetResponse = ResponseGeneralModel.fromJson(response);
      return meetResponse.succes;
    } catch (e) {
      debugPrint('error obteniendo reuniones $e');
      return false;
    }
  }

  @override
  Future<List<Participant>> getParticipants(String reunionId) async {
    try {
      final response = await dioClient
          .get(path: "/APIMeet/GetParticipants", queryParameters: {
        "reunionId": reunionId,
      });
      final participantResponse = ResponseParticipantModel.fromJson(response);
      if (participantResponse.data == null) return [];
      final participants = participantResponse.data!
          .map((item) => ParticipantMapper.participantResponseToEntity(item))
          .toList();
      return participants;
    } catch (e) {
      debugPrint('error obteniendo Participantes');
      return [];
    }
  }

  @override
  Future<Meet?> updateMeet(MeetModel meet) async {
    try {
      final response = await dioClient.post(
          path: "/APIMeet/reunionUpdate",
          bodyRaw: meet.toJson(),
          queryParameters: {
            "reunionId": meet.reunionId ?? '',
          });
      final meetResponse = ResponseMeetModel.fromJson(response);
      if (meetResponse.success == false) return null;
      final meetCreate =
          Meet(); // MeetMapper.meetResponseToEntity(meetResponse.data)
      return meetCreate;
    } catch (e) {
      return null;
    }
  }

  @override
  Future<Meet?> deleteMeet(String meetId) async {
    try {
      final response =
          await dioClient.post(path: "/APIMeet/reunionDelete", queryParameters: {
        "reunionId": meetId,
      }, bodyRaw: {
        "reunionId": meetId
      });

      final meetResponse = ResponseGeneralModel.fromJson(response);
      if (meetResponse.succes == false) return null;
      final meetCreate = Meet();
      return meetCreate;
    } catch (e) {
      debugPrint('error al eliminar la reunión');
      return null;
    }
  }

    @override
  Future<Meet?> updateState(String meetId) async {
    try {
      final response =
          await dioClient.post(path: "/APIMeet/reunionUpdateState", queryParameters: {
        "reunionId": meetId,
      }, bodyRaw: {
        "reunionId": meetId
      });

      final meetResponse = ResponseGeneralModel.fromJson(response);
      if (meetResponse.succes == false) return null;
      final meetCreate = Meet();
      return meetCreate;
    } catch (e) {
      debugPrint('error al finalizar la reunión');
      return null;
    }
  }
}
