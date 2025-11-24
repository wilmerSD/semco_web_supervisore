  
import 'package:app_tasking/domain/entities/agenda.dart';

abstract class AgendaRepository {
  Future<List<Agenda>> getAgenda(String reunionId);
}