import 'package:betteriptv/di_manager.dart';
import 'package:betteriptv/features/data/dtos/playlist.dart';
import 'package:betteriptv/features/presentation/home/cubit/home_cubit.dart';
import 'package:betteriptv/features/presentation/home/widgets/channel_group_view.dart';
import 'package:betteriptv/features/presentation/landing/cubit/landing_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({
    required this.playlist,
    super.key,
  });

  final Playlist playlist;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => HomeCubit(
        playlist: playlist,
      ),
      child: Builder(
        builder: (context) {
          return BlocConsumer<HomeCubit, HomeState>(
            listener: (context, state) {
              if (state.status == HomeStatus.loaded) {
                getIt.get<LandingCubit>().updatePlaylist(state.playlist);
              }
            },
            builder: (context, state) {
              return CupertinoPageScaffold(
                navigationBar: CupertinoNavigationBar(
                  leading: IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: () => state.selectedChannelGroup.value != null
                        ? context.read<HomeCubit>().selectChannelGroup(null)
                        : Navigator.of(context).pop(),
                  ),
                  //title: const Text('Better IpTV'),
                ),
                child: Builder(
                  builder: (context) {
                    switch (state.status) {
                      case HomeStatus.initial:
                        return const Center(
                          child: Text('Initial state'),
                        );
                      case HomeStatus.loading:
                        return const Center(
                          child: CupertinoActivityIndicator(),
                        );
                      case HomeStatus.error:
                        return Center(
                          child: Text(state.error ?? 'An error occurred'),
                        );
                      case HomeStatus.loaded:
                        if (state.playlist.entries == null) {
                          return const Center(
                            child: Text('No entries found'),
                          );
                        }

                        if (state.selectedChannelGroup.value != null) {
                          return ChannelGroupView(
                            channelGroup: state.selectedChannelGroup.value!,
                          );
                        }
                        return ListView.builder(
                          itemCount: state.playlist.entries!.length,
                          itemBuilder: (context, index) {
                            final entry = state.playlist.entries![index];
                            return CupertinoListTile(
                              onTap: () => context.read<HomeCubit>().selectChannelGroup(entry),
                              title: Text(entry.title),
                            );
                          },
                        );
                    }
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
