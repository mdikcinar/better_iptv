import 'package:betteriptv/core/models/data_result.dart';
import 'package:betteriptv/core/models/use_case.dart';
import 'package:betteriptv/di_manager.dart';
import 'package:betteriptv/features/data/dtos/playlist.dart';
import 'package:betteriptv/features/domain/repositories/playlist_repository.dart';

class DownloadPlaylistUseCase extends UseCase<Playlist, Playlist> {
  DownloadPlaylistUseCase({PlaylistRepository? playlistRepository})
      : _playlistRepository = playlistRepository ?? getIt.get<PlaylistRepository>();

  final PlaylistRepository _playlistRepository;

  @override
  Future<DataResult<Playlist>> call(Playlist params) => _playlistRepository.downloadPlaylist(playlist: params);
}
