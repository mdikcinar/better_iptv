import 'package:betteriptv/core/models/cubit/base_cubit.dart';
import 'package:betteriptv/core/models/failure.dart';
import 'package:betteriptv/di_manager.dart';
import 'package:betteriptv/features/data/dtos/playlist.dart';
import 'package:betteriptv/features/domain/use_cases/use_cases.dart';

part 'landing_state.dart';

class LandingCubit extends BaseCubit<LandingState> {
  LandingCubit({
    GetPlaylistsUseCase? getPlaylistUseCase,
    SavePlaylistsUseCase? savePlaylistsUseCase,
  })  : _getPlaylistUseCase = getPlaylistUseCase ?? getIt.get<GetPlaylistsUseCase>(),
        _savePlaylistsUseCase = savePlaylistsUseCase ?? getIt.get<SavePlaylistsUseCase>(),
        super(const LandingInitial()) {
    _getPlaylists();
  }

  final GetPlaylistsUseCase _getPlaylistUseCase;
  final SavePlaylistsUseCase _savePlaylistsUseCase;

  Future<void> _getPlaylists() async {
    emit(const LandingLoading());
    final result = await _getPlaylistUseCase();
    result.fold(
      (failure) => emit(LandingFailure(failure)),
      (playlists) => emit(LandingSuccess(playlists)),
    );
  }

  Future<void> _savePlaylists(List<Playlist> playlists) async {
    await _savePlaylistsUseCase(playlists);
  }

  Future<void> addPlaylist(Playlist playlist) async {
    final currentState = state;
    if (currentState is LandingSuccess) {
      final newPlaylists = List<Playlist>.from(currentState.playlists)..add(playlist);
      emit(LandingSuccess(newPlaylists));
      await _savePlaylists(newPlaylists);
    }
  }

  Future<void> updatePlaylist(Playlist playlist) async {
    final currentState = state;
    if (currentState is LandingSuccess) {
      final newPlaylists = currentState.playlists.map((e) => e.url == playlist.url ? playlist : e).toList();
      emit(LandingSuccess(newPlaylists));
      await _savePlaylists(newPlaylists);
    }
  }
}
