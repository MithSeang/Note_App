import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

final format = DateFormat.yMd().add_jms();

class Add_Model {
  String? id;
  String title;
  String description;
  DateTime createAt;
  Add_Model(
      {this.id,
      required this.title,
      required this.description,
      required this.createAt});

  Map<String, dynamic> toMap() {
    return {'title': title, 'description': description, 'createAt': createAt};
  }

  factory Add_Model.fromJson(Map<String, dynamic> map, String id) {
    return Add_Model(
        id: id,
        title: map['title'],
        description: map['description'],
        createAt: (map['createAt'] as Timestamp).toDate());
  }
  String get dateFormat {
    return format.format(createAt);
  }
}
