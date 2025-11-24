import 'package:app_tasking/domain/entities/note.dart';
import 'package:app_tasking/infrastructure/models/note_model.dart';

class NoteMapper {
  static Note noteResponseToEntity(NoteModel noteModel)=> Note(
    comeId: noteModel.comeId,
    comeTareadId: noteModel.comeTareadId,
    comeClienteId: noteModel.comeClienteId,
    comeCompaniaId: noteModel.comeCompaniaId,
    comePersonalId: noteModel.comePersonalId,
    comePersonaFullNames: noteModel.comePersonaFullNames,
    comeDate: noteModel.comeDate,
    comeTime: noteModel.comeTime,
    comeComentario: noteModel.comeComentario,
    comeTipo: noteModel.comeTipo,
  );
    
  }
