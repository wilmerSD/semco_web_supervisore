import "dart:async";
import "package:app_tasking/domain/entities/project.dart";
import "package:app_tasking/infrastructure/datasources/projectdb_datasource.dart";
import "package:app_tasking/infrastructure/models/option__select_model.dart";
import "package:app_tasking/infrastructure/models/project_model.dart";
import "package:app_tasking/core/helpers/custom_snackbar.dart";
import "package:app_tasking/core/helpers/helpers.dart";
import "package:app_tasking/core/routes/app_routes_name.dart";
import "package:app_tasking/infrastructure/repositories/project_repository_impl.dart";
import "package:flutter/material.dart";
import "package:flutter_secure_storage/flutter_secure_storage.dart";
import "package:go_router/go_router.dart";
import "package:intl/intl.dart";
import "package:intl/intl_standalone.dart";

class HomeProvider with ChangeNotifier {
  //Instance
  final FlutterSecureStorage secureStorage = const FlutterSecureStorage();
  final ProjectRepositoryImpl projectRepositoryImpl =
      ProjectRepositoryImpl(ProjectdbDatasource());

  //Variables
  late Timer timer;
  String _currentTime = '';
  var now = DateTime.now();
  bool isInitialized = false;
  var formatterDate = DateFormat('dd/MM/yy');
  var formatterTime = DateFormat('kk:mm');
  var monthName = DateFormat('MMMM', 'es');

  List<Project> listProyects = [];
  // DataProyects listProyectObject = DataProyects();

  int listType = 1;
  int indexToSend = 2;
  int menuSelected = 0;
  int optionProyect = 0;

  bool executeInNewView = true;
  bool searchOpened = false;
  bool hideLogoTasking = false;
  bool hideIconSearch = false;
  bool animatedOptions = false;
  bool animatedNavigator = false;
  bool isGettingProjects = false;
  bool isActiveDescription = false;
  bool isShowParticipants = false;
  bool showProjectInKanban = true;
  bool showProjectsInRow = true;

  String dayNumber = '';
  String dayName = '';
  String personalId = '';
  String priority = 'Alta';
  String searchProyectText = '';

  TextEditingController tittleProyect = TextEditingController(text: "");
  TextEditingController descriptionProyect = TextEditingController(text: "");
  TextEditingController endDateText = TextEditingController(
      text: Helpers.dateToStringTimeDMY(
          DateTime.now().add(const Duration(days: 15))));
  TextEditingController startDateText =
      TextEditingController(text: Helpers.dateToStringTimeDMY(DateTime.now()));

  Color? selectedColor;

  bool ishighPriority = false;
  void showIshighPriority() {
    ishighPriority = !ishighPriority;
    notifyListeners();
  }

  List<String> listPriority = ["Alta", "Baja"];
  final List<Color> colors = [
    Colors.blue,
    Colors.green,
    Colors.yellow,
    Colors.red,
    Colors.orange,
  ];

  List<OptionSelectModel> listTypeParticipation = [
    OptionSelectModel(id: '0', text: 'Todos'),
    OptionSelectModel(id: '1', text: 'Responsable'),
    OptionSelectModel(id: '2', text: 'Supervisor'),
    OptionSelectModel(id: '3', text: 'Participante'),
  ];
  OptionSelectModel typeParticipation =
      OptionSelectModel(id: '0', text: 'Todos');

  DateTime startDate = DateTime.now();
  DateTime endDate = DateTime.now();
  TextEditingController ctrlDateFilter =
      TextEditingController(text: Helpers.dateToStringTimeDMY(DateTime.now()));
  Future<void> onInit(BuildContext context) async {
    await getDataPersonal();
    print(personalId);
    getListProyects(context, personalId);
  }

  //Functions
  Future<void> getDataPersonal() async {
    // username = await secureStorage.read(key: 'kUserName') ?? "";
    // password = await secureStorage.read(key: 'kPassword') ?? "";
    personalId = await secureStorage.read(key: 'kIdUser') ?? '';
  }

