import 'package:app_tasking/domain/entities/project.dart';
import 'package:app_tasking/domain/entities/task.dart';
import 'package:app_tasking/infrastructure/datasources/projectdb_datasource.dart';
import 'package:app_tasking/infrastructure/datasources/taskdb_datasource.dart';
import 'package:app_tasking/infrastructure/mappers/task_mapper.dart';
import 'package:app_tasking/infrastructure/models/project_model.dart';
import 'package:app_tasking/infrastructure/models/request/request_list_sutask_model.dart';
import 'package:app_tasking/infrastructure/models/request/request_update_index_model.dart';
import 'package:app_tasking/infrastructure/models/request/request_update_state_kanban.dart';
import 'package:app_tasking/core/helpers/custom_snackbar.dart';
import 'package:app_tasking/infrastructure/repositories/project_repository_impl.dart';
import 'package:app_tasking/infrastructure/repositories/task_repository_impl.dart';
import 'package:flutter/material.dart';

class KanbanProvider with ChangeNotifier {
  //INSTANCIAS
  final ProjectRepositoryImpl projectRepositoryImpl =
      ProjectRepositoryImpl(ProjectdbDatasource());
  final TaskRepositoryImpl taskRepositoryImpl =
      TaskRepositoryImpl(TaskdbDatasource());
  //VARIABLES
  bool isHoveredToDo = false;
  bool isHoveredInWork = false;
  bool isHoveredInReview = false;
  bool isHoveredFinished = false;
  bool isSelected = false;
  bool isGettingSubTask = false;
  bool isGettingProjects = false;

  Project proyectObject = Project();
  List<Project> listProyects = [];

  List<Task> listTaskAndSubTask = [];
  List<Task> subTaskToDo = [];
  List<Task> subTaskFinished = [];
  List<Task> subTaskInWork = [];
  List<Task> subTaskInRevision = [];

  String campanaId = '';
  String clienteId = '';
  String companiaId = '';
  String personalId = '';

  int menuSelected = 0;
  int animationOptionsKanbn = 0;
  bool isGettingListOfTask = false;

  //FUNCTIONS
  void selectMenu(int pMenuSelected) {
    menuSelected = pMenuSelected;
    notifyListeners();
  }

  void animationOptionskanban(int num) {
    if (animationOptionsKanbn != 0) return;
    animationOptionsKanbn = num;
    notifyListeners();
  }

  void onHoverToDo(bool pIsHovered) {
    isHoveredToDo = pIsHovered;
    notifyListeners();
  }

  void onHoverInWork(bool pIsHovered) {
    isHoveredInWork = pIsHovered;
    notifyListeners();
  }

  void onHoverInReview(bool pIsHovered) {
    isHoveredInReview = pIsHovered;
    notifyListeners();
  }

  void onHoverFinished(bool pIsHovered) {
    isHoveredFinished = pIsHovered;
    notifyListeners();
  }

  ////////////////
  void selectedToDo(bool pIsHovered) {
    isHoveredToDo = pIsHovered;
    notifyListeners();
  }

  void selectedInWork(bool pIsHovered) {
    isHoveredInWork = pIsHovered;
    notifyListeners();
  }

  void selectedInReview(bool pIsHovered) {
    isHoveredInReview = pIsHovered;
    notifyListeners();
  }

  void selectedFinished(bool pIsHovered) {
    isHoveredFinished = pIsHovered;
    notifyListeners();
  }

  int indexKanban = 0;
  void proyectSelected(index) {
    indexKanban = index;
    notifyListeners();
  }

  void getCustomData(String pCampanaId, String pClienteId, String pCompaniaId) {
    campanaId = pCampanaId;
    clienteId = pClienteId;
    companiaId = pCompaniaId;
  }

  Future<void> onInit(
    BuildContext context,
    String token,
    String pPersonalId,
    String pCompaniaId,
    String pCampanaId,
    String pClienteId,
    String pState,
    String pBuscar,
    int pIntervener,
    String pEndDate,
  ) async {
    if (token.isEmpty || token == 'null') {
      CustomSnackbar.showSnackBarSuccess(context,
          title: "Validar!",
          message: "Su sesión ha caducado, por favor inicie sesión nuevamente");
      return;
    } else {
      getListOfTask(context, proyectObject, pCampanaId, pClienteId, pCompaniaId,
          pIntervener, pEndDate);
    }

    /*   await getListProyects(context, pPersonalId, pCompaniaId, '', pClienteId, '',
        '', 0, pState, '', pBuscar);
    if (listProyects.isNotEmpty) {
      proyectObject = listProyects[0];
      getListOfTask(
          context, proyectObject, pCampanaId, pClienteId, pCompaniaId);
    } */
  }

