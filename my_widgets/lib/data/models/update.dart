// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Update {
  String version;
  bool? optionel;
  String? link;
  Update({
    required this.version,
    this.optionel,
    this.link,
  });

  Update copyWith({
    String? version,
    bool? optionel,
    String? link,
  }) {
    return Update(
      version: version ?? this.version,
      optionel: optionel ?? this.optionel,
      link: link ?? this.link,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'version': version,
      'optionel': optionel,
      'link': link,
    };
  }

  factory Update.fromMap(Map<String, dynamic> map) {
    return Update(
      version: map['version'] as String,
      optionel: map['optionel'] != null ? map['optionel'] as bool : null,
      link: map['link'] != null ? map['link'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Update.fromJson(String source) =>
      Update.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Update(version: $version, optionel: $optionel, link: $link)';

  @override
  bool operator ==(covariant Update other) {
    if (identical(this, other)) return true;
  
    return 
      other.version == version &&
      other.optionel == optionel &&
      other.link == link;
  }

  @override
  int get hashCode => version.hashCode ^ optionel.hashCode ^ link.hashCode;
}
