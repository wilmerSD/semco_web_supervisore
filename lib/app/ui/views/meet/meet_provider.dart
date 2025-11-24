import "package:app_tasking/app/ui/components/toast/toast.dart";
import "package:app_tasking/core/helpers/helpers.dart";
import "package:app_tasking/core/helpers/keys.dart";
import "package:app_tasking/domain/entities/agenda.dart";
import "package:app_tasking/domain/entities/agreement.dart";
import "package:app_tasking/domain/entities/area.dart";
import "package:app_tasking/domain/entities/meet.dart";
import "package:app_tasking/domain/entities/participant.dart";
import "package:app_tasking/domain/entities/person.dart";
import "package:app_tasking/domain/entities/project.dart";
import "package:app_tasking/domain/entities/task.dart";
import "package:app_tasking/infrastructure/datasources/agendadb_datasource.dart";
import "package:app_tasking/infrastructure/datasources/agreementdb_datasource.dart";
import "package:app_tasking/infrastructure/datasources/areadb_datasource.dart";
import "package:app_tasking/infrastructure/datasources/meetdb_datasource.dart";
import "package:app_tasking/infrastructure/datasources/persondb_datasource.dart";
import "package:app_tasking/infrastructure/datasources/projectdb_datasource.dart";
import "package:app_tasking/infrastructure/datasources/taskdb_datasource.dart";
import "package:app_tasking/infrastructure/models/agenda_model.dart";
import "package:app_tasking/infrastructure/models/meet_model.dart";
import "package:app_tasking/infrastructure/models/option__select_model.dart";
import "package:app_tasking/infrastructure/models/project_model.dart";
import "package:app_tasking/infrastructure/models/request/request_list_task_model.dart";
import "package:app_tasking/infrastructure/repositories/agenda_repository_impl.dart";
import "package:app_tasking/infrastructure/repositories/agreement_repository_impl.dart";
import "package:app_tasking/infrastructure/repositories/area_repository_impl.dart";
import "package:app_tasking/infrastructure/repositories/meet_repository_impl.dart";
import "package:app_tasking/infrastructure/repositories/person_repository_impl.dart";
import "package:app_tasking/infrastructure/repositories/project_repository_impl.dart";
import "package:app_tasking/infrastructure/repositories/task_repository_impl.dart";
import "package:flutter/material.dart";
import "package:flutter_secure_storage/flutter_secure_storage.dart";
import "package:intl/intl.dart";

class MeetProvider with ChangeNotifier {
  //INSTANCES
  final PersonRepositoryImpl personRepositoryImpl =
      PersonRepositoryImpl(PersondbDatasource());
  final FlutterSecureStorage secureStorage = const FlutterSecureStorage();
  final MeetRepositoryImpl meetRepositoryImpl =
      MeetRepositoryImpl(MeetdbDatasource());
  final AreaRepositoryImpl areaRepositoryImpl =
      AreaRepositoryImpl(AreadbDatasource());
  final ProjectRepositoryImpl projectRepositoryImpl =
      ProjectRepositoryImpl(ProjectdbDatasource());
  final TaskRepositoryImpl taskRepositoryImpl =
      TaskRepositoryImpl(TaskdbDatasource());
  final AgendaRepositoryImpl agendaRepositoryImpl =
      AgendaRepositoryImpl(AgendadbDatasource());
  final AgreementRepositoryImpl agreementRepositoryImpl =
      AgreementRepositoryImpl(AgreementdbDatasource());

  //VARIABLES
  final ScrollController scrollControllerListPersonSelected =
      ScrollController();
  bool withAgenda = false;
  TextEditingController tittleMeet = TextEditingController(text: '');
  TextEditingController subjectMeet = TextEditingController(text: '');
  TextEditingController ctrlDateMeet =
      TextEditingController(text: Helpers.dateToStringTimeDMY(DateTime.now()));
  TextEditingController ctrlDateLimitAgreement =
      TextEditingController(text: Helpers.dateToStringTimeDMY(DateTime.now()));
  TextEditingController ctrlTimeMeet = TextEditingController(
      text: Helpers.dateToStringHourMinute(DateTime.now()));
  TextEditingController ctrlDurationMeet = TextEditingController(text: '00:30');
  TextEditingController ctrlTittleAgenda = TextEditingController(text: '');
  TextEditingController ctrlMeetingPlace = TextEditingController(text: '');

  DateTime dateMeet = DateTime.now();
  DateTime timeMeet = DateTime.now();
  Duration duration = const Duration(minutes: 30);
  List<OptionSelectModel> listTypeAgenda = [
    OptionSelectModel(id: '0', text: 'Agenda'),
    OptionSelectModel(id: '1', text: 'Proyecto'),
    OptionSelectModel(id: '2', text: 'Tarea'),
    OptionSelectModel(id: '3', text: 'Reunión'),
  ];

