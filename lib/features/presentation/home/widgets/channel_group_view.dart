import 'package:betteriptv/features/data/dtos/content/channel_group.dart';
import 'package:betteriptv/features/presentation/video_player/video_player_page.dart';
import 'package:flutter/cupertino.dart';

class ChannelGroupView extends StatelessWidget {
  const ChannelGroupView({
    required this.channelGroup,
    super.key,
  });

  final ChannelGroup channelGroup;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: channelGroup.contentList.length,
      itemBuilder: (context, index) {
        final watchable = channelGroup.contentList[index];
        return CupertinoListTile(
          onTap: () =>
              Navigator.push(context, CupertinoPageRoute(builder: (context) => VideoPlayerPage(watchable: watchable))),
          title: Text(watchable.title),
          subtitle: Text(watchable.url),
        );
      },
    );
  }
}
