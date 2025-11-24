class Agreement {
  final String? reunionId;
  final int? agendaId;
  final String? agreementId;
  final String? name;
  final String? privatity; // "Pública" y "Privada"
  final String? type; //"Acuerdo" y "Nota"
  final String? responsibleId;
  final String? responsibleFullName;
  final String? dateCreation;
  final String? limitDate;
  final String? projectId;
  final String? taskId ;


  Agreement({
   this.reunionId,
   this.agendaId,
   this.agreementId,
   this.name,
   this.privatity,
   this.type,
   this.responsibleId,
   this.responsibleFullName,
   this.dateCreation,
   this.limitDate,
   this.projectId,
   this.taskId,
  });
}