  List<OptionSelectModel> listModeOfMeet = [
    OptionSelectModel(id: '0', text: 'Online'),
    OptionSelectModel(id: '1', text: 'Presencial'),
  ];

  List<OptionSelectModel> listPlaceMeet = [
    OptionSelectModel(id: '0', text: 'zoom'),
    OptionSelectModel(id: '1', text: 'Otros'),
  ];

  List<OptionSelectModel> lisTypeAgreement = [
    OptionSelectModel(id: 'Nota', text: 'Nota'),
    OptionSelectModel(id: 'Acuerdo', text: 'Acuerdo'),
    OptionSelectModel(id: 'Tarea', text: 'Tarea'),
  ];

  List<OptionSelectModel> lisTypePrivacityAgreement = [
    OptionSelectModel(id: 'Publica', text: 'Pública'),
    OptionSelectModel(id: 'Privada', text: 'Privada'),
  ];
  Area clientMeet = Area(
    clienteId: '0',
    clienteNombre: 'Seleccionar',
  );
  Person person = Person(
    personalId: '-1',
    personalNombreCompleto: 'Seleccionar',
  );
  Person personAgenda = Person(
    personalId: '-1',
    personalNombreCompleto: 'Seleccionar',
  );

  OptionSelectModel typeOfAgenda = OptionSelectModel(id: '0', text: 'Agenda');
  OptionSelectModel placeMeet = OptionSelectModel(id: '0', text: 'Zoom');
  OptionSelectModel modeOfMeet = OptionSelectModel(id: '0', text: 'Online');
  OptionSelectModel typeOfMeet = OptionSelectModel(id: '0', text: 'Abierta');

  List<OptionSelectModel> listTypeOfMeet = [
    OptionSelectModel(id: '0', text: 'Abierta'),
    OptionSelectModel(id: '1', text: 'Cerrada'),
  ];

  Color selectedColor = Colors.purple;
  List<Color> colors = [
    Colors.purple,
    Colors.green,
    Colors.yellow,
    Colors.red,
    Colors.orange
  ];

  List<Meet> listMeet = [];
  List<Meet> childrenMeets = [];
  List<Person> personSelected = [];
  List<Person> listSelectedPeopleToProject = [];

  // String modeOfMeet = 'Online';

  List<Area> listClient = [
    Area(clienteId: '0', clienteNombre: 'Seleccionar'),
  ];
  List<Agenda> listAgendaAdd = [];

  //FUNCTIONS

  void updateDuration(value) {
    duration = value;
  }

  void updateselectedColor(Color color) {
    selectedColor = color;
    notifyListeners();
  }

  bool isLoadOnInit = true;
  Future<void> onInit() async {
    try {
      await getDataPersonal();
      print(personalId);
      // return;
      getMeetings();
      getListPerson();
      getListClient();
      getListProjects();
      getTasks();
      getMeetingsAgenda();
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      isLoadOnInit = false;
      notifyListeners();
    }
  }

  String personalId = '';
  Future<void> getDataPersonal() async {
    personalId = await secureStorage.read(key: Keys.kIdUser) ?? '';
  }

  bool isGetMeetings = false;
  Future<void> getMeetings(
      {String reunionId = '',
      int datefilter = 0,
      String reunionTitulo = "",
      String reunionConvocanteId = ""}) async {
    listMeet.clear();
    isGetMeetings = true;
    notifyListeners();
    try {
      final response = await meetRepositoryImpl.getMeetsByPerson(MeetModel(
        reunionId: reunionId,
        datefilter: datefilter,
        reunionTitulo: reunionTitulo,
        // reunionConvocanteId:
        // personalId //Para cuando se ponga el filtro de (participante o responsable)
      ));
      listMeet.addAll(response);
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      isGetMeetings = false;
      notifyListeners();
    }
  }

  bool isGettingMeetingsChild = false;
  Future<List<Meet>> getMeetingsChild(
      {String reunionId = '',
      int datefilter = 0,
      String reunionTitulo = "",
      String reunionConvocanteId = ""}) async {
    isGettingMeetingsChild = true;
    notifyListeners();
    try {
      final response = await meetRepositoryImpl.getMeetsByPerson(MeetModel(
        reunionId: reunionId,
        datefilter: datefilter,
        reunionTitulo: reunionTitulo,
        personalId:
            personalId, //Para cuando se ponga el filtro de (participante o responsable)
      ));
      return response;
    } catch (e) {
      debugPrint(e.toString());
      return [];
    } finally {
      isGettingMeetingsChild = false;
      notifyListeners();
    }
  }

