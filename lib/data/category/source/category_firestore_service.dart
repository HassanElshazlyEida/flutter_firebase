import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class CategoryFirestoreService {
  Future<void> create(String name);
  Future<QuerySnapshot> all();
  Future<void> delete(String id);

}

class CategoryService implements CategoryFirestoreService {
  final CollectionReference _categories = FirebaseFirestore.instance.collection('categories');
  
  @override
  Future<void> create(String name) async {
    _categories.add({
      'name': name
    })
    .then((value) => value);
  }
  @override
  Future<QuerySnapshot> all(){
    return _categories.get();
  }
  
  @override
  Future<void> delete(String id) async {
    _categories.doc(id).delete();
  }

  
  
}