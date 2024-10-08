import 'dart:convert';

import 'package:betteriptv/constants/storage_keys.dart';
import 'package:betteriptv/core/services/storage/storage_service.dart';
import 'package:betteriptv/di_manager.dart';
import 'package:betteriptv/features/data/dtos/playlist.dart';

abstract class PlaylistLocalDataSource {
  Future<void> savePlaylists(List<Playlist> playlists);
  Future<List<Playlist>> getPlaylists();
}

class DefaultPlaylistLocalDataSource implements PlaylistLocalDataSource {
  DefaultPlaylistLocalDataSource({StorageService? storageService})
      : storageService = storageService ?? getIt.get<StorageService>();

  final StorageService storageService;

  @override
  Future<void> savePlaylists(List<Playlist> playlists) async {
    final encoded = jsonEncode(playlists);
    await storageService.write(key: StorageKeys.playlists.name, value: encoded);
  }

  @override
  Future<List<Playlist>> getPlaylists() async {
    final encoded = await storageService.read(key: StorageKeys.playlists.name);
    if (encoded != null) {
      final decoded = jsonDecode(encoded) as List<dynamic>;
      return decoded.map((e) => Playlist.fromJson(e as Map<String, dynamic>)).toList();
    } else {
      return [];
    }
  }
}
