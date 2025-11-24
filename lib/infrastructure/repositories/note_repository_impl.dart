import 'package:app_tasking/domain/datasources/note_datasource.dart';
import 'package:app_tasking/domain/entities/note.dart';
import 'package:app_tasking/domain/repositories/note_repository.dart';
import 'package:app_tasking/infrastructure/models/request/request_new_note_model.dart';

class NoteRepositoryImpl extends NoteRepository {
  final NoteDatasource noteDatasource;
  NoteRepositoryImpl(this.noteDatasource);
  @override
  Future<List<Note>> getListNotes(
      String? taskid, String? clienteid, String? companiaid) {
    return noteDatasource.getListNotes(taskid, clienteid, companiaid);
  }

  @override
  Future<Note?> postProcCreateNote(RequestNewNoteModel request) {
    return noteDatasource.postProcCreateNote(request);
  }
}
