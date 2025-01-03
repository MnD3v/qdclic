// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:my_widgets/data/other/collections.dart';
import 'package:my_widgets/my_widgets.dart';

class Formateur {
  bool admin;
  bool? formateur;
  String nom;
  String prenom;
  String? classe;
  String? token;
  String password;
  String telephone_id;
  Formateur({
    required this.admin,
    this.formateur,
    required this.nom,
    required this.prenom,
    required this.classe,
    this.token,
    required this.password,
    required this.telephone_id,
  });

  Formateur copyWith({
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
    return Formateur(
      admin: admin ?? this.admin,
      formateur: formateur ?? this.formateur,
      nom: nom ?? this.nom,
      prenom: prenom ?? this.prenom,
      classe: classe ?? this.classe,
      token: token ?? this.token,
      password: password ?? this.password,
      telephone_id: telephone_id ?? this.telephone_id,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'admin': admin,
      'formateur': formateur,
      'nom': nom,
      'prenom': prenom,
      'classe': classe,
      'token': token,
      'password': password,
      'telephone_id': telephone_id,
    };
  }

  factory Formateur.fromMap(Map<String, dynamic> map) {
    return Formateur(
      admin: map['admin'] ?? false,
      formateur: map['formateur'] != null ? map['formateur'] as bool : null,
      nom: map['nom'] as String,
      prenom: map['prenom'] as String,
      classe: map['classe'] != null ? map['classe'] as String : null,
      token: map['token'] != null ? map['token'] as String : null,
      password: map['password'] as String,
      telephone_id: map['telephone_id'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Formateur.fromJson(String source) =>
      Formateur.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Formateur(admin: $admin,  formateur: $formateur,  nom: $nom, prenom: $prenom, classe: $classe,  token: $token, password: $password, telephone_id: $telephone_id)';
  }

  @override
  bool operator ==(covariant Formateur other) {
    if (identical(this, other)) return true;

    return other.admin == admin &&
        other.formateur == formateur &&
        other.nom == nom &&
        other.prenom == prenom &&
        other.classe == classe &&
        other.token == token &&
        other.password == password &&
        other.telephone_id == telephone_id;
  }

  @override
  int get hashCode {
    return admin.hashCode ^
        formateur.hashCode ^
        nom.hashCode ^
        prenom.hashCode ^
        classe.hashCode ^
        token.hashCode ^
        password.hashCode ^
        telephone_id.hashCode;
  }

  static Formateur get empty {
    const nullString = 'null';
    return Formateur(
        admin: false,
        classe: null,
        password: nullString,
        nom: nullString,
        prenom: nullString,
        telephone_id: nullString);
  }

  static Future<void> setUser(Formateur user, {bool? notSetUser}) async {
    if (notSetUser != true) {
      Formateur.currentUser.value = user;
    }
    await DB
        .firestore(Collections.formateurs)
        .doc(user.telephone_id)
        .set(user.toMap());
 
  }

  static Future<void> getUser(String email) async {
    var numero = email.split('@')[0];
    var q = await DB.firestore(Collections.formateurs).doc(numero).get();
    Formateur.currentUser.value = Formateur.fromMap(q.data()!);
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

  static var currentUser = Rx<Formateur?>(null);
}
