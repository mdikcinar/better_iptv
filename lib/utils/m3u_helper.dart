import 'package:betteriptv/features/data/dtos/content/channel_group.dart';
import 'package:betteriptv/features/data/dtos/content/watchable.dart';
import 'package:betteriptv/features/data/dtos/m3u_entry.dart';
import 'package:m3u/m3u.dart';

class M3uHelper {
  const M3uHelper._();

  static Future<List<M3uEntry>> parse(String source) async {
    final result = await M3uParser.parse(source);
    return result.map(M3uEntry.fromM3uGenericEntry).toList();
  }

  static List<ChannelGroup> groupM3uEntries(List<M3uEntry> entries) {
    // Map to hold grouped entries by groupTitle
    final groupedEntries = <String, List<M3uEntry>>{};

    for (final entry in entries) {
      // If the entry doesn't have a groupTitle, assign it to a default group
      final groupTitle = entry.groupTitle ?? 'Default Group';

      // If groupTitle does not exist in the map, initialize an empty list
      if (!groupedEntries.containsKey(groupTitle)) {
        groupedEntries[groupTitle] = [];
      }

      // Add the entry to the corresponding group
      groupedEntries[groupTitle]!.add(entry);
    }

    // Convert the grouped entries to a list of ChannelGroup
    return groupedEntries.entries.map((entry) {
      final groupTitle = entry.key;
      final m3uEntries = entry.value;

      // Map M3uEntry to Watchable (assuming Watchable can be constructed from M3uEntry)
      final contentList = m3uEntries
          .map(
            (e) => Watchable(
              title: e.title,
              url: e.url,
              logoUrl: e.logoUrl,
            ),
          )
          .toList();

      return ChannelGroup(
        title: groupTitle,
        logoUrl: contentList.isNotEmpty ? contentList.first.logoUrl : null,
        contentList: contentList,
      );
    }).toList();
  }
}
