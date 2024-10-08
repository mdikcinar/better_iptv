import 'package:betteriptv/features/data/dtos/content/m3u_item.dart';
import 'package:betteriptv/features/data/dtos/content/watchable.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'channel_group.g.dart';

@JsonSerializable()
class ChannelGroup extends M3uItem with EquatableMixin {
  const ChannelGroup({
    required super.title,
    super.logoUrl,
    this.contentList = const [],
    this.tvSeries = const [],
  });

  factory ChannelGroup.fromJson(Map<String, dynamic> json) => _$ChannelGroupFromJson(json);

  final List<Watchable> contentList;
  final List<Watchable> tvSeries;

  Map<String, dynamic> toJson() => _$ChannelGroupToJson(this);

  @override
  List<Object?> get props => [
        title,
        logoUrl,
        contentList,
        tvSeries,
      ];
}
