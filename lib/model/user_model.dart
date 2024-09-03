// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String? uid;
  String email;
  String name;
  Timestamp createAt;
  UserModel({
    this.uid,
    required this.email,
    required this.name,
    required this.createAt,
  });
  Map<String, dynamic> UserToMap() {
    return {'email': email, 'name': name, 'createAt': createAt};
  }

  factory UserModel.fromJson(Map<String, dynamic> userfromJson, String uid) {
    return UserModel(
        uid: uid,
        email: userfromJson['email'],
        name: userfromJson['name'] ?? '',
        createAt: userfromJson['createAt']);
  }
}
