import 'package:app_tasking/domain/entities/project.dart';
import 'package:app_tasking/infrastructure/models/project_model.dart';

class ProjectMapper {
  static Project projectResponseToEntity(ProjectModel projectModel) => Project(
        id: projectModel.id,
        campanaid: projectModel.campanaId,
        companiaid: projectModel.companiaId,
        clienteid: projectModel.clienteId,
        clienteNombre: projectModel.clienteNombre,
        campanaNombre: projectModel.campanaNombre,
        campanaEstado: projectModel.campanaEstado,
        responsableNombre: projectModel.campanaNombre,
        supervisorNombre: projectModel.supervisorNombre,
        campanaFechaInicio: projectModel.campanaFechaInicio,
        campanaFechaFin: projectModel.campanaFechaFin,
        campanaEstados: projectModel.campanaEstado,
        campanaAvance: projectModel.campanaAvance,
        numberNewTask: projectModel.numberNewTask,
        numberNewComments: projectModel.numberNewComments,
        numberNewNotes: projectModel.numberNewNotes,
        numberNewReports: projectModel.numberNewReports,
        numberTask: projectModel.numberTask,
        firstParticipantId: projectModel.firstParticipantId,
        secondParticipantId: projectModel.secondParticipantId,
        firstParticipantFullName: projectModel.firstParticipantFullName,
        secondParticipantFullName: projectModel.secondParticipantFullName,
        responsablePhoto: projectModel.responsablePhoto,
        supervisorPhoto: projectModel.supervisorPhoto,
        firstParticipantPhoto: projectModel.firstParticipantPhoto,
        secondParticipantPhoto: projectModel.secondParticipantPhoto,
      );
}
