import 'dart:convert';

import 'package:collection/collection.dart';

class RealEntreprise {
  String nom;
  String id;
  String auteur;
  List<String> categories;
  RealEntreprise({
    required this.nom,
    required this.id,
    required this.auteur,
    required this.categories,
  });

  RealEntreprise copyWith({
    String? nom,
    String? id,
    String? auteur,
    List<String>? categories,
  }) {
    return RealEntreprise(
      nom: nom ?? this.nom,
      id: id ?? this.id,
      auteur: auteur ?? this.auteur,
      categories: categories ?? this.categories,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'nom': nom,
      'id': id,
      'auteur': auteur,
      'categories': categories,
    };
  }

  factory RealEntreprise.fromMap(Map<String, dynamic> map) {
    return RealEntreprise(
      nom: map['nom'] as String,
      id: map['id'] as String,
      auteur: map['auteur'] as String,
      categories: List<String>.from((map['categories'] as List<String>)),
    );
  }

  String toJson() => json.encode(toMap());

  factory RealEntreprise.fromJson(String source) => RealEntreprise.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'RealEntreprise(nom: $nom, id: $id, auteur: $auteur, categories: $categories)';
  }

  @override
  bool operator ==(covariant RealEntreprise other) {
    if (identical(this, other)) return true;
    final listEquals = const DeepCollectionEquality().equals;
  
    return 
      other.nom == nom &&
      other.id == id &&
      other.auteur == auteur &&
      listEquals(other.categories, categories);
  }

  @override
  int get hashCode {
    return nom.hashCode ^
      id.hashCode ^
      auteur.hashCode ^
      categories.hashCode;
  }
}
