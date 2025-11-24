import 'package:app_tasking/domain/datasources/person_datasource.dart';
import 'package:app_tasking/domain/entities/person.dart';
import 'package:app_tasking/domain/repositories/person_repository.dart';

class PersonRepositoryImpl extends PersonRepository {
  final PersonDatasource datasource;

  PersonRepositoryImpl(this.datasource);
  @override
  Future<Person?> getPersonById(String personId) {
    return datasource.getPersonById(personId);
  }

  @override
  Future<List<Person>> getListPersons() {
    return datasource.getListPersons();
  }
}
