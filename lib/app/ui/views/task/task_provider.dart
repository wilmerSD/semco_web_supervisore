import 'package:app_tasking/domain/entities/checklist.dart';
import 'package:app_tasking/domain/entities/note.dart';
import 'package:app_tasking/domain/entities/project.dart';
import 'package:app_tasking/domain/entities/task.dart';
import 'package:app_tasking/infrastructure/datasources/checklistdb_datasource.dart';
import 'package:app_tasking/infrastructure/datasources/notedb_datasource.dart';
import 'package:app_tasking/infrastructure/datasources/taskdb_datasource.dart';
import 'package:app_tasking/infrastructure/models/request/request_list_task_model.dart';
import 'package:app_tasking/infrastructure/models/request/request_new_note_model.dart';
import 'package:app_tasking/core/helpers/helpers.dart';
import 'package:app_tasking/infrastructure/repositories/checklist_repository_impl.dart';
import 'package:app_tasking/infrastructure/repositories/note_repository_impl.dart';
import 'package:app_tasking/infrastructure/repositories/task_repository_impl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class TaskProvider with ChangeNotifier {
// INSTANCIAS
  final secureStorage = const FlutterSecureStorage();
  final TaskRepositoryImpl taskRepositoryImpl =
      TaskRepositoryImpl(TaskdbDatasource());
  final NoteRepositoryImpl noteRepositoryImpl =
      NoteRepositoryImpl(NotedbDatasource());
  final ChecklistRepositoryImpl checklistRepositoryImpl =
      ChecklistRepositoryImpl(ChecklistdbDatasource());
  // VARIABLES
  Task taskObject = Task();
  Project proyectObject = Project();
  List<Task> listSubtask = [];
  List<Note> listNotes = [];
  List<Checklist> checkListTask = [];

  bool isGetListNotes = false;
  bool sendEmail = false;
  bool sendEmailReport = false;
  bool isRevisionReport = false;
  bool isGetListSubtask = false;
  bool isCreatingNote = false;
  bool isVisibleTask = true;
  bool isVisibleNotes = false;
  bool isGettingCheckTask = false;
  bool isShowCheckList = false;
  bool isShowHeaderTask = true;

  TextEditingController ctrlCommentText = TextEditingController(text: '');
  TextEditingController ctrlNoteText = TextEditingController(text: '');
  TextEditingController ctrlReportText = TextEditingController(text: '');
  TextEditingController dateOfControlText =
      TextEditingController(text: Helpers.dateToStringTimeDMY(DateTime.now()));
  TextEditingController ctrlTimeReportText =
      TextEditingController(text: '00:00');
  TextEditingController dateOfDeliveryEvalText =
      TextEditingController(text: Helpers.dateToStringTimeDMY(DateTime.now()));
  TextEditingController dateOfRevisionEvalText =
      TextEditingController(text: Helpers.dateToStringTimeDMY(DateTime.now()));
  TextEditingController ctrlRecomendacionText = TextEditingController(text: '');
  TextEditingController ctrlNotePrivEvaluText = TextEditingController(text: '');
  Duration durationOfWork = const Duration(minutes: 30);
  DateTime timeOfWork = DateTime.now();
  String subTaskId = '';
  String clienteId = '';
  String companiaId = '';
  String personalId = '';
  String stateReport = 'Asignado';
  String typeNoteSelected = 'Privado';
  String qualityOfWork = 'Esperado';
  String workInTeam = 'Esperado';
  String independenceResults = 'Esperado';

  int optionTypeNote = 0;
  double advanceReport = 0.0;

  DateTime dateClose = DateTime.now();
  DateTime dateOfControl = DateTime.now();
  DateTime dateOfDeliveryEval = DateTime.now();
  DateTime dateOfRevisionEval = DateTime.now();

  List<String> listStates = <String>[
    'Asignado',
    'En Trabajo',
    'Pausado/Postergado',
    'En Revisión',
    'Aprobado',
    'Terminado',
    'Cancelado/Anulado'
  ];
  List<String> listWorkInTeam = <String>[
    'Deficiente',
    'Insuficiente',
    'Esperado',
    'Mas de lo esperado',
    'Sobresaliente',
  ];
  List<String> listTypeNote = <String>[
    'Privado',
    'Publico',
  ];
  List<String> listQualityOfWork = <String>[
    'Deficiente',
    'Insuficiente',
    'Esperado',
    'Mas de lo esperado',
    'Sobresaliente',
  ];

  List<String> listIndependenceResults = <String>[
    'Deficiente',
    'Insuficiente',
    'Esperado',
    'Mas de lo esperado',
    'Sobresaliente',
  ];

  // FUNCIONES
  Future<void> getDataPersonal() async {
    // username = await secureStorage.read(key: 'kUserName') ?? "";
    // password = await secureStorage.read(key: 'kPassword') ?? "";
    personalId = await secureStorage.read(key: 'kIdUser') ?? '';
  }

  Future<void> getListSubTask(
      [String? pPersonalId,
      String? pTaskId,
      String? pCampanaId,
      String? pClienteId,
      String? pCompaniaId,
      String? pSubtaskId]) async {
    isGetListSubtask = true;
    listSubtask = [];
    try {
      final response =
          await taskRepositoryImpl.getListTaskByProject(RequestListTaskModel(
        campanaId: pCampanaId,
        pPersonalId: pPersonalId ?? '',
        taskId: pTaskId ?? '',
        clienteId: pClienteId ?? "",
        companiaId: pCompaniaId ?? "",
        // subTaskId: pSubtaskId ?? "",
      ));
      if (response.isEmpty) {
        return;
      }
      listSubtask.addAll(response);
    } catch (e) {
      print("Ocurrio un error${e}");
    } finally {
      isGetListSubtask = false;
      notifyListeners();
    }
  }

  Future<void> getListNotes([String? pTaskId]) async {
    isGetListNotes = true;
    listNotes = [];
    try {
      final response =
          await noteRepositoryImpl.getListNotes(pTaskId ?? "", '', '');
      if (response.isEmpty) {
        return;
      }

      listNotes.addAll(response);
    } catch (e) {
      debugPrint("Ocurrio un error$e");
    } finally {
      isGetListNotes = false;
      notifyListeners();
    }
  }

  Future<void> postProcCreateNote(
      {int? pHora,
      int? pMinuto,
      String? pComeComentario,
      String? privateOrPublicNote,
      bool? pSendEmail,
      String? pDateOfControl,
      String? pCambioEstado,
      bool? pRevizar,
      int? pOpAvance,
      String? pDateClose,
      String? pDateOfReview,
      String? pPrivateNote,
      String? pRecommendation,
      String? pQualityOfWork,
      String? pWorkInTeam,
      String? pIndependenceResult}) async {
    isCreatingNote = true;
    notifyListeners();
    try {
      await getDataPersonal();
      final response =
          await noteRepositoryImpl.postProcCreateNote(RequestNewNoteModel(
        pComeOrden: subTaskId,
        pComeClienteId: clienteId,
        pComeCompaniaId: companiaId,
        pComePersonalId: personalId,
        pHora: 0,
        pMinuto: 0,
        pComeTipoComentario: optionTypeNote,
        pComeComentario: pComeComentario ?? '',
        pSendEmail: pSendEmail ?? false,
        pComeOtros2:
            privateOrPublicNote ?? '', //Para la nota si es privado o publico
        pDateOfControl: pDateOfControl ?? '',
        pCambioEstado: pCambioEstado ?? '',
        pRevizar: pRevizar ?? false,
        pOpAvance: pOpAvance ?? 0,
        pDateClose: pDateClose ?? '',
        pDateOfReview: pDateOfReview ?? '',
        pPrivateNote: pPrivateNote ?? '',
        pRecommendation: pRecommendation ?? '',
        pQualityOfWork: pQualityOfWork ?? '',
        pWorkInTeam: pWorkInTeam ?? '',
        pIndependenceResult: pIndependenceResult ?? '',
      ));
      if (response != null) {
        getListNotes(taskObject.ordenProduccionId);
      }
    } catch (e) {
      print(e);
    } finally {
      isCreatingNote = false;
    }
  }

  Future<void> getCheckList(String pTaskId, String pCampanaId,
      String pClienteId, String pCompaniaId) async {
    isGettingCheckTask = true;
    checkListTask = [];

    notifyListeners();
    try {
      final response = await checklistRepositoryImpl.getChecklist(
          taskid: pTaskId,
          campanaId: pCampanaId,
          clienteId: pClienteId,
          companiaId: pCompaniaId);
      if (response.isEmpty) return;
      checkListTask.addAll(response);
    } catch (e) {
    } finally {
      isGettingCheckTask = false;
      notifyListeners();
    }
  }

  void getCustomData(String subTaskId, String clienteId, String companiaId) {
    this.subTaskId = subTaskId;
    this.clienteId = clienteId;
    this.companiaId = companiaId;
  }

  void selectTypeNote(int pOptionTypeNote, BuildContext context) {
    optionTypeNote = pOptionTypeNote;
    switch (optionTypeNote) {
      case 0:
        // goToHome(context);
        break;
      case 1:
        // goToKaknban(context);
        break;
      case 2:
      // goToKanban(context);
      case 4:
        // goToKanban(context);
        break;
    }
    notifyListeners();
  }

  void updateQualityOfWork(String? pQualityOfWork) {
    qualityOfWork = pQualityOfWork ?? '';
    notifyListeners();
  }

  void updateWorkInTeam(String? pWorkInTeam) {
    workInTeam = pWorkInTeam ?? '';
    notifyListeners();
  }

  void updateIndependenceResults(String? pIndependenceResults) {
    independenceResults = pIndependenceResults ?? '';
    notifyListeners();
  }

  void checkSendEmail() {
    sendEmail = !sendEmail;
    notifyListeners();
  }

  void checkSendEmailReport() {
    sendEmailReport = !sendEmailReport;
    notifyListeners();
  }

  void checkIsRevisionReport() {
    isRevisionReport = !isRevisionReport;
    notifyListeners();
  }

  void updateStateReportState(String? value) {
    stateReport = value ?? '';
    notifyListeners();
  }

  void updateAdvanceReport(double pAdvanceReport) {
    advanceReport = pAdvanceReport;
    notifyListeners();
  }

  void updateTypeNoteSelected(String? value) {
    typeNoteSelected = value ?? '';
    notifyListeners();
  }

  void visibleTask() {
    isVisibleTask = !isVisibleTask;
    notifyListeners();
  }

  void visibleNotes() {
    isVisibleNotes = !isVisibleNotes;
    notifyListeners();
  }

  void visibleCheckList() {
    isShowCheckList = !isShowCheckList;
    notifyListeners();
  }

  void visibleHeader() {
    isShowHeaderTask = !isShowHeaderTask;
    notifyListeners();
  }
}
