import 'package:app_tasking/domain/datasources/area_datasource.dart';
import 'package:app_tasking/domain/entities/area.dart';
import 'package:app_tasking/domain/repositories/area_repository.dart';

class AreaRepositoryImpl extends AreaRepository {
  final AreaDatasource areaDatasource;
  AreaRepositoryImpl(this.areaDatasource);
  @override
  Future<List<Area>> getAllAreas() {
    return areaDatasource.getAllAreas();
  }
}
