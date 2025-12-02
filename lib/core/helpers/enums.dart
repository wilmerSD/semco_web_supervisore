import 'package:app_tasking/infrastructure/models/option__select_model.dart';

enum PrivacityType {
  publica,
  privada,
}

extension PrivacityTypeExtension on PrivacityType {
  String get id {
    switch (this) {
      case PrivacityType.publica:
        return 'Publica';
      case PrivacityType.privada:
        return 'Privada';
    }
  }

  String get text {
    switch (this) {
      case PrivacityType.publica:
        return 'Pública';
      case PrivacityType.privada:
        return 'Privada';
    }
  }

  OptionSelectModel toOption() => OptionSelectModel(
        id: id,
        text: text,
      );
}

enum AgreementType {
  acuerdo,
  tarea,
}

extension AgreementTypeExtension on AgreementType {
  String get id {
    switch (this) {
      case AgreementType.tarea:
        return 'Tarea';
      case AgreementType.acuerdo:
        return 'Acuerdo';
    }
  }

  String get text {
    switch (this) {
      case AgreementType.tarea:
        return 'Tarea';
      case AgreementType.acuerdo:
        return 'Acuerdo';
    }
  }

  OptionSelectModel toOption() => OptionSelectModel(
        id: id,
        text: text,
      );
}

OptionSelectModel agreementTypeSelected =
    OptionSelectModel(id: 'Tarea', text: 'Tarea');
