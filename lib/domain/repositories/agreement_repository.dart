import 'package:app_tasking/domain/entities/agreement.dart';
import 'package:app_tasking/infrastructure/models/agreement_model.dart';

abstract class AgreementRepository {
  Future<List<Agreement>> getAgreements(String reunionId, int agendaId);
  Future<Agreement?> createAgreement(AgreementModel agreement);
}