  /* 📌 Obtener lista de proyectos*/
  Future<void> getListProyects(context,
      [String? pPersonalId,
      String? pCampanaId,
      String? pClienteId,
      String? pCompaniaId,
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
      await getDataPersonal();
      final response = await projectRepositoryImpl.getListProyects(ProjectModel(
          personalId: pPersonalId ?? personalId,
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
        CustomSnackbar.showSnackBarSuccess(context,
            title: "Validar!",
            message: "Ups! Ocurrió un error, no se pudo obtener el personal");
        return;
      }
      listProyects.addAll(response);
      // listProyectObject = response.data![0];
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
    }
  }

  /* 📌 Obtener fecha y hora */
  Future<String> getFormattedDate() async {
    formatterDate = DateFormat('dd/MM/yy');
    return formatterDate.format(now);
  }

  Future<void> initializeLocalization() async {
    await findSystemLocale(); // Esto carga la configuración local automáticamente
  }

  void showDescription() {
    isActiveDescription = !isActiveDescription;
    notifyListeners();
  }

  void showParticipants() {
    isShowParticipants = !isShowParticipants;
    notifyListeners();
  }

  void updatePriority(String? value) {
    priority = value ?? '';
    notifyListeners();
  }

  void updSearchProyect(String value) {
    searchProyectText = value;
    notifyListeners();
  }

  void updateselectedColor(color) {
    selectedColor = color;
    notifyListeners();
  }

  /* 📌 Función para globalizar las funciones iniciales*/
  void initialize(context) {
    if (isInitialized) return;
    isInitialized = true;
    getListProyects(context);
  }

  /* 📌 Selección de proyecto*/
  void selectOptionProyect(int pOptionProyect, BuildContext context) {
    optionProyect = pOptionProyect;
    switch (optionProyect) {
      case 0:
        // goToHome(context);
        break;
      case 1:
        // goToKaknban(context);
        break;
      case 2:
        // goToKanban(context);
        break;
    }
    notifyListeners();
  }

  /* 📌 Selección de opción de menu*/
  void selectMenu(int pMenuSelected, BuildContext context) {
    menuSelected = pMenuSelected;
    switch (pMenuSelected) {
      case 0:
        context.go(AppRoutesName.HOME);
        break;
      case 1:
        context.go(AppRoutesName.MEET);
        break;
      case 2:
        context.go(AppRoutesName.CHAT);
        // Navigator.pushNamed(context, AppRoutesName.CHAT);
        break;
      case 3:
        context.go(AppRoutesName.CHAT);
        // Navigator.pushNamed(context, AppRoutesName.CHAT);
        break;
      case 4:
        context.go(AppRoutesName.CHAT);
        break;
    }
    notifyListeners();
  }

  /* 📌 Animación del menu*/
  void animationMenu() {
    if (animatedNavigator) return;
    animatedNavigator = true;
    notifyListeners();
  }

  /* 📌 Animación de opciones (director, kanban, gantt)*/
  void animation() {
    if (animatedOptions) return;
    animatedOptions = true;
    notifyListeners();
  }

  /* 📌 Cambiar la vista de la lista*/
  void changeList(int listTypes) {
    listType = listTypes;
    notifyListeners();
  }

  /* 📌 Obtener indice del proyecto para obtener su id en la sgte vista */
  void getIndex(int index) {
    indexToSend = index;
    notifyListeners();
  }

  /* 📌 Abrir buscador */
  void openSearch() {
    searchOpened = true;
    notifyListeners();
  }

  void quitSearch() {
    searchOpened = false;
    notifyListeners();
  }

  /* 📌 Ordenamiento en orden alfabetico*/
  void orderByAlphabetically() {
    listProyects.sort(
      (Project a, Project b) {
        if (a.campanaNombre == null && b.campanaNombre == null) {
          return 0; // Ambos son nulos, considera como iguales
        } else if (a.campanaNombre == null) {
          return 1; // Coloca los nulos después
        } else if (b.campanaNombre == null) {
          return -1; // Coloca los nulos después
        }
        return a.campanaNombre!
            .toLowerCase()
            .compareTo(b.campanaNombre!.toLowerCase());
      },
    );
    notifyListeners();
  }

  /* 📌 Ordenamiento por prioridad*/
  void orderByPriority() {
    Map<String, int> prioridadMap = {
      "bajo": 1,
      "medio": 2,
      "alto": 3,
    };

    listProyects.sort((a, b) {
      int prioridadA = prioridadMap[a.campanaEstados?.toLowerCase()] ?? 0;
      int prioridadB = prioridadMap[b.campanaEstados?.toLowerCase()] ?? 0;
      return prioridadB.compareTo(prioridadA);
    });
    notifyListeners();
  }

  /* 📌 Ordenamiento fecha*/
  void orderByDate() {
    listProyects.sort((a, b) {
      if (a.campanaFechaInicio == null && b.campanaFechaInicio == null) {
        return 0;
      } else if (a.campanaFechaInicio == null) {
        return 1;
      } else if (b.campanaFechaInicio == null) {
        return -1;
      }
      return a.campanaFechaInicio!.compareTo(b.campanaFechaInicio!);
    });
    notifyListeners();
  }

  /* 📌 Ordenamiento por porcentaje*/
  void orderByPercentage() {
    listProyects.sort((a, b) {
      if (a.campanaAvance == null && b.campanaAvance == null) {
        return 0;
      } else if (a.campanaAvance == null) {
        return 1;
      } else if (b.campanaAvance == null) {
        return -1;
      }
      return a.campanaAvance!.compareTo(b.campanaAvance!);
    });
    notifyListeners();
  }

  /* 📌 Obtenre días restantes*/
  String getDaysRemaining(String endDate, String startDate) {
    if (endDate.isEmpty || startDate.isEmpty) return '';
    DateTime endDatee = DateTime.parse(endDate);
    DateTime startDatee = DateTime.parse(startDate);

    Duration difference = endDatee.difference(startDatee);
    int daysDifference = difference.inDays;
    return daysDifference.toString();
  }

  /* 📌 Obtener fehca de fin formateado ejm: 30/Jun*/
  String getEndDateFormatted(String dateStr) {
    if (dateStr.isEmpty) return '';
    DateTime date = DateTime.parse(dateStr);
    String endDateFormatted = DateFormat('dd/MMM').format(date);
    return endDateFormatted;
  }

  /* 📌 Porcentaje formateado*/
  String percentageFormatted(String value) {
    double number = double.tryParse(value) ?? 0.0;
    return number.round().toString();
  }

  /* 📌 Obtiene la hora formateada */
  String get currentTime => _currentTime;

  /* 📌 Función para obtener la hora actual */
  String _getCurrentTime() {
    return DateFormat('HH:mm:ss').format(DateTime.now());
  }

  String getMontName() {
    return monthName.format(now);
  }

  String getDayNumber() {
    dayNumber = DateFormat('d').format(now); // Ejemplo: "21"
    return dayNumber;
  }

  String getDayName() {
    dayName = DateFormat('EEEE', 'es').format(now); // Ejemplo: "martes"
    return dayName;
  }

  /* 📌 Obtener el tiempo*/
  void timeProvider() {
    _currentTime = _getCurrentTime();
    _startTimer();
  }

  /* 📌 Inicia el temporizador y actualiza la hora cada segundo */
  void _startTimer() {
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      _currentTime = _getCurrentTime();
      notifyListeners(); // Notifica a los listeners para que se reconstruyan
    });
  }

  void goToNewTask(BuildContext context) {
    Navigator.pushNamed(context, AppRoutesName.NEWTASK);
  }

  void goToNewProyect(BuildContext context) {
    Navigator.pushNamed(context, AppRoutesName.NEWPROYECT);
  }

  void goToNewMeet(BuildContext context) {
    Navigator.pushNamed(context, AppRoutesName.NEWMEET);
  }

  void updateOptionOfProyectShow() {
    showProjectInKanban = !showProjectInKanban;
    notifyListeners();
  }

  void goToMeet(BuildContext context) {
    Navigator.pushNamedAndRemoveUntil(
        context, AppRoutesName.MEET, (Route<dynamic> route) => false);
  }

  void showOrHideProjectsRow() {
    showProjectsInRow = !showProjectsInRow;
    notifyListeners();
  }
}
