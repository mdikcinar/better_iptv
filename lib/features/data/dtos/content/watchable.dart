import 'package:betteriptv/features/data/dtos/content/m3u_item.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'watchable.g.dart';

@JsonSerializable()
class Watchable extends M3uItem with EquatableMixin {
  const Watchable({
    required super.title,
    required this.url,
    super.logoUrl,
  });

  factory Watchable.fromJson(Map<String, dynamic> json) => _$WatchableFromJson(json);

  final String url;

  Map<String, dynamic> toJson() => _$WatchableToJson(this);

  @override
  List<Object?> get props => [
        title,
        url,
        logoUrl,
      ];
}
