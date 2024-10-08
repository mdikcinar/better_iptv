import 'package:betteriptv/di_manager.dart';
import 'package:betteriptv/features/data/dtos/playlist.dart';
import 'package:betteriptv/features/presentation/landing/cubit/landing_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  final _cubit = LandingCubit();

  @override
  void initState() {
    getIt.registerSingleton(_cubit);
    super.initState();
  }

  @override
  void dispose() {
    getIt.unregister(instance: _cubit);
    _cubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _cubit,
      child: Builder(
        builder: (context) {
          return CupertinoPageScaffold(
            navigationBar: CupertinoNavigationBar(
              middle: const Text('BetterIPTV'),
              trailing: CupertinoButton(
                onPressed: () => onTapAddPlaylist(context),
                child: const Text('Add playlist'),
              ),
            ),
            child: BlocBuilder<LandingCubit, LandingState>(
              builder: (context, state) {
                switch (state) {
                  case LandingInitial():
                    return const Center(child: Text('No playlists'));
                  case LandingLoading():
                    return const Center(child: CircularProgressIndicator());
                  case LandingFailure(failure: final failure):
                    return Center(child: Text(failure.message));
                  case LandingSuccess(playlists: final playlists):
                    return ListView.builder(
                      itemCount: playlists.length,
                      itemBuilder: (context, index) {
                        final playlist = playlists[index];
                        return CupertinoListTile(
                          title: Text(playlist.url),
                          onTap: () => context.go('/home', extra: playlist),
                        );
                      },
                    );
                }
              },
            ),
          );
        },
      ),
    );
  }

  Future<void> onTapAddPlaylist(BuildContext context) async {
    final textController = TextEditingController();
    final result = await showCupertinoDialog<String>(
      context: context,
      builder: (context) {
        return CupertinoAlertDialog(
          title: const Text('Add playlist'),
          content: CupertinoTextField(
            controller: textController,
            placeholder: 'Enter playlist URL',
          ),
          actions: [
            CupertinoDialogAction(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            CupertinoDialogAction(
              onPressed: () => Navigator.of(context).pop(textController.text),
              child: const Text('Add'),
            ),
          ],
        );
      },
    );
    if (context.mounted && result != null) {
      final playlist = Playlist(url: result);
      await context.read<LandingCubit>().addPlaylist(playlist);
    }
    textController.dispose();
  }
}
