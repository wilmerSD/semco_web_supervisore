import 'package:app_tasking/domain/entities/agreement.dart';
import 'package:app_tasking/infrastructure/models/agreement_model.dart';

class ArgreementMapper {
  static Agreement agreementResponseToEntity(AgreementModel resp) {
    return Agreement(
      reunionId: resp.reunionId ?? '',
      agendaId: resp.agendaId ?? 0,
      agreementId: resp.agreementId ?? '',
      name: resp.agreement ?? '',
      privacity: resp.privacity ?? '',
      type: resp.type ?? '',
      responsibleId: resp.responsibleId,
      responsibleFullName: resp.responsibleFullNames?.isEmpty ?? true
          ? '-'
          : resp.responsibleFullNames,
      dateCreation: resp.dateCreation ?? '',
      limitDate: resp.dateLimit ?? '',
      projectId: resp.projectId ?? '',
      taskId: resp.taskId ?? '',
      areaId: resp.areaId,
      areaName: resp.areaName?.isEmpty ?? true ? '-' : resp.areaName,
    );
  }
}
