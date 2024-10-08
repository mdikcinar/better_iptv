import 'package:betteriptv/features/data/dtos/content/channel_group.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'playlist.g.dart';

@JsonSerializable()
class Playlist extends Equatable {
  const Playlist({
    required this.url,
    this.name,
    this.entries,
  });

  factory Playlist.fromJson(Map<String, dynamic> json) => _$PlaylistFromJson(json);

  final String? name;
  final String url;
  final List<ChannelGroup>? entries;

  Map<String, dynamic> toJson() => _$PlaylistToJson(this);

  Playlist copyWith({
    String? name,
    String? url,
    List<ChannelGroup>? entries,
  }) {
    return Playlist(
      name: name ?? this.name,
      url: url ?? this.url,
      entries: entries ?? this.entries,
    );
  }

  @override
  List<Object?> get props => [
        name,
        url,
        entries,
      ];
}
