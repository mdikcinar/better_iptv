import 'package:betteriptv/core/models/data_result.dart';
import 'package:betteriptv/core/models/failure.dart';
import 'package:betteriptv/core/models/repository.dart';
import 'package:betteriptv/di_manager.dart';
import 'package:betteriptv/features/data/data_sources/playlist_data_sources/playlist_local_data_source.dart';
import 'package:betteriptv/features/data/data_sources/playlist_data_sources/playlist_remote_data_source.dart';
import 'package:betteriptv/features/data/dtos/playlist.dart';
import 'package:betteriptv/features/domain/repositories/playlist_repository.dart';

class DefaultPlaylistRepository extends Repository implements PlaylistRepository {
  DefaultPlaylistRepository({
    super.logger,
    PlaylistLocalDataSource? playlistLocalDataSource,
    PlaylistRemoteDataSource? playlistRemoteDataSource,
  })  : _playlistLocalDataSource = playlistLocalDataSource ?? getIt.get<PlaylistLocalDataSource>(),
        _playlistRemoteDataSource = playlistRemoteDataSource ?? getIt.get<PlaylistRemoteDataSource>();

  final PlaylistLocalDataSource _playlistLocalDataSource;
  final PlaylistRemoteDataSource _playlistRemoteDataSource;

  @override
  Future<DataResult<Playlist>> downloadPlaylist({required Playlist playlist}) async {
    try {
      final downloadedPlaylist = await _playlistRemoteDataSource.downloadPlaylist(playlist);
      return DataResult.success(downloadedPlaylist);
    } catch (e, st) {
      return logger.handleException(e, st);
    }
  }

  @override
  Future<DataResult<List<Playlist>>> getPlaylists() async {
    try {
      final playlists = await _playlistLocalDataSource.getPlaylists();
      return DataResult.success(playlists);
    } catch (e, st) {
      return logger.handleException(e, st);
    }
  }

  @override
  Future<void> savePlaylists(List<Playlist> playlists) async {
    try {
      await _playlistLocalDataSource.savePlaylists(playlists);
    } catch (e, st) {
      logger.handleException<Failure>(e, st);
    }
  }
}
