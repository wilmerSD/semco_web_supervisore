import 'package:app_tasking/domain/entities/note.dart';
import 'package:app_tasking/domain/entities/project.dart';
import 'package:app_tasking/domain/entities/task.dart';
import 'package:app_tasking/infrastructure/datasources/notedb_datasource.dart';
import 'package:app_tasking/infrastructure/datasources/projectdb_datasource.dart';
import 'package:app_tasking/infrastructure/datasources/taskdb_datasource.dart';
import 'package:app_tasking/infrastructure/models/request/request_list_task_model.dart';
import 'package:app_tasking/infrastructure/models/request/request_new_note_model.dart';
import 'package:app_tasking/core/helpers/helpers.dart';
import 'package:app_tasking/infrastructure/repositories/note_repository_impl.dart';
import 'package:app_tasking/infrastructure/repositories/project_repository_impl.dart';
import 'package:app_tasking/infrastructure/repositories/task_repository_impl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class ProjectProvider with ChangeNotifier {
  //INSTANCIAS
  final ProjectRepositoryImpl projectRepositoryImpl =
      ProjectRepositoryImpl(ProjectdbDatasource());
  final TaskRepositoryImpl taskRepositoryImpl =
      TaskRepositoryImpl(TaskdbDatasource());
  final NoteRepositoryImpl noteRepositoryImpl =
      NoteRepositoryImpl(NotedbDatasource());
  final secureStorage = const FlutterSecureStorage();

//VARIABLES
  Project listProyectObject = Project();
  Task taskObject = Task();
  List<Task> listTask = [];
  List<Note> listNotesTask = [];

  bool isInitialized = false;
  bool execute = false;
  bool isLoading = false;
  bool sendEmail = false;
  bool sendEmailReport = false;
  bool isRevisionReport = false;
  bool isGetListSubtask = false;
  bool isVisibleNotes = false;
  bool isVisibleTask = true;
  bool animate = false;
  bool isShowParticipants = false;
  bool isGetListNotes = false;
  bool isCreatingNote = false;
  bool ishighPriority = false;
  bool isActiveDescription = false;
  bool isShowHeaderProject = true;
  bool isGettingCheckListProject = false;

  int indexProyect = 0;
  int optionTypeNote = 0;

  double advanceReport = 0.0;

  DateTime startDate = DateTime.now();
  DateTime endDate = DateTime.now();
  DateTime timeOfWork = DateTime.now();
  DateTime dateOfDeliveryEval = DateTime.now();
  Duration durationOfWork = const Duration(minutes: 30);

  DateTime dateOfControl = DateTime.now();

  TextEditingController startDateText =
      TextEditingController(text: Helpers.dateToStringTimeDMY(DateTime.now()));

  TextEditingController endDateText =
      TextEditingController(text: Helpers.dateToStringTimeDMY(DateTime.now()));
  TextEditingController ctrlCommentText = TextEditingController(text: "");
  TextEditingController ctrlNoteText = TextEditingController(text: "");
  TextEditingController dateOfControlText =
      TextEditingController(text: Helpers.dateToStringTimeDMY(DateTime.now()));
  TextEditingController ctrlReportText = TextEditingController(text: '');
  TextEditingController ctrlTimeReportText =
      TextEditingController(text: '00:00');
  TextEditingController ctrlRecomendacionText = TextEditingController(text: '');
  TextEditingController ctrlNotePrivEvaluText = TextEditingController(text: '');
  TextEditingController dateOfRevisionEvalText =
      TextEditingController(text: Helpers.dateToStringTimeDMY(DateTime.now()));
  DateTime dateOfRevisionEval = DateTime.now();
  TextEditingController dateOfDeliveryEvalText =
      TextEditingController(text: Helpers.dateToStringTimeDMY(DateTime.now()));

  String stateReport = 'Asignado';
  String campanaId = '';
  String clienteId = '';
  String companiaId = '';
  String priority = "Alta";
  String personalId = '';
  String typeNoteSelected = 'Privado';
  String independenceResults = 'Esperado';
  String workInTeam = 'Esperado';
  String qualityOfWork = 'Esperado';

  List<String> listTypeNote = <String>[
    'Privado',
    'Publico',
  ];
  List<String> listStates = <String>[
    'Asignado',
    'En Trabajo',
    'Pausado/Postergado',
    'En Revisión',
    'Aprobado',
    'Terminado',
    'Cancelado/Anulado'
  ];
  List<String> listQualityOfWork = <String>[
    'Deficiente',
    'Insuficiente',
    'Esperado',
    'Mas de lo esperado',
    'Sobresaliente',
  ];
  List<String> listWorkInTeam = <String>[
    'Deficiente',
    'Insuficiente',
    'Esperado',
    'Mas de lo esperado',
    'Sobresaliente',
  ];
  List<String> listPriority = ["Alta", "Baja"];

  void checkSendEmailReport() {
    sendEmailReport = !sendEmailReport;
    notifyListeners();
  }

  void checkIsRevisionReport() {
    isRevisionReport = !isRevisionReport;
    notifyListeners();
  }

  void updateAdvanceReport(double pAdvanceReport) {
    advanceReport = pAdvanceReport;
    notifyListeners();
  }

  void updateStateReportState(String? value) {
    stateReport = value ?? '';
    notifyListeners();
  }

