import 'package:app_tasking/domain/entities/person.dart';

abstract class PersonDatasource {
  Future<Person?> getPersonById(String personId);
  Future<List<Person>> getListPersons();
  // Future<Person?> createPerson(PersonModel person);
}
