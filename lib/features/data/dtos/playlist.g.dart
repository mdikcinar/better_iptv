// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'playlist.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Playlist _$PlaylistFromJson(Map<String, dynamic> json) => Playlist(
      url: json['url'] as String,
      name: json['name'] as String?,
      entries: (json['entries'] as List<dynamic>?)
          ?.map((e) => ChannelGroup.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$PlaylistToJson(Playlist instance) => <String, dynamic>{
      'name': instance.name,
      'url': instance.url,
      'entries': instance.entries,
    };
