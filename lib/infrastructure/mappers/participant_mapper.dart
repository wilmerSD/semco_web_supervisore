import 'package:app_tasking/domain/entities/participant.dart';
import 'package:app_tasking/infrastructure/models/participant_model.dart';

class ParticipantMapper {
  static Participant participantResponseToEntity(ParticipantModel participant)=> Participant(
    personalId: participant.personalId ?? '',
    fullName: participant.fullName ?? '',
    rol: participant.rol ?? '',
    state: participant.state ?? '',
  );
    
  }
