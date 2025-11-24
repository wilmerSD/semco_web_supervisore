import 'package:app_tasking/domain/datasources/agenda_datasource.dart';
import 'package:app_tasking/domain/entities/agenda.dart';
import 'package:app_tasking/domain/repositories/agenda_repository.dart';

class AgendaRepositoryImpl extends AgendaRepository {
  final AgendaDatasource agendaDatasource;
  AgendaRepositoryImpl(this.agendaDatasource);

  @override
  Future<List<Agenda>> getAgenda(String reunionId) {
    return agendaDatasource.getAgenda(reunionId);
  }
}
