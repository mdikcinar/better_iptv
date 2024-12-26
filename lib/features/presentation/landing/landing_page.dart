import 'package:betteriptv/core/widgets/empty_state_widget.dart';
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
                padding: EdgeInsets.zero,
                onPressed: () => onTapAddPlaylist(context),
                child: const Text('Add playlist'),
              ),
            ),
            child: BlocBuilder<LandingCubit, LandingState>(
              builder: (context, state) {
                switch (state) {
                  case LandingInitial():
                    return const EmptyStateWidget(
                      message: 'No playlists added yet',
                      icon: CupertinoIcons.play,
                    );
                  case LandingLoading():
                    return const Center(child: CircularProgressIndicator());
                  case LandingFailure(failure: final failure):
                    return Center(child: Text(failure.message));
                  case LandingSuccess(playlists: final playlists):
                    if (playlists.isEmpty) {
                      return const EmptyStateWidget(
                        message: 'No playlists added yet',
                        icon: CupertinoIcons.play_arrow,
                      );
                    }
                    return SafeArea(
                      child: GridView.builder(
                        padding: const EdgeInsets.all(16),
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 16,
                          mainAxisSpacing: 16,
                          childAspectRatio: 1.2,
                        ),
                        itemCount: playlists.length,
                        itemBuilder: (context, index) {
                          final playlist = playlists[index];
                          return _PlaylistCard(
                            playlist: playlist,
                            onTap: () => context.go('/home', extra: playlist),
                            onEdit: () => onTapEditPlaylist(context, playlist),
                            onDelete: () => onTapDeletePlaylist(context, playlist),
                          );
                        },
                      ),
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
    final nameController = TextEditingController();
    final urlController = TextEditingController();

    final result = await showCupertinoDialog<(String, String)?>(
      context: context,
      builder: (context) {
        return CupertinoAlertDialog(
          title: const Text('Add playlist'),
          content: Column(
            children: [
              const SizedBox(height: 16),
              CupertinoTextField(
                controller: nameController,
                placeholder: 'Enter playlist name',
              ),
              const SizedBox(height: 8),
              CupertinoTextField(
                controller: urlController,
                placeholder: 'Enter playlist URL',
              ),
            ],
          ),
          actions: [
            CupertinoDialogAction(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            CupertinoDialogAction(
              onPressed: () {
                if (nameController.text.isNotEmpty && urlController.text.isNotEmpty) {
                  Navigator.of(context).pop((nameController.text, urlController.text));
                }
              },
              child: const Text('Add'),
            ),
          ],
        );
      },
    );

    if (context.mounted && result != null) {
      final (name, url) = result;
      final playlist = Playlist(name: name, url: url);
      await context.read<LandingCubit>().addPlaylist(playlist);
    }

    nameController.dispose();
    urlController.dispose();
  }

  Future<void> onTapEditPlaylist(BuildContext context, Playlist playlist) async {
    final nameController = TextEditingController(text: playlist.name);
    final urlController = TextEditingController(text: playlist.url);

    final result = await showCupertinoDialog<(String, String)?>(
      context: context,
      builder: (context) {
        return CupertinoAlertDialog(
          title: const Text('Edit playlist'),
          content: Column(
            children: [
              const SizedBox(height: 16),
              CupertinoTextField(
                controller: nameController,
                placeholder: 'Enter playlist name',
              ),
              const SizedBox(height: 8),
              CupertinoTextField(
                controller: urlController,
                placeholder: 'Enter playlist URL',
              ),
            ],
          ),
          actions: [
            CupertinoDialogAction(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            CupertinoDialogAction(
              onPressed: () {
                if (nameController.text.isNotEmpty && urlController.text.isNotEmpty) {
                  Navigator.of(context).pop((nameController.text, urlController.text));
                }
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );

    if (context.mounted && result != null) {
      final (name, url) = result;
      final updatedPlaylist = playlist.copyWith(name: name, url: url);
      await context.read<LandingCubit>().updatePlaylist(updatedPlaylist);
    }

    nameController.dispose();
    urlController.dispose();
  }

  Future<void> onTapDeletePlaylist(BuildContext context, Playlist playlist) async {
    final result = await showCupertinoDialog<bool>(
      context: context,
      builder: (context) {
        return CupertinoAlertDialog(
          title: const Text('Delete playlist'),
          content: Text('Are you sure you want to delete "${playlist.name}"?'),
          actions: [
            CupertinoDialogAction(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text('Cancel'),
            ),
            CupertinoDialogAction(
              isDestructiveAction: true,
              onPressed: () => Navigator.of(context).pop(true),
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );

    if (context.mounted && result == true) {
      await context.read<LandingCubit>().deletePlaylist(playlist);
    }
  }
}

class _PlaylistCard extends StatelessWidget {
  const _PlaylistCard({
    required this.playlist,
    required this.onTap,
    required this.onEdit,
    required this.onDelete,
  });

  final Playlist playlist;
  final VoidCallback onTap;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: CupertinoColors.systemBackground,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: CupertinoColors.systemGrey.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(12),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      playlist.name,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  CupertinoButton(
                    padding: EdgeInsets.zero,
                    onPressed: () {
                      showCupertinoModalPopup(
                        context: context,
                        builder: (context) {
                          return CupertinoActionSheet(
                            actions: [
                              CupertinoActionSheetAction(
                                onPressed: () {
                                  Navigator.pop(context);
                                  onEdit();
                                },
                                child: const Text('Edit'),
                              ),
                              CupertinoActionSheetAction(
                                isDestructiveAction: true,
                                onPressed: () {
                                  Navigator.pop(context);
                                  onDelete();
                                },
                                child: const Text('Delete'),
                              ),
                            ],
                            cancelButton: CupertinoActionSheetAction(
                              onPressed: () => Navigator.pop(context),
                              child: const Text('Cancel'),
                            ),
                          );
                        },
                      );
                    },
                    child: const Icon(
                      CupertinoIcons.ellipsis,
                      size: 20,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Text(
                playlist.url,
                style: TextStyle(
                  fontSize: 14,
                  color: CupertinoColors.systemGrey.withOpacity(0.8),
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
