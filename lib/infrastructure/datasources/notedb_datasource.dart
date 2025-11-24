import 'package:app_tasking/core/network/dio_client.dart';
import 'package:app_tasking/core/network/dio_config.dart';
import 'package:app_tasking/domain/datasources/note_datasource.dart';
import 'package:app_tasking/domain/entities/note.dart';
import 'package:app_tasking/infrastructure/mappers/note_mapper.dart';
import 'package:app_tasking/infrastructure/models/request/request_new_note_model.dart';
import 'package:app_tasking/infrastructure/models/response/response_general_model.dart';
import 'package:app_tasking/infrastructure/models/response/response_list_notes_model.dart';

class NotedbDatasource extends NoteDatasource {
  late DioClient dioClient;
  NotedbDatasource() {
    final dio = DioConfig.initialize();
    dioClient = DioClient(dio);
  }

  @override
  Future<List<Note>> getListNotes(
      String? taskid, String? clienteid, String? companiaid) async {
    final response = await dioClient
        .get(path: "/APITaskingv1/GetProcListNotes", queryParameters: {
      "Taskid": taskid ?? '',
      "pComeClienteId": clienteid ?? '',
      "pComeCompaniaId": companiaid ?? '',
    });
    final noteResponse = ResponseListNotesModel.fromJson(response);
    if (noteResponse.data == null) return [];
    final notes = noteResponse.data!
        .map((element) => NoteMapper.noteResponseToEntity(element))
        .toList();

    return notes;
  }

  @override
  Future<Note?> postProcCreateNote(RequestNewNoteModel request) async {
    final response = await dioClient.post(
      path: '/APITaskingv1/PostProcCreateNote',
      bodyRaw: request.toJson(),
    );
    final noteResponse = ResponseGeneralModel.fromJson(response);
    if (noteResponse.succes) return Note();
    return null;
  }
}