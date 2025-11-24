import 'package:app_tasking/domain/entities/person.dart';
import 'package:app_tasking/infrastructure/models/person_model.dart';

class PersonMapper {
  static Person personResponseToEntity(PersonModel person)=>
  Person(
    personalId: person.personalId,
    personalNombres: person.personalNombres,
    personalApellidos: person.personalApellidos,
    personalDni: person.personalDni,
    personalEstado: person.personalEstado,
    empresaid: person.empresaid,
    empresaRazonsocial: person.empresaRazonsocial,
    areaId: person.areaId,
    areaNombre: person.areaNombre,
    cargoId: person.cargoId,
    cargoNombre: person.cargoNombre,
    horarioId: person.horarioId,
    horarioNombre: person.horarioNombre,
    personalUsuario: person.personalUsuario,
    personalContrasena: person.personalContrasena,
    personalRol: person.personalRol,
    personalCorreo: person.personalCorreo,
    personalFoto: person.personalFoto,
    personalNombreCompleto: person.personalFullName,
    personalPhoto: person.personalFoto,
  );
}