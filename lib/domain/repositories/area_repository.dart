  
import 'package:app_tasking/domain/entities/area.dart';

abstract class AreaRepository {
  Future<List<Area>> getAllAreas();
}