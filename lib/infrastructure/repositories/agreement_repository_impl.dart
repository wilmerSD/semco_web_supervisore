import 'package:app_tasking/domain/datasources/agreement_datasource.dart';
import 'package:app_tasking/domain/entities/agreement.dart';
import 'package:app_tasking/domain/repositories/agreement_repository.dart';
import 'package:app_tasking/infrastructure/models/agreement_model.dart';

class AgreementRepositoryImpl extends AgreementRepository {
  final AgreementDatasource agreementDatasource;
  AgreementRepositoryImpl(this.agreementDatasource);
  @override
  Future<Agreement?> createAgreement(AgreementModel agreement) {
    return agreementDatasource.createAgreement(agreement);
  }

  @override
  Future<List<Agreement>> getAgreements(String reunionId, int agendaId) {
    return agreementDatasource.getAgreements(reunionId, agendaId);
  }
}
