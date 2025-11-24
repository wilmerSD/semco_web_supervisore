import 'package:app_tasking/domain/entities/meet.dart';
import 'package:app_tasking/domain/entities/participant.dart';
import 'package:app_tasking/infrastructure/models/meet_model.dart';

abstract class MeetDatasource {
  Future<List<Meet>> getMeetsByPerson(MeetModel request);
  Future<Meet?> postCreateMeet(MeetModel meet);
  Future<bool> postResponseMeet(
      String reunionId, String personalId, String stateInvitation);
  Future<List<Participant>> getParticipants(String reunionId);
  Future<Meet?> updateMeet(MeetModel meet);
  Future<Meet?> deleteMeet(String meetId);
  Future<Meet?> updateState(String meetId); 
  // Future<Meet?> createMeet(String personId);
  // Future<Meet?> deleteMeet(String personId);
  // Future<Meet?> updateMeet(String personId);
}
