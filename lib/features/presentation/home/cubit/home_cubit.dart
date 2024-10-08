import 'package:betteriptv/core/models/nullable.dart';
import 'package:betteriptv/di_manager.dart';
import 'package:betteriptv/features/data/dtos/content/channel_group.dart';
import 'package:betteriptv/features/data/dtos/playlist.dart';
import 'package:betteriptv/features/domain/use_cases/download_playlist_use_case.dart';
import 'package:betteriptv/features/domain/use_cases/use_cases.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit({
    required Playlist playlist,
    DownloadPlaylistUseCase? downloadPlaylistUseCase,
  })  : _downloadPlaylistUseCase = downloadPlaylistUseCase ?? getIt.get<DownloadPlaylistUseCase>(),
        super(
          HomeState.initial(
            playlist: playlist,
          ),
        ) {
    if (playlist.entries == null || playlist.entries!.isEmpty) {
      downloadPlaylist();
    }
  }

  final DownloadPlaylistUseCase _downloadPlaylistUseCase;

  Future<void> downloadPlaylist() async {
    emit(state.copyWith(status: HomeStatus.loading));
    final result = await _downloadPlaylistUseCase(state.playlist);

    result.fold(
      (error) => emit(
        state.copyWith(
          playlist: state.playlist,
          error: error.toString(),
          status: HomeStatus.error,
        ),
      ),
      (playlist) => emit(
        state.copyWith(
          playlist: playlist,
          status: HomeStatus.loaded,
        ),
      ),
    );
  }

  void selectChannelGroup(ChannelGroup? channelGroup) {
    emit(state.copyWith(selectedChannelGroup: Nullable(channelGroup)));
  }
}
