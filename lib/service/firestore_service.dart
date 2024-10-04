import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:note_app/model/add_model.dart';

class FireStore_Service {
  final db = FirebaseFirestore.instance;

  Future<void> AddNotes(Add_Model note, String uid) async {
    try {
      await db
          .collection('users')
          .doc(uid)
          .collection('notes')
          .add(note.toMap());
    } catch (e) {
      print("Error:$e");
    }
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

  Future<void> UpdateNote(Add_Model note, String uid) async {
    await db
        .collection('users')
        .doc(uid)
        .collection('notes')
        .doc(note.id)
        .update(note.toMap());
  }

  Future<void> Delete(String id, String uid) async {
    await db.collection('users').doc(uid).collection('notes').doc(id).delete();
  }
}
