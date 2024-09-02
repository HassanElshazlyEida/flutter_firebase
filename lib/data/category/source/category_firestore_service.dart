import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class CategoryFirestoreService {
  Future<void> create(String name);
  Future<QuerySnapshot> all();
  Future<void> delete(String id);

}

class CategoryService implements CategoryFirestoreService {
    final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final CollectionReference _categories = FirebaseFirestore.instance.collection('categories');
  
  @override
  Future<void> create(String name) async {
    _categories.add({
      'name': name,
      'id': _firebaseAuth.currentUser!.uid
    })
    .then((value) => value);
  }
  @override
  Future<QuerySnapshot> all(){
    return _categories.where('id', isEqualTo: _firebaseAuth.currentUser!.uid).get();
  }
  
  @override
  Future<void> delete(String id) async {
    _categories.doc(id).delete();
  }

  
  
}