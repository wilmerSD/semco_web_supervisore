import 'package:app_tasking/domain/entities/note.dart';
import 'package:app_tasking/infrastructure/models/request/request_new_note_model.dart';

abstract class NoteRepository {
  Future<List<Note>> getListNotes(String? taskid, String? clienteid, String? companiaid);
  Future<Note?> postProcCreateNote(RequestNewNoteModel request);
}