import 'package:app_tasking/domain/entities/agenda.dart';

abstract class AgendaDatasource {
  Future<List<Agenda>> getAgenda(String reunionId);
}
