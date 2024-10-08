// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'watchable.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Watchable _$WatchableFromJson(Map<String, dynamic> json) => Watchable(
      title: json['title'] as String,
      url: json['url'] as String,
      logoUrl: json['logoUrl'] as String?,
    );

Map<String, dynamic> _$WatchableToJson(Watchable instance) => <String, dynamic>{
      'title': instance.title,
      'logoUrl': instance.logoUrl,
      'url': instance.url,
    };