  //VARIABLES
  bool isCreatingMeet = false;
  Future<void> createMeet(BuildContext context,
      {int isPending = 0, MeetModel? meetModel}) async {
    //isPending cada reunión nace como pendiente
    isCreatingMeet = true;
    notifyListeners();

    try {
      final agendaModels = listAgendaAdd
          .map(
            (a) => AgendaModel(
              reunDetId: a.id,
              reunDetTitulo: a.tittle,
              reunDetTipo: a.type,
              reunDetResponsableId: a.responsibleId == '-1'
                  ? ''
                  : a.responsibleId, //Validacion para no enviar el -1
              reunDetResponsableNom:
                  a.responsibleId == '-1' ? '' : a.responsibleNames,
              reunDetText01: (a.associatedTypeId != null &&
                      a.associatedTypeId!.length > 12)
                  ? a.associatedTypeId!.substring(0, 12)
                  : a.associatedTypeId ?? '',
              reunDetAsociado: a
                  .associatedTypeName, // getAssociatedData(a.typeId ?? '' ).name,//Sí esta relacionado a un proyecto
              reunDetFecha: DateTime.now(),
              // reunDetText02; //Resultado esperado
              // reunDetNum01;
              // reunDetNum02;
              // reunDetText03;
              // reunDetText04;
            ),
          )
          .toList();
      final time = Helpers.extractTime(ctrlDurationMeet.text);
      final meetToCreate = MeetModel(
        reunionId: '',
        reunionTitulo: tittleMeet.text,
        reunionAsunto: subjectMeet.text,
        reunionModalidad: modeOfMeet.text,
        reunionLugar: placeMeet.text,
        reunionClase:
            '', //Revisar aqui se guarda si es en base a un proyecto o algo
        reunionGrupoPro: '',
        reuniomAreaConoci: '',
        reunionClienteId: clientMeet.clienteId,
        reunionClienteNombre: clientMeet.clienteNombre,
        reunionProyectoId:
            projectMeet.campanaid == '0' ? '' : projectMeet.campanaid,
        reunionProyectoNombre:
            projectMeet.campanaid == '0' ? '' : projectMeet.campanaNombre,

        reunionFecha: DateFormat('dd/MM/yyyy').parse(ctrlDateMeet.text),
        // reunionHoraIni: "2025-09-05T14:40:00",

        reunionHoraIni:
            '${Helpers.formatDateAgeMonthDay(ctrlDateMeet.text)}T${ctrlTimeMeet.text.substring(0, 5)}:00',
        // reunionHoraIni:
        //     '${DateFormat('yyyy/MM/dd').parse(ctrlDateMeet.text)}T${ctrlTimeMeet.text.substring(0, 5)}:00',
        reunionTotalHoras: time['hours']!,
        reunionMinutos: time['minutes']!,
        reunionConvocanteId: personResponsible.personalId == '-1'
            ? personalId
            : personResponsible.personalId,
        reunionConvocanteNom: personResponsible.personalNombreCompleto,
        reunionParticipantes:
            personSelected.map((p) => p.personalId.toString()).join(','),
        reunionCampoNum01: isPending,
        // reunionCampoNum02: ,//libre
        // reunionFec01: ,//libre
        // reunionFec02: ,//libre
        // reunionText01: ,//libre
        // reunionText02: ,//libre
        reunionText03:
            personalId, //libre Lo usaré para guardar a la persona que creo la reunión
        reunionText04: Helpers.colorToHex(selectedColor),
        reunionText05: typeOfMeet.text, //Abierto o Cerrado
        reunionText06: ctrlMeetingPlace.text, //Lugar de la reunión
        reunionText07: inBaseMeetId, //Enviar el id del cual esta siendo creado
        // reunionFec03: ,//Libre
        // reunionesSdtListPerProSer: , //Solo guardare los ids de las personas participantes
        renDet: withAgenda ? agendaModels : null,
      );
      final response = await meetRepositoryImpl.postCreateMeet(meetToCreate);
      if (response == null) {
        showToastGlobal(context, 2, "error", "Ups! Ocurrió un error.");
      }
      showToastGlobal(
        context,
        0,
        "success",
        "Reunión creada correctamente.",
      );
      Navigator.of(context).pop();
      clearValuesToNewMeet();
      getMeetings();
      // listMeet.add(MeetMapper.meetResponseToEntity(meetToCreate));//TODO: Llamar a funcion para obtener la lista de reuniones o actaulziar la ui
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      isCreatingMeet = false;
      notifyListeners();
    }
  }

  bool isUpdatingMeet = false;
  Future<void> updateMeet(BuildContext context, MeetModel meetModel) async {
    isUpdatingMeet = true;
    notifyListeners();
    try {
      final response = await meetRepositoryImpl.updateMeet(meetModel);
      if (response == null) {
        showToastGlobal(context, 2, "error", "Ups! Ocurrió un error.");
      }
      showToastGlobal(
        context,
        0,
        "success",
        "Reunión actualizada correctamente.",
      );
      Navigator.of(context).pop();
      clearValuesToNewMeet();
      //Pedir de nuevo la agenda
      //Pedir participantes
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      isUpdatingMeet = false;
      notifyListeners();
    }
  }

