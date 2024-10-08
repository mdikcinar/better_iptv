import 'package:betteriptv/core/models/data_result.dart';
import 'package:betteriptv/core/models/use_case.dart';
import 'package:betteriptv/di_manager.dart';
import 'package:betteriptv/features/data/dtos/playlist.dart';
import 'package:betteriptv/features/domain/repositories/playlist_repository.dart';

class GetPlaylistsUseCase extends UseCaseWithoutParams<List<Playlist>> {
  GetPlaylistsUseCase({PlaylistRepository? repository}) : _repository = repository ?? getIt.get<PlaylistRepository>();
  final PlaylistRepository _repository;

  @override
  Future<DataResult<List<Playlist>>> call() => _repository.getPlaylists();
}
