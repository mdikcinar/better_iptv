import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:m3u/m3u.dart';

part 'm3u_entry.g.dart';

class M3uEntry extends Equatable {
  const M3uEntry({
    required this.title,
    required this.url,
    this.logoUrl,
    this.tvgId,
    this.tvgName,
    this.groupTitle,
  });

  factory M3uEntry.fromM3uGenericEntry(M3uGenericEntry entry) {
    final attributes = M3uGenericAttributes.fromJson(entry.attributes);

    return M3uEntry(
      title: entry.title,
      url: entry.link,
      logoUrl: attributes.tvgLogo,
      tvgId: attributes.tvgId,
      tvgName: attributes.tvgName,
      groupTitle: attributes.groupTitle,
    );
  }

  final String title;
  final String url;
  final String? tvgId;
  final String? tvgName;
  final String? logoUrl;
  final String? groupTitle;

  @override
  List<Object?> get props => [
        title,
        url,
        logoUrl,
        tvgId,
        tvgName,
        groupTitle,
      ];
}

@JsonSerializable(createToJson: false)
class M3uGenericAttributes {
  const M3uGenericAttributes({
    this.tvgId,
    this.tvgName,
    this.tvgLogo,
    this.groupTitle,
  });

  factory M3uGenericAttributes.fromJson(Map<String, dynamic> json) => _$M3uGenericAttributesFromJson(json);

  @JsonKey(name: 'tvg-id')
  final String? tvgId;
  @JsonKey(name: 'tvg-name')
  final String? tvgName;
  @JsonKey(name: 'tvg-logo')
  final String? tvgLogo;
  @JsonKey(name: 'group-title')
  final String? groupTitle;
}