  Future<void> saveMeet(BuildContext context, {Meet? meet}) async {
    final agendaModels = listAgendaAdd
        .map(
          (a) => AgendaModel(
            reunDetId: a.id,
            reunDetTitulo: a.tittle,
            reunDetTipo: a.type,
            reunDetResponsableId: a.responsibleId == '-1'
                ? ''
                : a.responsibleId, //Validacion para no enviar el -1
            reunDetResponsableNom:
                a.responsibleId == '-1' ? '' : a.responsibleNames,
            reunDetText01:
                (a.associatedTypeId != null && a.associatedTypeId!.length > 12)
                    ? a.associatedTypeId!.substring(0, 12)
                    : a.associatedTypeId ?? '',
            reunDetAsociado: a
                .associatedTypeName, // getAssociatedData(a.typeId ?? '' ).name,//Sí esta relacionado a un proyecto
            reunDetFecha: DateTime.now(),
            // reunDetText02; //Resultado esperado
            // reunDetNum01;
            // reunDetNum02;
            // reunDetText03;
            // reunDetText04;
          ),
        )
        .toList();
    final time = Helpers.extractTime(ctrlDurationMeet.text);
    final meetModel = MeetModel(
      reunionId: meet != null ? meet.reunionId : '',
      reunionTitulo: tittleMeet.text,
      reunionAsunto: subjectMeet.text,
      reunionModalidad: modeOfMeet.text,
      reunionLugar: placeMeet.text,
      reunionClase:
          '', //Revisar aqui se guarda si es en base a un proyecto o algo
      reunionGrupoPro: '',
      reuniomAreaConoci: '',
      reunionClienteId: clientMeet.clienteId,
      reunionClienteNombre: clientMeet.clienteNombre,
      reunionProyectoId:
          projectMeet.campanaid == '0' ? '' : projectMeet.campanaid,
      reunionProyectoNombre:
          projectMeet.campanaid == '0' ? '' : projectMeet.campanaNombre,

      reunionFecha: DateFormat('dd/MM/yyyy').parse(ctrlDateMeet.text),
      // reunionHoraIni: "2025-09-05T14:40:00",

      reunionHoraIni:
          '${Helpers.formatDateAgeMonthDay(ctrlDateMeet.text)}T${ctrlTimeMeet.text.substring(0, 5)}:00',
      // reunionHoraIni:
      //     '${DateFormat('yyyy/MM/dd').parse(ctrlDateMeet.text)}T${ctrlTimeMeet.text.substring(0, 5)}:00',
      reunionTotalHoras: time['hours']!,
      reunionMinutos: time['minutes']!,
      reunionConvocanteId: personResponsible.personalId == '-1'
          ? personalId
          : personResponsible.personalId,
      reunionConvocanteNom: personResponsible.personalNombreCompleto,
      reunionParticipantes:
          personSelected.map((p) => p.personalId.toString()).join(','),
      reunionCampoNum01: 0,
      // reunionCampoNum02: ,//libre
      // reunionFec01: ,//libre
      // reunionFec02: ,//libre
      // reunionText01: ,//libre
      // reunionText02: ,//libre
      reunionText03:
          personalId, //libre Lo usaré para guardar a la persona que creo la reunión
      reunionText04: Helpers.colorToHex(selectedColor),
      reunionText05: typeOfMeet.text, //Abierto o Cerrado
      reunionText06: ctrlMeetingPlace.text, //Lugar de la reunión
      reunionText07: inBaseMeetId, //Enviar el id del cual esta siendo creado
      // reunionFec03: ,//Libre
      // reunionesSdtListPerProSer: , //Solo guardare los ids de las personas participantes
      renDet: withAgenda ? agendaModels : null,
    );
    if (meet != null) {
      await updateMeet(context, meetModel);
    } else {
      await createMeet(context, meetModel: meetModel);
    }
  }

  bool isGettingAreas = false;
  Future<void> getListClient() async {
    // listClient.clear();
    isGettingAreas = true;
    try {
      final response = await areaRepositoryImpl.getAllAreas();
      listClient.addAll(response);
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      isGettingAreas = false;
      notifyListeners();
    }
  }

  List<Project> listProjects = [
    Project(
      campanaid: '0',
      campanaNombre: 'Seleccionar',
    )
  ];
  // List<Project> listProjectsAgenda = [
  //   Project(
  //     id: '0',
  //     campanaNombre: 'Seleccionar',
  //   )
  // ];

  Project projectMeet = Project(
    campanaid: '0',
    campanaNombre: 'Seleccionar',
  );
  Project currentProjectAgenda = Project(
    id: '0',
    campanaNombre: 'Seleccionar',
  );
  bool isGettingListProjects = false;
  Future<void> getListProjects() async {
    isGettingListProjects = true;
    try {
      final response =
          await projectRepositoryImpl.getListProyects(ProjectModel());
      listProjects.addAll(response);
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      isGettingListProjects = false;
      notifyListeners();
    }
  }

