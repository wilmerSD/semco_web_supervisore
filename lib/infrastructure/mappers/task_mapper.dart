import 'package:app_tasking/domain/entities/task.dart';
import 'package:app_tasking/infrastructure/models/task_model.dart';

class TaskMapper {
  static Task taskResponseToEntity(TaskModel taskModel) => Task(
        id: taskModel.id,
        ordenProduccionId: taskModel.ordenProduccionId,
        campanaId: taskModel.campanaId,
        companiaId: taskModel.companiaId,
        clienteId: taskModel.clienteId,
        ordenProduccionTrabajoRealizar:
            taskModel.ordenProduccionTrabajoRealizar,
        ordenProdCampanaName: taskModel.ordenProdCampanaName,
        ordenDetalle: taskModel.ordenDetalle,
        ordenFechaInicio: taskModel.ordenFechaInicio,
        ordenFechaFin: taskModel.ordenFechaFin,
        ordenFechaFinReal: taskModel.ordenFechaFinReal,
        ordenSupervisorId: taskModel.ordenSupervisorId,
        ordenResponsableId: taskModel.ordenResponsableId,
        ordenSupervisorFullNames: taskModel.ordenSupervisorFullNames,
        ordenResponsableFullNames: taskModel.ordenResponsableFullNames,
        ordenAvance: taskModel.ordenAvance,
        ordenProEstado: taskModel.ordenProEstado,
        ordenCampo3: taskModel.ordenCampo3,
        ordenPrioridad: taskModel.ordenPrioridad,
        ordenClientName: taskModel.ordenClientName,
        ordenNumberNewComment: taskModel.ordenNumberNewComment,
        ordenFirstParticipantId: taskModel.ordenFirstParticipantId,
        ordenFirstParticipantFullName: taskModel.ordenFirstParticipantFullName,
        ordenSecondParticipantId: taskModel.ordenSecondParticipantId,
        ordenSecondParticipantFullName:
            taskModel.ordenSecondParticipantFullName,
        ordenResponsablePhoto: taskModel.ordenResponsablePhoto,
        ordenSupervisorPhoto: taskModel.ordenSupervisorPhoto,
        ordenFirstParticipantPhoto: taskModel.ordenFirstParticipantPhoto,
        ordenSecondParticipantPhoto: taskModel.ordenSecondParticipantPhoto,
        ordenIndex: taskModel.ordenIndex,
      );

  static TaskModel taskToTaskModel(Task task) => TaskModel(
        id: task.id,
        ordenProduccionId: task.ordenProduccionId,
        campanaId: task.campanaId,
        companiaId: task.companiaId,
        clienteId: task.clienteId,
        ordenProduccionTrabajoRealizar:
            task.ordenProduccionTrabajoRealizar,
        ordenProdCampanaName: task.ordenProdCampanaName,
        ordenDetalle: task.ordenDetalle,
        ordenFechaInicio: task.ordenFechaInicio,
        ordenFechaFin: task.ordenFechaFin,
        ordenFechaFinReal: task.ordenFechaFinReal,
        ordenSupervisorId: task.ordenSupervisorId,
        ordenResponsableId: task.ordenResponsableId,
        ordenSupervisorFullNames: task.ordenSupervisorFullNames,
        ordenResponsableFullNames: task.ordenResponsableFullNames,
        ordenAvance: task.ordenAvance,
        ordenProEstado: task.ordenProEstado,
        ordenCampo3: task.ordenCampo3,
        ordenPrioridad: task.ordenPrioridad,
        ordenClientName: task.ordenClientName,
        ordenNumberNewComment: task.ordenNumberNewComment,
        ordenFirstParticipantId: task.ordenFirstParticipantId,
        ordenFirstParticipantFullName: task.ordenFirstParticipantFullName,
        ordenSecondParticipantId: task.ordenSecondParticipantId,
        ordenSecondParticipantFullName:
            task.ordenSecondParticipantFullName,
        ordenResponsablePhoto: task.ordenResponsablePhoto,
        ordenSupervisorPhoto: task.ordenSupervisorPhoto,
        ordenFirstParticipantPhoto: task.ordenFirstParticipantPhoto,
        ordenSecondParticipantPhoto: task.ordenSecondParticipantPhoto,
        ordenIndex: task.ordenIndex,
      );
}
