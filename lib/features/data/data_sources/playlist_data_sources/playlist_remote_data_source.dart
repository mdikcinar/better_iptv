import 'package:betteriptv/core/services/network/network_service.dart';
import 'package:betteriptv/di_manager.dart';
import 'package:betteriptv/features/data/dtos/playlist.dart';
import 'package:betteriptv/features/data/exceptions/network_exception.dart';
import 'package:betteriptv/utils/m3u_helper.dart';

abstract class PlaylistRemoteDataSource {
  Future<Playlist> downloadPlaylist(Playlist playlist);
}

class DefaultPlaylistRemoteDataSource implements PlaylistRemoteDataSource {
  DefaultPlaylistRemoteDataSource({NetworkService? networkService})
      : networkService = networkService ?? getIt.get<NetworkService>();

  final NetworkService networkService;

  @override
  Future<Playlist> downloadPlaylist(Playlist playlist) async {
    final response = await networkService.get(playlist.url);
    if (response.isSuccessful) {
      final decoded = await M3uHelper.parse(response.body);
      final grouped = M3uHelper.groupM3uEntries(decoded);
      return playlist.copyWith(entries: grouped);
    } else {
      throw NetworkException(
        statusCode: response.statusCode,
        errorBody: response.body,
      );
    }
  }
}
