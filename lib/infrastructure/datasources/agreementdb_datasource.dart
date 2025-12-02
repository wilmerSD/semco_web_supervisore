import 'package:app_tasking/core/network/dio_client.dart';
import 'package:app_tasking/core/network/dio_config.dart';
import 'package:app_tasking/domain/datasources/agreement_datasource.dart';
import 'package:app_tasking/domain/entities/agreement.dart';
import 'package:app_tasking/infrastructure/mappers/argreement_mapper.dart';
import 'package:app_tasking/infrastructure/mappers/meet_mapper.dart';
import 'package:app_tasking/infrastructure/models/agreement_model.dart';
import 'package:app_tasking/infrastructure/models/response/response_agreement_model.dart';
import 'package:flutter/widgets.dart';

class AgreementdbDatasource extends AgreementDatasource {
  late DioClient dioClient;

  AgreementdbDatasource() {
    final dio = DioConfig.initialize();
    dioClient = DioClient(dio);
  }

  @override
  Future<Agreement?> createAgreement(AgreementModel agreement) async {
    try {
      final response = await dioClient.post(
          path: "/APIAgreement/CreateAgreement", bodyRaw: agreement.toJson());
      final agreementResponse = ResponseAgreementModel.fromJson(response);
      if (agreementResponse.success == false) return null;
      final meetCreate = ArgreementMapper.agreementResponseToEntity(
          agreementResponse.data![0]);
      return meetCreate;
    } catch (e) {
      debugPrint('error obteniendo reuniones $e');
      return null;
    }
  }

  @override
  Future<List<Agreement>> getAgreements(String reunionId, int agendaId) async {
    try {
      final response = await dioClient.get(
          path: "/APIAgreement/GetAgreements",
          queryParameters: {"reunionId": reunionId, "agendaId": agendaId});

      final agreementResponse = ResponseAgreementModel.fromJson(response);
      if (agreementResponse.data == null || agreementResponse.success != true) {
        return [];
      }

      final agreements = agreementResponse.data!
          .map((resp) => ArgreementMapper.agreementResponseToEntity(resp))
          .toList();
      return agreements;
    } catch (e) {
      debugPrint('error en datasource lista de acuerdos$e');
      return [];
    }
  }

  @override
  Future<bool> deleteAgreement(
      String reunionId, int agendaId, String agreementId) async {
    final response = await dioClient.post(
        path: "/APIAgreement/DeleteAgreement",
        bodyRaw: {
          "reunionId": reunionId,
          "agendaId": agendaId,
          "agreementId": agreementId
        });
    final agreementResponse = ResponseAgreementModel.fromJson(response);
    if (agreementResponse.success == false) return false;
    return true;
  }

  @override
  Future<Agreement?> updateAgreement(AgreementModel agreement) async {
    final response = await dioClient.post(
        path: "/APIAgreement/UpdateAgreement", bodyRaw: agreement.toJson());
    final agreementResponse = ResponseAgreementModel.fromJson(response);
    if (agreementResponse.success == false) return null;
    final meetCreate =
        ArgreementMapper.agreementResponseToEntity(agreementResponse.data![0]);
    return meetCreate;
  }
}