  List<Person> listPerson = [
    Person(
      personalId: '-1',
      personalNombreCompleto: 'Seleccionar',
    )
  ];
  List<Person> listPersonResponsible = [
    Person(
      personalId: '-1',
      personalNombreCompleto: 'Seleccionar',
    )
  ];
  Person personResponsible = Person(
    personalId: '-1',
    personalNombreCompleto: 'Seleccionar',
  );

  bool isGettinPerons = false;
  Future<void> getListPerson() async {
    isGettinPerons = true;
    // listPerson.clear();
    try {
      final response = await personRepositoryImpl.getListPersons();
      listPerson.addAll(response);
      listPersonResponsible.addAll(response);
      if (listPerson.isNotEmpty) {
        final first = listPerson.first;
        personAgenda = Person(
            personalId: first.personalId ?? '',
            personalNombreCompleto: first.personalNombreCompleto ?? '');
      }
      if (listPersonResponsible.isNotEmpty) {
        final first = listPerson.first;
        person = Person(
            personalId: first.personalId ?? '',
            personalNombreCompleto: first.personalNombreCompleto ?? '');
      }
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      isGettinPerons = false;
      notifyListeners();
    }
  }

  // ResponseListProyectsModel listProjectResponse = ResponseListProyectsModel()

  int typeView = 0;
  void changeTypeView(int pTypeView) {
    typeView = pTypeView;
    notifyListeners();
  }

  void changeWithAgenda() {
    withAgenda = !withAgenda;
    notifyListeners();
  }

  void removeOrAddPersonSelected(Person iPersonSelected) {
    if (personSelected.contains(iPersonSelected)) {
      personSelected.remove(iPersonSelected);
    } else {
      personSelected.add(iPersonSelected);
    }
    print("paso por aqui agregar");
    notifyListeners();
  }

  void scrollToBottom() {
    if (scrollControllerListPersonSelected.hasClients) {
      Future.delayed(const Duration(milliseconds: 200)).then((value) {
        scrollControllerListPersonSelected.animateTo(
          scrollControllerListPersonSelected.position.maxScrollExtent,
          duration: const Duration(milliseconds: 200),
          curve: Curves.fastOutSlowIn,
        );
      });
    }
  }

  int reunDetId = 0;
  // String? associatedId;
  // String? associatedName;
  void addNewAgenda() {
    reunDetId += 1;
    final associated = getAssociatedData(typeOfAgenda.id);
    final Agenda agenda = Agenda(
      id: reunDetId,
      tittle: ctrlTittleAgenda.text,
      typeId: typeOfAgenda.id,
      type: typeOfAgenda.text,
      responsibleId: personAgenda.personalId,
      responsibleNames: personAgenda.personalNombreCompleto,
      associatedTypeId: associated.id,
      associatedTypeName: associated.name,
    );
    listAgendaAdd.add(agenda);
    clearValuesToNewRow();
    notifyListeners();
  }

  ({String? id, String? name}) getAssociatedData(String typeId) {
    switch (typeId) {
      case '1': // Proyecto
        return (
          id: currentProjectAgenda.id,
          name: currentProjectAgenda.campanaNombre
        );
      case '2': // Tarea
        return (
          id: currentTaskAgenda.ordenProduccionId,
          name: currentTaskAgenda.ordenProduccionTrabajoRealizar
        );
      case '3': // Reunión
        return (
          id: currentMeetAgenda.reunionId,
          name: currentMeetAgenda.reunionTitulo
        );
      default:
        return (id: null, name: null);
    }
  }

  bool modeEdit = false;
  int agendaId = 0;

  void passValuesToUpdate(Agenda iAgenda) {
    agendaId = iAgenda.id ?? 0;
    ctrlTittleAgenda.text = iAgenda.tittle ?? '';
    typeOfAgenda =
        OptionSelectModel(id: iAgenda.typeId ?? '', text: iAgenda.type ?? '');
    // Asigna los valores asociados según el tipo (reutilizando la función)
    setAssociatedData(
      typeOfAgenda.id,
      iAgenda.associatedTypeId,
      iAgenda.associatedTypeName,
    );
    personAgenda.personalId = iAgenda.responsibleId ?? '';
    personAgenda.personalNombreCompleto = iAgenda.responsibleNames ?? '';
    modeEdit = true;

    notifyListeners();
  }

  void setAssociatedData(
      String typeId, String? associatedId, String? associatedName) {
    switch (typeId) {
      case '1': // Proyecto
        currentProjectAgenda
          ..id = associatedId ?? ''
          ..campanaNombre = associatedName ?? '';
        break;
      case '2': // Tarea
        currentTaskAgenda
          ..ordenProduccionId = associatedId ?? ''
          ..ordenProduccionTrabajoRealizar = associatedName ?? '';
      case '3': // Reunión
        currentMeetAgenda
          ..reunionId = currentMeetAgenda.reunionId ?? ''
          ..reunionTitulo = currentMeetAgenda.reunionTitulo ?? '';
        break;
    }
  }

