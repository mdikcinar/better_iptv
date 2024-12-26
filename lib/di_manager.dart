import 'package:betteriptv/core/services/logger/logger.dart';
import 'package:betteriptv/core/services/logger/logger_with_talker.dart';
import 'package:betteriptv/core/services/network/http_service.dart';
import 'package:betteriptv/core/services/network/network_service.dart';
import 'package:betteriptv/core/services/storage/secure_storage_service.dart';
import 'package:betteriptv/core/services/storage/storage_service.dart';
import 'package:betteriptv/features/data/data_sources/playlist_data_sources/playlist_data_sources.dart';
import 'package:betteriptv/features/data/repositories/default_playlist_repository.dart';
import 'package:betteriptv/features/domain/repositories/playlist_repository.dart';
import 'package:betteriptv/features/domain/use_cases/use_cases.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:talker_flutter/talker_flutter.dart';

final getIt = GetIt.instance;

final class DiManager {
  static void configureDependencies() {
    _configureServices();
    _configureDataSources();
    _configureRepositories();
    _configureUseCases();
  }

  static void _configureServices() {
    getIt
      ..registerLazySingleton<Talker>(TalkerFlutter.init)
      ..registerLazySingleton<Logger>(LoggerWithTalker.new)
      ..registerLazySingleton<NetworkService>(HttpService.new)
      ..registerLazySingleton<FlutterSecureStorage>(
        () => const FlutterSecureStorage(
          aOptions: AndroidOptions(encryptedSharedPreferences: true),
        ),
      )
      ..registerLazySingleton<StorageService>(() => SecureStorageService(getIt.get<FlutterSecureStorage>()));
  }

  static void _configureDataSources() {
    getIt
      ..registerCachedFactory<PlaylistLocalDataSource>(DefaultPlaylistLocalDataSource.new)
      ..registerCachedFactory<PlaylistRemoteDataSource>(DefaultPlaylistRemoteDataSource.new);
  }

  static void _configureRepositories() {
    getIt.registerCachedFactory<PlaylistRepository>(DefaultPlaylistRepository.new);
  }

  static void _configureUseCases() {
    getIt
      ..registerCachedFactory(DownloadPlaylistUseCase.new)
      ..registerCachedFactory(GetPlaylistsUseCase.new)
      ..registerCachedFactory(SavePlaylistsUseCase.new);
  }
}
