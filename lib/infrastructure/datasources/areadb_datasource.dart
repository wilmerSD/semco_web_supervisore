import 'package:app_tasking/core/network/dio_client.dart';
import 'package:app_tasking/core/network/dio_config.dart';
import 'package:app_tasking/domain/datasources/area_datasource.dart';
import 'package:app_tasking/domain/entities/area.dart';
import 'package:app_tasking/infrastructure/mappers/area_mapper.dart';
import 'package:app_tasking/infrastructure/models/response/response_area_model.dart';

class AreadbDatasource extends AreaDatasource {
  late DioClient dioClient;
  AreadbDatasource() {
    final dio = DioConfig.initialize();
    dioClient = DioClient(dio);
  }
  @override
  Future<List<Area>> getAllAreas() async {
    try {
      final response = await dioClient.get(
        path: "/APITaskingv1/ProcGetListClient",
      );
      final areasResponse = ResponseAreaModel.fromJson(response);
      if (areasResponse.data == null) {
        return [];
      }
      print(areasResponse.data!.length.toString());
      final areas = areasResponse.data!
          .map((resp) => AreaMapper.areaResponseToEntity(resp))
          .toList();
      return areas;
    } catch (e) {
      print('error en datasource list areas' + e.toString());
      return [];
    }
  }
}
