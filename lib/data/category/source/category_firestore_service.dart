import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class CategoryFirestoreService {
  Future create(String name);
  Future<QuerySnapshot> all();

}

class CategoryService implements CategoryFirestoreService {
  final CollectionReference _categories = FirebaseFirestore.instance.collection('categories');
  
  @override
  Future create(String name) {
    return _categories.add({
      'name': name
    })
    .then((value) => value);
  }
  @override
  Future<QuerySnapshot> all(){
    return _categories.get();
  }

  
  
}