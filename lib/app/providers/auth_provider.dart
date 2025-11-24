import 'package:app_tasking/domain/entities/person.dart';
import 'package:app_tasking/preferences/shared_preferences.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';


class AuthProvider with ChangeNotifier {

  bool _isLoading = true;
  Person? _currentPerson;
  DateTime? _birthDate;
  DateTime? _entryDate;
  bool get isLoggedIn => _currentPerson != null;
  bool get isLoading => _isLoading;
  
  DateTime? get birthDate => _birthDate;
  Person? get currentPerson => _currentPerson;

  void setPerson(Person person) async{
    _currentPerson = person;
    PreferencesUser.personId = person.personalId ?? ''; // se guarda directo
    // PreferencesUser.mainEmail = person.personEm; // se guarda directo
    notifyListeners();
  }
  Future<void> loadPerson() async {
    _isLoading = true;
    final id = PreferencesUser.personId;
    if (id.isNotEmpty) {
      // _currentPerson = await PersonService().getPersonById(id);
      // _currentPerson = await PersonRepositoryImpl(PersondbDatasource()).getPersonById(id);
    }
    _isLoading = false;
     notifyListeners();
  }

  void notifyChange() {
    notifyListeners();
  }

  int? get age {
    if (_birthDate == null) return null;

    final today = DateTime.now();
    int age = today.year - _birthDate!.year;

    // Ajustar si todavía no ha cumplido años este año
    if (today.month < _birthDate!.month ||
        (today.month == _birthDate!.month && today.day < _birthDate!.day)) {
      age--;
    }
    return age;
  }

  int? get yearsOfMembership {
    if (_entryDate == null) return null;

    final today = DateTime.now();
    int age = today.year - _entryDate!.year;

    // Ajustar si todavía no ha cumplido años este año
    if (today.month < _entryDate!.month ||
        (today.month == _entryDate!.month && today.day < _entryDate!.day)) {
      age--;
    }
    return age;
  }

  String get birthDateFormatted {
    if (_birthDate == null) return '';
    return DateFormat('dd/MM/yyyy').format(_birthDate!);
  }

  // void logout() {
  //   _currentPerson = null;
  //   notifyListeners();
  // }

   void logout() {
    _currentPerson = null;
    PreferencesUser.personId = ''; // limpiar cache
    notifyListeners();
  }
}
