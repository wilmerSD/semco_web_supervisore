
class Agenda {
    final String? reunionId;
    final int? id;
    final String? tittle;
    final String? typeId;
    final String? type;
    final String? associatedTypeId;
    final String? associatedTypeName;
    final String? responsibleId;
    final String? responsibleNames;
    final DateTime? dateCreation;
    final String? expectedResult;

    Agenda({
        this.reunionId,
        this.id,
        this.tittle,
        this.typeId,
        this.type,
        this.associatedTypeId,
        this.associatedTypeName,
        this.responsibleId,
        this.responsibleNames,
        this.dateCreation,
        this.expectedResult,
    });
}