import 'package:app_tasking/domain/entities/agenda.dart';
import 'package:app_tasking/infrastructure/models/agenda_model.dart';

class AgendaMapper {
  static Agenda agendaResponseToEntity(AgendaModel agendaModel) => Agenda(
        reunionId: agendaModel.reunionId,
        id: agendaModel.reunDetId,
        tittle: agendaModel.reunDetTitulo,
        type: agendaModel.reunDetTipo,
        associatedTypeId: agendaModel.reunDetText01,
        associatedTypeName: agendaModel.reunDetAsociado,
        responsibleId: agendaModel.reunDetResponsableId,
        responsibleNames: agendaModel.reunDetResponsableNom,
        dateCreation: agendaModel.reunDetFecha,
        expectedResult: agendaModel.reunDetText02,
      );
}
