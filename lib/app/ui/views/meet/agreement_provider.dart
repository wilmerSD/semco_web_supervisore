import 'package:app_tasking/app/ui/components/toast/toast.dart';
import 'package:app_tasking/core/helpers/helpers.dart';
import 'package:app_tasking/domain/entities/agreement.dart';
import 'package:app_tasking/infrastructure/datasources/agreementdb_datasource.dart';
import 'package:app_tasking/infrastructure/models/agreement_model.dart';
import 'package:app_tasking/infrastructure/repositories/agreement_repository_impl.dart';
import 'package:flutter/material.dart';

class AgreementProvider with ChangeNotifier {
  List<Agreement> agreements = [];
  final AgreementRepositoryImpl agreementRepositoryImpl =
      AgreementRepositoryImpl(AgreementdbDatasource());

  Future<Agreement?> createAgreement(
    BuildContext context,
    String reunionId,
    int agendaId,
    String agreement,
    String type,
    String? privacity,
    String? responsibleId,
    String? responsibleFullName,
    String dateLimit,
    String? projecAsociatedId,
    String? taskAsociatedId,
    String? areaId,
    String? areaName,
  ) async {
    final agreementModel = AgreementModel(
      reunionId: reunionId,
      agendaId: agendaId,
      agreement: agreement,
      privacity: privacity,
      type: type,
      responsibleId: responsibleId,
      responsibleFullNames: responsibleFullName,
      dateLimit:
          type == 'Nota' ? null : Helpers.changeStringDateToymd(dateLimit),
      projectId: projecAsociatedId,
      taskId: taskAsociatedId,
      areaId: areaId,
      areaName: areaName,
    );
    final response =
        await agreementRepositoryImpl.createAgreement(agreementModel);
    if (response != null) {
      return response;
    } else {
      showToastGlobal(
        context,
        1,
        "error",
        "Upss...Ocurrio un error al crear la reunión, por favor intente nuevamente.",
      );
      return null;
    }
  }

  Future<bool> deleteAgreement(BuildContext context, String reunionId,
      int agendaId, String agreementId) async {
    final response = await agreementRepositoryImpl.deleteAgreement(
        reunionId, agendaId, agreementId);
    if (response) {
      // notifyListeners();
      return true;
    } else {
      showToastGlobal(
        context,
        1,
        "error",
        "Upss...Ocurrio un error al eliminar la reunión, por favor intente nuevamente.",
      );
      return false;
    }
  }

  Future<bool> updateAgreement(
      BuildContext context, Agreement agreement) async {
    final AgreementModel agreementModel = AgreementModel(
      reunionId: agreement.reunionId,
      agendaId: agreement.agendaId,
      agreementId: agreement.agreementId,
      agreement: agreement.name,
      privacity: agreement.privacity,
      type: agreement.type,
      responsibleId: agreement.responsibleId,
      responsibleFullNames: agreement.responsibleFullName,
      dateLimit: agreement.limitDate,
      projectId: agreement.projectId,
      taskId: agreement.taskId,
      areaId: agreement.areaId,
      areaName: agreement.areaName,
    );
    final response =
        await agreementRepositoryImpl.updateAgreement(agreementModel);
    if (response != null) {
      return true;
    } else {
      showToastGlobal(
        context,
        1,
        "error",
        "Upss...Ocurrio un error al editar la reunión, por favor intente nuevamente.",
      );
      return false;
    }
  }
}