  void updateRowAgenda() {
    final associated = getAssociatedData(typeOfAgenda.id);
    final Agenda agenda = Agenda(
      id: agendaId,
      tittle: ctrlTittleAgenda.text,
      typeId: typeOfAgenda.id,
      type: typeOfAgenda.text,
      responsibleId: personAgenda.personalId,
      responsibleNames: personAgenda.personalNombreCompleto,
      associatedTypeId: associated.id,
      associatedTypeName: associated.name,
    );
    final index = listAgendaAdd.indexWhere((item) => item.id == agendaId);
    if (index != -1) {
      listAgendaAdd[index] = agenda;
    }
    modeEdit = false;
    clearValuesToNewRow();
    notifyListeners();
  }

  void clearValuesToNewRow() {
    modeEdit = false;
    ctrlTittleAgenda.text = '';
    notifyListeners();
  }

  void clearValuesToNewMeet() {
    inBaseMeetId = '';
    tittleMeet.text = '';
    subjectMeet.text = '';
    typeOfMeet = OptionSelectModel(id: '0', text: 'Abierta');
    modeOfMeet = OptionSelectModel(id: '0', text: 'Online');
    placeMeet = OptionSelectModel(id: '0', text: 'Zoom');
    personResponsible = Person(
      personalId: '-1',
      personalNombreCompleto: 'Seleccionar',
    );
    clientMeet = Area(
      clienteId: '0',
      clienteNombre: 'Seleccionar',
    );
    projectMeet = Project(
      campanaid: '0',
      campanaNombre: 'Seleccionar',
    );
    ctrlDateMeet = TextEditingController(
        text: Helpers.dateToStringTimeDMY(DateTime.now()));
    ctrlTimeMeet = TextEditingController(
        text: Helpers.dateToStringHourMinute(DateTime.now()));
    ctrlDurationMeet.text = '00:30';
    personSelected.clear();
    listAgendaAdd.clear();
    // notifyListeners();
  }

  void removeRowAgenda(Agenda agenda) {
    listAgendaAdd.removeWhere((item) => item.id == agenda.id);
    notifyListeners();
  }

  void updateTypeOfMeet() {
    notifyListeners();
  }

  void justUpdateUi() {
    notifyListeners();
  }

  String inBaseMeetId = '';
  Future<void> toCreateInBaseMeet(Meet meet, {bool isEdit = false}) async {
    listAgendaAdd.clear();
    inBaseMeetId = meet.reunionId ?? '';
    tittleMeet.text = meet.reunionTitulo ?? '';
    subjectMeet.text = meet.reunionAsunto ?? '';
    modeOfMeet = modeOfMeet.copyWith(
      text: meet.reunionModalidad ?? '',
    );
    placeMeet = placeMeet.copyWith(text: meet.reunionLugar ?? '');

    clientMeet.clienteId = meet.reunionClienteId ?? '';
    clientMeet.clienteNombre = meet.reunionClienteNombre ?? '';
    projectMeet.campanaid = meet.reunionProyectoId ?? '';
    projectMeet.campanaNombre = meet.reunionProyectoNombre ?? '';
    ctrlDateMeet = TextEditingController(
        text: Helpers.dateToStringTimeDMY(DateTime.now()));
    // ctrlTimeMeet.text = Helpers.formatTimeToAmPm(meet.reunionHoraIni);
    ctrlDurationMeet.text =
        '${Helpers.twoDigits(meet.reunionTotalHoras)}:${Helpers.twoDigits(meet.reunionMinutos)}';
    personResponsible.personalId = meet.reunionConvocanteId ?? '';
    personResponsible.personalNombreCompleto = meet.reunionConvocanteNom ?? '';
    selectedColor =
        Helpers.hexToColor(meet.color); //Aun no se pasa bien a la ui revisar
    // print(meet.reunionParticipantes);
    // final participantes = jsonDecode(meet.reunionParticipantes ?? '') as List;
    // personSelected
    //     .addAll(participantes.map((id) => Person(personalId: id.toString())));
    // final rawParticipantes = meet.reunionParticipantes;
    // final rawParticipantes = meet.reunionParticipantes;
    //   void toCreateInBaseMeet(Meet meet) {
    mapMeetParticipantsToPersonList(meet);
    // listAgendaAdd = meet.
    // List participantes = [];
    // if (rawParticipantes != null && rawParticipantes.trim().isNotEmpty) {
    //   try {
    //     participantes = jsonDecode(rawParticipantes) as List;
    //   } catch (e) {
    //     print('Error al decodificar participantes: $e');
    //     participantes = [];
    //   }
    // }

    // personSelected.addAll(
    //   participantes.map((id) => Person(personalId: id.toString())),
    // );
    // reunionCampoNum01: isPending,
    // reunionText04: Helpers.colorToHex(selectedColor), //color
    // reunionText05: typeOfMeet.text, //Abierto o Cerrado
    // reunionText06: ctrlMeetingPlace.text, //Lugar de la reunión
    // renDet: agendaModels,
    //Todo: traer a las reuniones hija para saber cual es el ultimo y en base a ello tomar el id y traer la agenda
    if (isEdit == true) {
      listAgendaAdd.addAll(listAgenda);
    } else {
      final listMeetChild = await getMeetingsChild(reunionId: inBaseMeetId);
      await getAgenda(listMeetChild.last.reunionId ?? '');
      listAgendaAdd.addAll(listAgenda);
      print("Agregando la agenda");
      print(listAgendaAdd.length);
    }

    notifyListeners();
  }

