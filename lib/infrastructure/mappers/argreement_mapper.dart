import 'package:app_tasking/domain/entities/agreement.dart';
import 'package:app_tasking/infrastructure/models/agreement_model.dart';

class ArgreementMapper {

  static Agreement AgreementResponseToEntity(AgreementModel resp) {
    return Agreement(
     reunionId: resp.reunionId ?? '',
     agendaId: resp.agendaId ?? 0,
     agreementId: resp.agreementId ?? '',
     name: resp.agreement ?? '',
     privatity: resp.privacity ?? '',
     type: resp.type ?? '',
     responsibleId: resp.responsibleId ?? '',
     responsibleFullName: resp.responsibleFullNames ?? '',
     dateCreation: resp.dateCreation ?? '',
     limitDate: resp.dateLimit ?? '',
    //  projectId: resp. ?? '',
    //  taskId: resp.taskId ?? ''  ,
    );
  }

}