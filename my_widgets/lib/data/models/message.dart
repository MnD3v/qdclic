// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Message {
  String categorie;
  String date;
  String message;
  String? contact;
  String? id;
  Message({
    required this.categorie,
    required this.date,
    required this.message,
    this.contact,
    required this.id,
  });

  Message copyWith({
    String? categorie,
    String? date,
    String? message,
    String? contact,
    String? id,
  }) {
    return Message(
      categorie: categorie ?? this.categorie,
      date: date ?? this.date,
      message: message ?? this.message,
      contact: contact ?? this.contact,
      id: id ?? this.id,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'categorie': categorie,
      'date': date,
      'message': message,
      'contact': contact,
      'id': id,
    };
  }

  factory Message.fromMap(Map<String, dynamic> map) {
    return Message(
      categorie: map['categorie'] as String,
      date: map['date'] as String,
      message: map['message'] as String,
      contact: map['contact'] != null ? map['contact'] as String : null,
      id: map['id'] != null ? map['id'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Message.fromJson(String source) => Message.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Message(categorie: $categorie, date: $date, message: $message, contact: $contact, id: $id)';
  }

  @override
  bool operator ==(covariant Message other) {
    if (identical(this, other)) return true;
  
    return 
      other.categorie == categorie &&
      other.date == date &&
      other.message == message &&
      other.contact == contact &&
      other.id == id;
  }

  @override
  int get hashCode {
    return categorie.hashCode ^
      date.hashCode ^
      message.hashCode ^
      contact.hashCode ^
      id.hashCode;
  }
}
