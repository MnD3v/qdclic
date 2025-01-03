// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:my_widgets/data/other/collections.dart';
import 'package:my_widgets/my_widgets.dart';

class Utilisateur {
  double points;
  int heuresTotal;
  String nom;
  String prenom;
  String? classe;
  String? token;
  String password;
  String? formation;
  String telephone_id;
  Utilisateur({
    required this.points,
    required this.heuresTotal,
    required this.nom,
    required this.prenom,
    required this.classe,
    this.token,
    required this.password,
    this.formation,
    required this.telephone_id,
  });

  Utilisateur copyWith({
    bool? admin,
    double? points,
    bool? formateur,
    int? heuresTotal,
    String? nom,
    String? prenom,
    String? classe,
    String? country,
    String? token,
    String? password,
    String? formation,
    String? telephone_id,
  }) {
    return Utilisateur(
      points: points ?? this.points,
      heuresTotal: heuresTotal ?? this.heuresTotal,
      nom: nom ?? this.nom,
      prenom: prenom ?? this.prenom,
      classe: classe ?? this.classe,
      token: token ?? this.token,
      password: password ?? this.password,
      formation: formation ?? this.formation,
      telephone_id: telephone_id ?? this.telephone_id,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'points': points,
      'heuresTotal': heuresTotal,
      'nom': nom,
      'prenom': prenom,
      'classe': classe,
      'token': token,
      'password': password,
      'formation': formation,
      'telephone_id': telephone_id,
    };
  }

  factory Utilisateur.fromMap(Map<String, dynamic> map) {
    return Utilisateur(
      points: map['points'].toDouble(),
      heuresTotal: map['heuresTotal'] ?? 0,
      nom: map['nom'] as String,
      prenom: map['prenom'] as String,
      classe: map['classe'] != null ? map['classe'] as String : null,
      token: map['token'] != null ? map['token'] as String : null,
      password: map['password'] as String,
      formation: map['formation'] != null ? map['formation'] as String : null,
      telephone_id: map['telephone_id'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Utilisateur.fromJson(String source) =>
      Utilisateur.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Utilisateur( points: $points,  heuresTotal: $heuresTotal, nom: $nom, prenom: $prenom, classe: $classe, token: $token, password: $password, formation: $formation, telephone_id: $telephone_id)';
  }

  @override
  bool operator ==(covariant Utilisateur other) {
    if (identical(this, other)) return true;

    return other.points == points &&
        other.heuresTotal == heuresTotal &&
        other.nom == nom &&
        other.prenom == prenom &&
        other.classe == classe &&
        other.token == token &&
        other.password == password &&
        other.formation == formation &&
        other.telephone_id == telephone_id;
  }

  @override
  int get hashCode {
    return points.hashCode ^
        heuresTotal.hashCode ^
        nom.hashCode ^
        prenom.hashCode ^
        classe.hashCode ^
        token.hashCode ^
        password.hashCode ^
        formation.hashCode ^
        telephone_id.hashCode;
  }

  static Utilisateur get empty {
    const nullString = 'null';
    return Utilisateur(
        heuresTotal: 0,
        points: 0.0,
        classe: null,
        password: nullString,
        nom: nullString,
        prenom: nullString,
        telephone_id: nullString);
  }

  static Future<void> setUser(Utilisateur user, {bool? notSetUser}) async {
    if (notSetUser != true) {
      Utilisateur.currentUser.value = user;
    }
    await DB

        .firestore(Collections.utilistateurs)
        .doc(user.telephone_id)
        .set(user.toMap());

    await DB
        .firestore(Collections.classes)
        .doc(user.classe)
        .collection(Collections.utilistateurs)
        .doc(user.telephone_id)
        .set(user.toMap());
  }

  static Future<void> getUser(String email) async {
    var numero = email.split('@')[0];
    var q = await DB.firestore(Collections.utilistateurs).doc(numero).get();
    Utilisateur.currentUser.value = Utilisateur.fromMap(q.data()!);
    try {
      var token = await FirebaseMessaging.instance.getToken();
      currentUser.value?.token = token;
    } catch (e) {}
    setUser(currentUser.value!);
  }

  static refreshToken() async {
    var token = await FirebaseMessaging.instance.getToken();
    currentUser.value?.token = token;
    currentUser.value == null ? null : setUser(currentUser.value!);
    print("token $token");
  }

  static var currentUser = Rx<Utilisateur?>(null);
}