  Future<void> getListOfTask(
    BuildContext context,
    Project pListProyectObject,
    String pCampanaId,
    String pClienteId,
    String pCompaniaId,
    int pIntervener,
    String pEndDate,
  ) async {
    proyectObject = pListProyectObject;
    listTaskAndSubTask = [];
    isGettingListOfTask = true;
    subTaskToDo = [];
    subTaskInWork = [];
    subTaskInRevision = [];
    subTaskFinished = [];
    notifyListeners();
    try {
      /* final response =
          await taskRepositoryImpl.getListSubTaskByProject(RequestListSubtaskModel(
        pPersonalId: personalId,
        taskid: '',
        companaId: pCampanaId,
        clienteId: pClienteId,
        companiaId: pCompaniaId,
        iIntervener: pIntervener,
        iEndDate: pEndDate,
      )); */
      final response = await taskRepositoryImpl
          .getListSubTaskByProject(RequestListSubtaskModel(
        pPersonalId: personalId,
        taskid: '',
        companaId: pCampanaId,
        clienteId: pClienteId,
        companiaId: pCompaniaId,
        iIntervener: pIntervener,
        iEndDate: pEndDate,
      ));
      if (response.isEmpty) {
        return;
      }
      listTaskAndSubTask.addAll(response);
      subTaskToDo = listTaskAndSubTask
          .where((subTask) =>
              subTask.ordenCampo3 == '' || subTask.ordenCampo3 == '2')
          .toList();
      subTaskInWork = listTaskAndSubTask
          .where((subTask) => subTask.ordenCampo3 == '3')
          .toList();
      subTaskInRevision = listTaskAndSubTask
          .where((subTask) => subTask.ordenCampo3 == '4')
          .toList();
      subTaskFinished = listTaskAndSubTask
          .where((subTask) => subTask.ordenCampo3 == '5')
          .toList();

      subTaskToDo
          .sort((a, b) => (a.ordenIndex ?? 0).compareTo(b.ordenIndex ?? 0));
      subTaskInWork
          .sort((a, b) => (a.ordenIndex ?? 0).compareTo(b.ordenIndex ?? 0));
      subTaskInRevision
          .sort((a, b) => (a.ordenIndex ?? 0).compareTo(b.ordenIndex ?? 0));
      subTaskFinished
          .sort((a, b) => (a.ordenIndex ?? 0).compareTo(b.ordenIndex ?? 0));
      // print(subTaskToDo[0].ordenProduccionId);
      // final tareasEnTrabajo = listTaskAndSubTask.where((tarea) => tarea.ordenProEstado == 'En Trabajo').toList();
    } catch (e) {
    } finally {
      /* isGettingListOfTask = false;
         notifyListeners(); */
      Future.delayed(const Duration(milliseconds: 100), () {
        isGettingListOfTask = false;
        notifyListeners();
      });
    }
  }

  // Función para eliminar la tarea de la lista correspondiente
  void removeTask(Task task, String fromList) {
    if (fromList == 'toDo') {
      subTaskToDo.remove(task);
    } else if (fromList == 'inWork') {
      subTaskInWork.remove(task);
    } else if (fromList == 'underReview') {
      subTaskInRevision.remove(task);
    } else if (fromList == 'finished') {
      subTaskFinished.remove(task);
    }
    notifyListeners(); // Notifica a los escuchadores para actualizar el estado
  }

  String mapListNameToDatabaseStatus(String listName) {
    switch (listName) {
      case 'toDo':
        return '2';
      case 'inWork':
        return '3';
      case 'underReview':
        return '4';
      case 'finished':
        return '5';
      default:
        return 'DESCONOCIDO';
    }
  }

