// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:my_widgets/data/models/ardoise_question.dart';
import 'package:my_widgets/data/models/formateur.dart';
import 'package:my_widgets/data/models/maked.dart';
import 'package:my_widgets/data/models/question.dart';
import 'package:my_widgets/data/models/utilisateur.dart';
import 'package:my_widgets/data/other/collections.dart';
import 'package:my_widgets/others/db.dart';

class Questionnaire {
  String id;
  String date;
  String title;
  Map<String, Maked> maked;
  List<Question> questions;
  Questionnaire({
    required this.id,
    required this.date,
    required this.title,
    required this.maked,
    required this.questions,
  });

  Questionnaire copyWith({
    String? id,
    String? date,
    String? title,
    Map<String, Maked>? maked,
    List<Question>? questions,
  }) {
    return Questionnaire(
      id: id ?? this.id,
      date: date ?? this.date,
      title: title ?? this.title,
      maked: maked ?? this.maked,
      questions: questions ?? this.questions,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'date': date,
      'title': title,
      'maked': maked.map((key, value) => MapEntry(key, value.toMap())),
      'questions': questions.map((x) => x.toMap()).toList(),
    };
  }

  static Future<Questionnaire> fromMap(Map<String, dynamic> map,
      {required String classe,bool? brouillon, String? oneIdMaked, bool? noMaked}) async {
    
  
    CollectionReference<Map<String, dynamic>> collectionReference;
    if (brouillon == true) {
      collectionReference = DB
          .firestore(Collections.classes)
          .doc(classe)
          .collection(Collections.questionnaires)
          .doc(classe)
          .collection(Collections.brouillon);
    } else {
      collectionReference = DB
          .firestore(Collections.classes)
          .doc(classe)
          .collection(Collections.questionnaires)
          .doc(classe)
          .collection(Collections.production);
    }

    Map<String, Maked> tempMaked = {};
    if (noMaked == true) {
      //one ne recupere pas les maked
    } else if (oneIdMaked != null) {
      var q = await collectionReference
          .doc(map["id"])
          .collection(Collections.maked)
          .doc(oneIdMaked)
          .get();
      q.data() == null
          ? null
          : tempMaked.putIfAbsent(q.id, () => Maked.fromMap(q.data()!));
    } else {
      var q = await collectionReference
          .doc(map["id"])
          .collection(Collections.maked)
          .get();
      for (var element in q.docs) {
        tempMaked.putIfAbsent(element.id, () => Maked.fromMap(element.data()));
      }
    }

    return Questionnaire(
      id: map['id'],
      date: map['date'] as String,
      title: map['title'] as String,
      maked: tempMaked,
      questions: List<Question>.from(
        (map['questions']).map<Question>(
          (x) => Question.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  @override
  String toString() {
    return 'Questionnaire(id: $id, date: $date, title: $title, maked: $maked, questions: $questions)';
  }

  @override
  bool operator ==(covariant Questionnaire other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.date == date &&
        other.title == title &&
        mapEquals(other.maked, maked) &&
        listEquals(other.questions, questions);
  }

  @override
  int get hashCode {
    return id.hashCode ^
        date.hashCode ^
        title.hashCode ^
        maked.hashCode ^
        questions.hashCode;
  }

  toProduction(classe) {
    save(brouillon: false,  classe: classe);
    delete(brouillon: true, classe: classe);
  }

  delete({required bool brouillon, required classe}) {

    CollectionReference<Map<String, dynamic>> collectionReference;
    if (brouillon == true) {
      collectionReference = DB
          .firestore(Collections.classes)
          .doc(classe)
          .collection(Collections.questionnaires)
          .doc(classe)
          .collection(Collections.brouillon);
    } else {
      collectionReference = DB
          .firestore(Collections.classes)
          .doc(classe)
          .collection(Collections.questionnaires)
          .doc(classe)
          .collection(Collections.production);
    }
    collectionReference.doc(id).delete();
  }

  save({required bool brouillon,required classe}) {


    CollectionReference<Map<String, dynamic>> collectionReference;
    if (brouillon == true) {
      collectionReference = DB
          .firestore(Collections.classes)
          .doc(classe)
          .collection(Collections.questionnaires)
          .doc(classe)
          .collection(Collections.brouillon);
    } else {
      collectionReference = DB
          .firestore(Collections.classes)
          .doc(classe)
          .collection(Collections.questionnaires)
          .doc(classe)
          .collection(Collections.production);
    }
    collectionReference.doc(id).set({
      "id": id,
      "title": title,
      "date": date,
      "questions": questions.map((x) => x.toMap()).toList()
    });

    for (var element in maked.keys) {
      collectionReference
          .doc(id)
          .collection(Collections.maked)
          .doc(element)
          .set(maked[element]!.toMap());
    }
  }
}
