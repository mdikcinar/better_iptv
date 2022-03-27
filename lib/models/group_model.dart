import 'package:json_annotation/json_annotation.dart';

import 'base_model.dart';

part 'group_model.g.dart';

@JsonSerializable(explicitToJson: true)
class ChannelGroup extends BaseModel {
  String groupTitle;
  String? imgUrl;
  List<Episode> contentList;
  List<TvSerie> tvSerie;

  ChannelGroup({this.groupTitle = 'Other', this.imgUrl, this.contentList = const [], this.tvSerie = const []});

  @override
  bool operator ==(Object other) => other is ChannelGroup && other.groupTitle == groupTitle;

  @override
  int get hashCode => groupTitle.length;

  factory ChannelGroup.fromJson(Map<String, dynamic> json) => _$ChannelGroupFromJson(json);
  @override
  ChannelGroup fromJson(Map<String, dynamic> json) {
    return _$ChannelGroupFromJson(json);
  }

  @override
  Map<String, Object?> toJson() {
    return _$ChannelGroupToJson(this);
  }
}

@JsonSerializable(explicitToJson: true)
class TvSerie extends BaseModel {
  String title;
  String? imgUrl;
  List<Season> seasons;
  TvSerie({required this.title, this.imgUrl, this.seasons = const []});
  @override
  bool operator ==(Object other) => other is TvSerie && other.title == title;

  @override
  int get hashCode => title.length;

  factory TvSerie.fromJson(Map<String, dynamic> json) => _$TvSerieFromJson(json);
  @override
  TvSerie fromJson(Map<String, dynamic> json) {
    return _$TvSerieFromJson(json);
  }

  @override
  Map<String, Object?> toJson() {
    return _$TvSerieToJson(this);
  }
}

@JsonSerializable(explicitToJson: true)
class Season extends BaseModel {
  String title;
  String? imgUrl;
  List<Episode> episodes;
  Season({required this.title, this.imgUrl, this.episodes = const []});
  @override
  bool operator ==(Object other) => other is Season && other.title == title;

  @override
  int get hashCode => title.length;
  factory Season.fromJson(Map<String, dynamic> json) => _$SeasonFromJson(json);
  @override
  Season fromJson(Map<String, dynamic> json) {
    return _$SeasonFromJson(json);
  }

  @override
  Map<String, Object?> toJson() {
    return _$SeasonToJson(this);
  }
}

@JsonSerializable()
class Episode extends BaseModel {
  String title;
  String? imgUrl;
  String? link;
  Episode({required this.title, this.imgUrl, this.link});
  factory Episode.fromJson(Map<String, dynamic> json) => _$EpisodeFromJson(json);
  @override
  Episode fromJson(Map<String, dynamic> json) {
    return _$EpisodeFromJson(json);
  }

  @override
  Map<String, Object?> toJson() {
    return _$EpisodeToJson(this);
  }
}
