import 'package:app_tasking/core/helpers/helpers.dart';
import 'package:app_tasking/domain/entities/agreement.dart';
import 'package:app_tasking/infrastructure/datasources/agreementdb_datasource.dart';
import 'package:app_tasking/infrastructure/models/agreement_model.dart';
import 'package:app_tasking/infrastructure/repositories/agreement_repository_impl.dart';
import 'package:flutter/foundation.dart';

class AgreementProvider with ChangeNotifier {
  List<Agreement> agreements = [];
  final AgreementRepositoryImpl agreementRepositoryImpl =
      AgreementRepositoryImpl(AgreementdbDatasource());

  Future<Agreement> createAgreement(
    String reunionId,
    int agendaId,
    String agreement,
    String type,
    String privacity,
    String responsibleId,
    String responsibleFullName,
    String dateLimit,
    String? projecAsociatedId,
    String? taskAsociatedId, 
  ) async {
    final agreementModel = AgreementModel(
      reunionId: reunionId,
      agendaId: agendaId,
      agreement: agreement,
      privacity: privacity,
      type: type,
      responsibleId: responsibleId,
      responsibleFullNames: responsibleFullName,
      dateLimit: Helpers.changeStringDateToymd(dateLimit),
      projecAsociatedId: projecAsociatedId,
      taskAsociatedId: taskAsociatedId,
    );
    final response =
        await agreementRepositoryImpl.createAgreement(agreementModel);
    if (response != null) {
      return response;
    } else {
      throw Exception('Error creating agreement');
    }
  }
}
