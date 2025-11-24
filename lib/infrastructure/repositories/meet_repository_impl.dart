import 'package:app_tasking/domain/datasources/meet_datasource.dart';
import 'package:app_tasking/domain/entities/meet.dart';
import 'package:app_tasking/domain/entities/participant.dart';
import 'package:app_tasking/domain/repositories/meet_repository.dart';
import 'package:app_tasking/infrastructure/models/meet_model.dart';

class MeetRepositoryImpl extends MeetRepository {
  final MeetDatasource meetDatasource;
  MeetRepositoryImpl(this.meetDatasource);

  @override
  Future<List<Meet>> getMeetsByPerson(MeetModel request) {
    return meetDatasource.getMeetsByPerson(request);
  }

  @override
  Future<Meet?> postCreateMeet(MeetModel meet) {
    return meetDatasource.postCreateMeet(meet);
  }

  @override
  Future<Meet?> updateMeet(MeetModel meet) {
    return meetDatasource.updateMeet(meet);
  }

  @override
  Future<Meet?> deleteMeet(String meetId) {
    return meetDatasource.deleteMeet(meetId);
  }

  @override
  Future<Meet?> updateState(String meetId) {
    return meetDatasource.updateState(meetId);
  }


  @override
  Future<bool> postResponseMeet(
      String reunionId, String personalId, String stateInvitation) {
    return meetDatasource.postResponseMeet(
        reunionId, personalId, stateInvitation);
  }

  @override
  Future<List<Participant>> getParticipants(String reunionId) {
    return meetDatasource.getParticipants(reunionId);
  }
}
