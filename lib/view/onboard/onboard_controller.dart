import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/storage/custom_storage_service.dart';
import '../../core/storage/storage_key_enums.dart';
import '../../models/playlist.dart';

// ignore: constant_identifier_names
enum OnBoardState { Initial, Busy, Error, Loaded }

class OnBoardController extends GetxController {
  final _storageService = Get.find<CustomStorageService>();

  final Rx<OnBoardState> _state = OnBoardState.Initial.obs;
  OnBoardState get state => _state.value;
  set state(OnBoardState val) => _state.value = val;

  final Rx<List<Playlist>?> _allPlaylists = Rx(null);
  List<Playlist>? get allPlaylists => _allPlaylists.value;
  set allPlaylists(List<Playlist>? val) => _allPlaylists.value = val;

  final formKey = GlobalKey<FormState>();
  String? playlistName;
  String? playlistUrl;

  @override
  void onInit() {
    if (_storageService.isExist(StorageKeys.allPlaylist.toString())) {
      final _storedModel = _storageService.readModel<List<Playlist>, Playlist>(
          key: StorageKeys.allPlaylist.toString(), parseModel: Playlist(id: '', url: ''));
      if (_storedModel != null) allPlaylists = _storedModel;
    }
    super.onInit();
  }

  void addPlaylist() {
    if (playlistUrl != null && playlistUrl!.isNotEmpty) {
      final playlist = Playlist(id: UniqueKey().toString(), name: playlistName, url: playlistUrl!);
      allPlaylists ??= <Playlist>[];
      allPlaylists = allPlaylists! + [playlist];
      _storageService.write(StorageKeys.allPlaylist.toString(), allPlaylists);
    }
  }

  Future<void> deletePlaylist(String playlistID) async {
    allPlaylists?.removeWhere((element) => element.id == playlistID);
    _storageService.remove(playlistID);
    await _storageService.write(StorageKeys.allPlaylist.toString(), allPlaylists);
  }
}
