import 'package:app_tasking/domain/entities/person.dart';

abstract class PersonRepository {
  Future<Person?> getPersonById(String personId);
  Future<List<Person>> getListPersons();
}