  Future<void> updateStateKanban(Task task, String newStatus) async {
    try {
      String dbStatus = mapListNameToDatabaseStatus(newStatus);
      task.ordenProEstado = dbStatus;
      task.ordenProduccionId;

      final response =
          await taskRepositoryImpl.updateStateSubTask(RequestUpdateStateKanban(
        pCampanaId: task.campanaId ?? '', //proyectObject.campanaid ?? '',
        pClienteId: task.clienteId ?? '', //proyectObject.clienteid ?? '',
        pCompaniaId: task.companiaId ?? '', // proyectObject.companiaid ?? '',
        pState: dbStatus,
        pOrdenProduccionId: task.ordenProduccionId,
      ));
      if (response) {
        return;
      }
    } catch (e) {
      print(e);
    } finally {
      // notifyListeners();
    }
  }

  Future<void> updateIndexTaskSubTask(
    List<Task> iListTaskAndSubTask,
  ) async {
    if (iListTaskAndSubTask.isEmpty) return;

    // Valores base
    final firstTask = iListTaskAndSubTask.first;
    final taskBaseProject = firstTask.campanaId ?? '';
    final taskBaseCompania = firstTask.companiaId ?? '';
    final taskBaseClient = firstTask.clienteId ?? '';

    // Validación de coincidencia de proyecto, compañía y cliente
    final isSameProject =
        iListTaskAndSubTask.every((task) => task.campanaId == taskBaseProject);
    final isSameCompania = iListTaskAndSubTask
        .every((task) => task.companiaId == taskBaseCompania);
    final isSameClient =
        iListTaskAndSubTask.every((task) => task.clienteId == taskBaseClient);

    if (!isSameProject || !isSameCompania || !isSameClient) {
      debugPrint(
          '❌ No se actualiza el orden porque hay tareas de distintos proyectos.');
      return;
    }
    // Actualiza el orden según la posición en la lista
    for (int i = 0; i < iListTaskAndSubTask.length; i++) {
      iListTaskAndSubTask[i].ordenIndex = i;
    }

    try {
      final sdtListTaskIndex = iListTaskAndSubTask
          .map((element) => TaskMapper.taskToTaskModel(element))
          .toList();
      final response = taskRepositoryImpl.updateIndexTaskSubTask(
          RequestUpdateIndexModel(
              iCampanaId: iListTaskAndSubTask.first.campanaId ?? '',
              iCompaniaId: iListTaskAndSubTask.first.companiaId ?? '',
              iClienteId: iListTaskAndSubTask.first.clienteId ?? '',
              iSdtListTaskIndex: sdtListTaskIndex));
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      // notifyListeners();
    }
  }

  String responseWhenNoProject = '';
  /* 📌 Obtener lista de proyectos*/
  Future<void> getListProyects(context,
      [String? pPersonalId,
      String? pCompaniaId,
      String? pCampanaId,
      String? pClienteId,
      String? pSupervisorId,
      String? pResponsable,
      int? pAnio,
      String? pEstado,
      String? pFechaFin,
      String? pBuscar]) async {
    isGettingProjects = true;
    listProyects = [];
    notifyListeners();
    try {
      final response = await projectRepositoryImpl.getListProyects(ProjectModel(
          personalId: pPersonalId ?? '',
          campanaId: pCampanaId ?? '',
          clienteId: pClienteId ?? "", //CLI0004
          companiaId: pCompaniaId ?? "CM001",
          supervisorId: pSupervisorId ?? "",
          responsableNombre: pResponsable ?? "",
          anio: pAnio ?? 0,
          estado: pEstado ?? "",
          campanaFechaFin: pFechaFin ?? '',
          search: pBuscar ?? ""));
      if (response.isEmpty) {
        responseWhenNoProject =
            'No hay proyectos que conicidan con el filtro de busqueda';
        notifyListeners();
        /* CustomSnackbar.showSnackBarSuccess(context,
            title: "Validar!",
            message: "Ups! Ocurrió un error, ${response.statusMessage}"); */

        return;
      }
      listProyects.addAll(response);
      notifyListeners();
    } catch (e) {
      CustomSnackbar.showSnackBarSuccess(
        context,
        title: "Validar!",
        message:
            "Ups! Ocurrió un error inesperado, intente nuevamente${e.toString()}",
      );
    } finally {
      isGettingProjects = false;
      notifyListeners();
      responseWhenNoProject = '';
    }
  }
}
