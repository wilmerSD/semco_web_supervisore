
import 'package:app_tasking/domain/entities/area.dart';
import 'package:app_tasking/infrastructure/models/area_model.dart';

class AreaMapper {
  static Area areaResponseToEntity(AreaModel area) => Area(
    clienteId: area.clienteId ?? '',
    companiaId: area.companiaId ?? '',
    clienteNombre: area.clienteNombre ?? '',
    clienteRazonSocial: area.clienteRazonSocial ?? '',
    clienteRuc: area.clienteRuc ?? '',
    clienteCorreo: area.clienteCorreo ?? '',
  );
}
