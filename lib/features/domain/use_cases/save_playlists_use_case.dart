import 'package:betteriptv/core/models/use_case.dart';
import 'package:betteriptv/di_manager.dart';
import 'package:betteriptv/features/data/dtos/playlist.dart';
import 'package:betteriptv/features/domain/repositories/playlist_repository.dart';

class SavePlaylistsUseCase extends UseCaseWithNoReturn<List<Playlist>> {
  SavePlaylistsUseCase({PlaylistRepository? repository}) : _repository = repository ?? getIt.get<PlaylistRepository>();

  final PlaylistRepository _repository;

  @override
  Future<void> call(List<Playlist> params) => _repository.savePlaylists(params);
}
