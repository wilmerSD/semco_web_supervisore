import 'package:app_tasking/domain/entities/agenda.dart';

class Meet {
  String? reunionId;
  String? reunionTitulo;
  final String? reunionAsunto;
  final String? reunionModalidad;
  final String? reunionLugar;
  final String? reunionClase;
  final String? reunionGrupoPro;
  final String? reuniomAreaConoci;
  final String? reunionClienteId;
  final String? reunionClienteNombre;
  final String? reunionProyectoId;
  final String? reunionProyectoNombre;
  final DateTime? reunionFecha;
  final String? reunionHoraIni;
  final int? reunionTotalHoras;
  final int? reunionMinutos;
  final String? reunionConvocanteId;
  final String? reunionConvocanteNom;
  final String? reunionParticipantes;
  final String? reunionText04;
   int? reunionQuantityChildrend;
  final bool? meetStateGen;
  final String? meetStateDesc;
  final String? color;
  final String? reunionOldestDate;
  final String? reunionNewestDate;
   String? reunionStateMeet; //Pendiente,Aceptado, Rechazado, Finalizado
  final String? reunionIdMain;
  final List<Agenda>? agenda;
  //Considerar agregar otro campo para guardar al que creo la reunión
  Meet(
      {this.reunionId,
      this.reunionTitulo,
      this.reunionAsunto,
      this.reunionModalidad,
      this.reunionLugar,
      this.reunionClase,
      this.reunionGrupoPro,
      this.reuniomAreaConoci,
      this.reunionClienteId,
      this.reunionClienteNombre,
      this.reunionProyectoId,
      this.reunionProyectoNombre,
      this.reunionFecha,
      this.reunionHoraIni,
      this.reunionTotalHoras,
      this.reunionMinutos,
      this.reunionConvocanteId,
      this.reunionConvocanteNom,
      this.reunionParticipantes,
      this.reunionText04,
      this.reunionQuantityChildrend,
      this.meetStateGen,
      this.meetStateDesc,
      this.color,
      this.reunionOldestDate,
      this.reunionNewestDate,
      this.agenda,
      this.reunionStateMeet,
      this.reunionIdMain,
      });
}
