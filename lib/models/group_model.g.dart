// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'group_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChannelGroup _$ChannelGroupFromJson(Map<String, dynamic> json) => ChannelGroup(
      groupTitle: json['groupTitle'] as String? ?? 'Other',
      imgUrl: json['imgUrl'] as String?,
      contentList: (json['contentList'] as List<dynamic>?)
              ?.map((e) => Episode.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      tvSerie: (json['tvSerie'] as List<dynamic>?)
              ?.map((e) => TvSerie.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$ChannelGroupToJson(ChannelGroup instance) =>
    <String, dynamic>{
      'groupTitle': instance.groupTitle,
      'imgUrl': instance.imgUrl,
      'contentList': instance.contentList.map((e) => e.toJson()).toList(),
      'tvSerie': instance.tvSerie.map((e) => e.toJson()).toList(),
    };

TvSerie _$TvSerieFromJson(Map<String, dynamic> json) => TvSerie(
      title: json['title'] as String,
      imgUrl: json['imgUrl'] as String?,
      seasons: (json['seasons'] as List<dynamic>?)
              ?.map((e) => Season.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$TvSerieToJson(TvSerie instance) => <String, dynamic>{
      'title': instance.title,
      'imgUrl': instance.imgUrl,
      'seasons': instance.seasons.map((e) => e.toJson()).toList(),
    };

Season _$SeasonFromJson(Map<String, dynamic> json) => Season(
      title: json['title'] as String,
      imgUrl: json['imgUrl'] as String?,
      episodes: (json['episodes'] as List<dynamic>?)
              ?.map((e) => Episode.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$SeasonToJson(Season instance) => <String, dynamic>{
      'title': instance.title,
      'imgUrl': instance.imgUrl,
      'episodes': instance.episodes.map((e) => e.toJson()).toList(),
    };

Episode _$EpisodeFromJson(Map<String, dynamic> json) => Episode(
      title: json['title'] as String,
      imgUrl: json['imgUrl'] as String?,
      link: json['link'] as String?,
    );

Map<String, dynamic> _$EpisodeToJson(Episode instance) => <String, dynamic>{
      'title': instance.title,
      'imgUrl': instance.imgUrl,
      'link': instance.link,
    };
