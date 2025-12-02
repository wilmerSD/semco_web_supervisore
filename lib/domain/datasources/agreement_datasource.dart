import 'package:app_tasking/domain/entities/agreement.dart';
import 'package:app_tasking/infrastructure/models/agreement_model.dart';

abstract class AgreementDatasource {
  Future<List<Agreement>> getAgreements(String reunionId, int agendaId);
  Future<Agreement?> createAgreement(AgreementModel agreement);
  Future<bool> deleteAgreement(
      String reunionId, int agendaId, String agreementId);
  Future<Agreement?> updateAgreement(AgreementModel agreement);
}
