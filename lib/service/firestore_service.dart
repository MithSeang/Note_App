import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:note_app/model/add_model.dart';

class FireStore_Service {
  final db = FirebaseFirestore.instance;

  void AddNotes(Add_Model note, String uid) async {
    await db.collection('users').doc(uid).collection('notes').add(note.toMap());
  }

  Stream<List<Add_Model>> getNote(String uid) {
    return db
        .collection('users')
        .doc(uid)
        .collection('notes')
        .orderBy('createAt', descending: true)
        .snapshots()
        .map((e) => e.docs
            .map((doc) => Add_Model.fromJson(doc.data(), doc.id))
            .toList());
  }

  void UpdateNote(Add_Model note, String uid) async {
    var update = await db
        .collection('users')
        .doc(uid)
        .collection('notes')
        .doc(note.id)
        .update(note.toMap());
  }

  void Delete(String id, String uid) async {
    var delete = await db
        .collection('users')
        .doc(uid)
        .collection('notes')
        .doc(id)
        .delete();
  }
}
