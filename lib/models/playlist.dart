import 'package:json_annotation/json_annotation.dart';

import 'base_model.dart';

part 'playlist.g.dart';

@JsonSerializable()
class Playlist extends BaseModel {
  String id;
  String? name;
  String url;

  Playlist({required this.id, this.name, required this.url});
  factory Playlist.fromJson(Map<String, dynamic> json) => _$PlaylistFromJson(json);
  @override
  Playlist fromJson(Map<String, dynamic> json) {
    return _$PlaylistFromJson(json);
  }

  @override
  Map<String, Object?> toJson() {
    return _$PlaylistToJson(this);
  }
}
