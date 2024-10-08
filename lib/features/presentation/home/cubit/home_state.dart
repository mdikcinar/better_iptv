part of 'home_cubit.dart';

class HomeState extends Equatable {
  const HomeState({
    required this.playlist,
    required this.status,
    required this.error,
    required this.selectedChannelGroup,
  });

  HomeState.initial({required this.playlist})
      : status = playlist.entries != null && playlist.entries!.isNotEmpty ? HomeStatus.loaded : HomeStatus.initial,
        error = null,
        selectedChannelGroup = const Nullable.empty();

  final Playlist playlist;
  final HomeStatus status;
  final String? error;
  final Nullable<ChannelGroup?> selectedChannelGroup;

  @override
  List<Object?> get props => [
        playlist,
        status,
        error,
        selectedChannelGroup,
      ];

  HomeState copyWith({
    Playlist? playlist,
    HomeStatus? status,
    String? error,
    Nullable<ChannelGroup?>? selectedChannelGroup,
  }) {
    return HomeState(
      playlist: playlist ?? this.playlist,
      status: status ?? this.status,
      error: error ?? this.error,
      selectedChannelGroup: selectedChannelGroup ?? this.selectedChannelGroup,
    );
  }
}

enum HomeStatus { initial, loading, loaded, error }
