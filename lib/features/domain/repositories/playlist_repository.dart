import 'package:betteriptv/core/models/data_result.dart';
import 'package:betteriptv/features/data/dtos/playlist.dart';

abstract class PlaylistRepository {
  Future<DataResult<Playlist>> downloadPlaylist({required Playlist playlist});
  Future<DataResult<List<Playlist>>> getPlaylists();
  Future<void> savePlaylists(List<Playlist> playlists);
}
