import 'package:app_tasking/domain/entities/meet.dart';
import 'package:app_tasking/infrastructure/models/meet_model.dart';

class MeetMapper {
  static Meet meetResponseToEntity(MeetModel meet) => Meet(
      reunionId: meet.reunionId ?? '',
      reunionTitulo: meet.reunionTitulo ?? '',
      reunionAsunto: meet.reunionAsunto ?? '',
      reunionModalidad: meet.reunionModalidad ?? '',
      reunionLugar: meet.reunionLugar ?? '',
      reunionClase: meet.reunionClase ?? '',
      reunionGrupoPro: meet.reunionGrupoPro ?? '',
      reuniomAreaConoci: meet.reuniomAreaConoci ?? '',
      reunionClienteId: meet.reunionClienteId ?? '',
      reunionClienteNombre: meet.reunionClienteNombre ?? '',
      reunionProyectoId: meet.reunionProyectoId ?? '',
      reunionProyectoNombre: meet.reunionProyectoNombre ?? '',
      reunionFecha: meet.reunionFecha,
      reunionHoraIni: meet.reunionHoraIni ?? '',
      reunionTotalHoras: meet.reunionTotalHoras ?? 0,
      reunionMinutos: meet.reunionMinutos ?? 0,
      reunionConvocanteId: meet.reunionConvocanteId ?? '',
      reunionConvocanteNom: meet.reunionConvocanteNom ?? '',
      reunionParticipantes: meet.reunionParticipantes ?? '',
      reunionQuantityChildrend: meet.reunionQuantityChildrend,
      meetStateGen: meet.reunionStateGen ?? false,
      color: meet.reunionText04, //Color
      reunionOldestDate: meet.reunionOldestDate,
      reunionNewestDate: meet.reunionNewestDate,
      agenda: [],
      reunionStateMeet: meet.reunionStateMeet ?? '',
      reunionIdMain: meet.reunionMainId ?? '',
      meetStateDesc: meet.reunionCampoNum01 == 0
          ? 'Pendiente'
          : meet.reunionCampoNum01 == 1
              ? 'En proceso'
              : meet.reunionCampoNum01 == 2
                  ? 'Terminado'
                  : 'Pendiente');
      
      
}