  void mapMeetParticipantsToPersonList(Meet meet) {
    personSelected.clear();
    print(meet.reunionParticipantes);
    print('reunion participantes');
    // Validar si reunionParticipantes tiene valor
    if (meet.reunionParticipantes == null ||
        meet.reunionParticipantes!.isEmpty) {
      return; // No hay nada que mapear
    }

    // 1️⃣ Obtener los IDs del string, limpiando espacios
    List<String> ids = meet.reunionParticipantes!
        .split(',')
        .map((id) => id.trim())
        .where((id) => id.isNotEmpty)
        .toList();

    // 2️⃣ Buscar los objetos que coinciden en listPerson
    for (var id in ids) {
      final person = listPerson.firstWhere(
        (p) => p.personalId == id,
        orElse: () => Person(), // 👈 devuelve objeto vacío o maneja null
      );

      // Si tienes un constructor vacío o un check de id:
      if (person.personalId != null) {
        if (person.personalId!.isNotEmpty) personSelected.add(person);
      }
    }
  }

  List<Task> listTaskAgenda = [
    Task(
      id: '0',
      ordenProduccionTrabajoRealizar: 'Seleccionar',
    )
  ];
  Task currentTaskAgenda = Task(
    id: '0',
    ordenProduccionTrabajoRealizar: 'Seleccionar',
  );

  Future<void> getTasks({Project? project}) async {
    listTaskAgenda = [
      Task(
        ordenProduccionId: '0',
        ordenProduccionTrabajoRealizar: 'Seleccionar',
      )
    ];
    try {
      final response =
          await taskRepositoryImpl.getListTaskByProject(RequestListTaskModel(
        pPersonalId: personalId,
        campanaId: project != null
            ? project.campanaid
            : currentProjectAgenda.campanaid,
        clienteId: project != null
            ? project.clienteid
            : currentProjectAgenda.clienteid,
        companiaId: project != null
            ? project.companiaid
            : currentProjectAgenda.companiaid,
        taskId: '',
      ));
      listTaskAgenda.addAll(response);

      if (listTaskAgenda.isNotEmpty) {
        final first = listTaskAgenda.first;
        currentTaskAgenda = Task(
            ordenProduccionId: first.ordenProduccionId ?? '',
            ordenProduccionTrabajoRealizar:
                first.ordenProduccionTrabajoRealizar ?? '');
      }
      print('cantidad de tareas: ${listTaskAgenda.length}');
    } catch (e) {
      debugPrint('error ${e}');
    } finally {
      notifyListeners();
    }
  }

  bool isGetMeetingToAgenda = false;
  List<Meet> meetsToAgenda = [
    Meet(reunionId: '0', reunionTitulo: 'Seleccionar')
  ];

  Meet currentMeetAgenda = Meet(reunionId: '0', reunionTitulo: 'Seleccionar');
  Future<void> getMeetingsAgenda(
      {String reunionId = '',
      int datefilter = 5,
      String reunionTitulo = "",
      String reunionConvocanteId = ""}) async {
    meetsToAgenda = [Meet(reunionId: '0', reunionTitulo: 'Seleccionar')];
    isGetMeetingToAgenda = true;

    notifyListeners();
    try {
      final response = await meetRepositoryImpl.getMeetsByPerson(MeetModel(
          reunionId: '',
          datefilter: 5,
          reunionTitulo: '',
          reunionConvocanteId:
              ' ' //Para cuando se ponga el filtro de (participante o responsable)
          ));
      meetsToAgenda.addAll(response);
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      isGetMeetingToAgenda = false;
      notifyListeners();
    }
  }

  List<Agenda> listAgenda = [];
  bool isGettingAgenda = false;
  Future<void> getAgenda(String reunionId) async {
    isGettingAgenda = true;
    listAgenda.clear();
    final response = await agendaRepositoryImpl.getAgenda(reunionId);
    if (response.isNotEmpty) {
      //listAgenda.addAll(response);
      listAgenda = response;
    }

    isGettingAgenda = false;
    notifyListeners();
  }