//FUNCIONES
  void onInit() {
    if (isInitialized) return;
    isInitialized = true;
  }

  void updateTypeNoteSelected(String? value) {
    typeNoteSelected = value ?? '';
    notifyListeners();
  }

  Future<void> getDataPersonal() async {
    // username = await secureStorage.read(key: 'kUserName') ?? "";
    // password = await secureStorage.read(key: 'kPassword') ?? "";
    personalId = await secureStorage.read(key: 'kIdUser') ?? '';
  }

  void checkSendEmail() {
    sendEmail = !sendEmail;
    notifyListeners();
  }

  Future<void> getListNotes(
      String? pCampanaid, String? pClienteid, String? pCompaniaid) async {
    campanaId = pCampanaid ?? '';
    clienteId = pClienteid ?? '';
    companiaId = pCompaniaid ?? '';
    isGetListNotes = true;
    listNotesTask = [];
    try {
      final response = await noteRepositoryImpl.getListNotes(
        pCampanaid,
        clienteId,
        companiaId,
      );
      if (response.isEmpty) {
        return;
      }
      listNotesTask.addAll(response);
    } catch (e) {
      debugPrint("Ocurrio un error${e}");
    } finally {
      isGetListNotes = false;
      notifyListeners();
    }
  }

  Future<void> getListOfTask(
    BuildContext context,
    Project pListProyectObject, [
    String? pPersonalId,
    String? pCampanaId,
    String? pClienteId,
    String? pCompaniaId,
    String? pTaskId,
  ]) async {
    listProyectObject = pListProyectObject;
    listTask = [];
    animate = true;
    try {
      isLoading = true;
      final response =
          await taskRepositoryImpl.getListTaskByProject(RequestListTaskModel(
        pPersonalId: pPersonalId ?? '',
        campanaId:
            listProyectObject.campanaid, //pCampanaId ?? '', //CM2023-00001
        clienteId: pClienteId ?? '', //"CLI0004",
        companiaId: pCompaniaId ?? '', //"CM001",
        taskId: pTaskId ?? '',
      ));
      if (response.isEmpty) {
        return;
      }
      listTask.addAll(response);
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      isLoading = false;
      animate = false;
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
        pComeOrden:
            campanaId, //aqui se envia el id de campana porque la nota sera creada desde el proeycto
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
        getListNotes(campanaId, clienteId, companiaId);
      }
    } catch (e) {
      print(e);
    } finally {
      isCreatingNote = false;
    }
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

  void visibleTask() {
    isVisibleTask = !isVisibleTask;
    notifyListeners();
  }

  void visibleNotes() {
    isVisibleNotes = !isVisibleNotes;
    notifyListeners();
  }

  void updatePriority(String? value) {
    priority = value ?? '';
  }

  void showIshighPriority() {
    ishighPriority = !ishighPriority;
    notifyListeners();
  }

  void showDescription() {
    isActiveDescription = !isActiveDescription;
    notifyListeners();
  }

  void showParticipants() {
    isShowParticipants = !isShowParticipants;
    notifyListeners();
  }

  void updateIndependenceResults(String? pIndependenceResults) {
    independenceResults = pIndependenceResults ?? '';
    notifyListeners();
  }

  void updateWorkInTeam(String? pWorkInTeam) {
    workInTeam = pWorkInTeam ?? '';
    notifyListeners();
  }

  void updateQualityOfWork(String? pQualityOfWork) {
    qualityOfWork = pQualityOfWork ?? '';
    notifyListeners();
  }

  void switchShowHeaderProject() {
    isShowHeaderProject = !isShowHeaderProject;
    notifyListeners();
  }
}
