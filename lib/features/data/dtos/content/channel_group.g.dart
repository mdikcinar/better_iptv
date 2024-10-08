// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'channel_group.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChannelGroup _$ChannelGroupFromJson(Map<String, dynamic> json) => ChannelGroup(
      title: json['title'] as String,
      logoUrl: json['logoUrl'] as String?,
      contentList: (json['contentList'] as List<dynamic>?)
              ?.map((e) => Watchable.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      tvSeries: (json['tvSeries'] as List<dynamic>?)
              ?.map((e) => Watchable.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$ChannelGroupToJson(ChannelGroup instance) =>
    <String, dynamic>{
      'title': instance.title,
      'logoUrl': instance.logoUrl,
      'contentList': instance.contentList,
      'tvSeries': instance.tvSeries,
    };