  bool isGettingParticipantsDetail = false;
  List<Participant> participantsDetail = [];
  Future<void> getParticipants(String reunionId) async {
    participantsDetail.clear();
    try {
      isGettingParticipantsDetail = true;
      final response = await meetRepositoryImpl.getParticipants(reunionId);
      participantsDetail.addAll(response);
      isGettingParticipantsDetail = false;
    } catch (e) {
      print("Error aquí");
    }
    notifyListeners();
  }

  void getDetailMeet(Meet meet) async {
    getAgenda(meet.reunionId ?? '');
    getParticipants(meet.reunionId ?? '');
    childrenMeets = await getMeetingsChild(reunionId: meet.reunionIdMain ?? '');
    notifyListeners();
  }

  bool showRelatedMeetings = false;
  bool showAgenda = true;
  bool showAdvanceInputs = false;
  bool showDetailHeader = true;
  void showOrHideRelatedMeeting() {
    showRelatedMeetings = !showRelatedMeetings;
    notifyListeners();
  }

  void showAgendaMeet() {
    showAgenda = !showAgenda;
    notifyListeners();
  }

  void showAdvanceInputMeet() {
    showAdvanceInputs = !showAdvanceInputs;
    notifyListeners();
  }

  void showDetailHeaderMeet() {
    showDetailHeader = !showDetailHeader;
    notifyListeners();
  }

  Future<bool> postResponseMeet(
      BuildContext context, String reunionId, String stateInvitation) async {
    print(personalId);
    final response = await meetRepositoryImpl.postResponseMeet(
        reunionId, personalId, stateInvitation);

    if (!response) {
      showToastGlobal(
        context,
        2,
        "error",
        "Ups... Ocurrio un error por favor vuelva a intentar.",
      );
      return false;
    }
    notifyListeners();
    return true;
  }

  Future<bool> deleteMeet(
      BuildContext context, String reunionId, String parentId) async {
    final response = await meetRepositoryImpl.deleteMeet(reunionId);

    if (response != null) {
      showToastGlobal(
        context,
        0,
        "success",
        "Reunión eliminada correctamente.",
      );
      decrementChildrenCount(parentId);
      // listMeet.removeWhere((m) => m.reunionId == reunionId);
      return true;
    } else {
      showToastGlobal(
        context,
        2,
        "error",
        "Ups... Ocurrio un error al eliminar la reunión, favor vuelva a intentar.",
      );
    }
    return false;
  }

  void decrementChildrenCount(String parentId) {
    final meet = listMeet.firstWhere(
      (m) => m.reunionId == parentId,
      orElse: () => Meet(),
    );

    if (meet.reunionQuantityChildrend! > 0) {
      meet.reunionQuantityChildrend = (meet.reunionQuantityChildrend ?? 0) - 1;
      notifyListeners(); // 👈 Actualiza la UI
    }
  }

  Future<void> updateState(BuildContext context, String reunionId) async {
    final response = await meetRepositoryImpl.updateState(reunionId);

    if (response != null) {
      showToastGlobal(
        context,
        0,
        "success",
        "Reunión finalizada correctamente.",
      );
    } else {
      showToastGlobal(
        context,
        2,
        "error",
        "Ups... Ocurrio un error al finalizar la reunión favor vuelva a intentar.",
      );
    }
  }

  Future<List<Agreement>> getAgreements(String reunionId, int agendaId) async {
    final response =
        await agreementRepositoryImpl.getAgreements(reunionId, agendaId);
    if (response.isNotEmpty) {
      return response;
    }
    return [];
  }

  bool isGetListSubtask = false;
  List<Task> listSubtask = [
    Task(
      ordenProduccionId: '0',
      ordenProduccionTrabajoRealizar: 'Seleccionar',
    )
  ];
  Future<void> getListSubTask(Task currentTaskAgenda) async {
    isGetListSubtask = true;
    List<Task> listSubtask = [
      Task(
        ordenProduccionId: '0',
        ordenProduccionTrabajoRealizar: 'Seleccionar',
      )
    ];
    try {
      final response = await taskRepositoryImpl.getListTaskByProject(
          RequestListTaskModel(
              campanaId: currentTaskAgenda.campanaId ?? '',
              pPersonalId: personalId,
              taskId: currentTaskAgenda.ordenProduccionId ?? '',
              clienteId: currentTaskAgenda.clienteId ?? '',
              companiaId: currentTaskAgenda.companiaId ?? ''
              // subTaskId: pSubtaskId ?? "",
              ));
      if (response.isNotEmpty) {
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

  void prueba() {
    // DateTime date = DateFormat('dd/MM/yyyy').parse(ctrlDateMeet.text);
    // final date = Helpers.stringToDateTime(ctrlDateMeet.text);
    // print(date);
  }
}
