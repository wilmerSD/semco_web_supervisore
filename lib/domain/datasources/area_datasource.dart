import 'package:app_tasking/domain/entities/area.dart';

abstract class AreaDatasource {
  Future<List<Area>> getAllAreas();
  // Future<Area?> createArea();
  // Future<Area?> deleteArea();
  // Future<Area?> editArea();
}
