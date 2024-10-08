part of 'landing_cubit.dart';

sealed class LandingState extends BaseState {
  const LandingState();

  @override
  List<Object> get props => [];
}

class LandingInitial extends LandingState {
  const LandingInitial();
}

class LandingLoading extends LandingState {
  const LandingLoading();
}

class LandingSuccess extends LandingState {
  const LandingSuccess(this.playlists);
  final List<Playlist> playlists;

  @override
  List<Object> get props => [playlists];
}

class LandingFailure extends LandingState {
  const LandingFailure(this.failure);
  final Failure failure;

  @override
  List<Object> get props => [failure];
}
