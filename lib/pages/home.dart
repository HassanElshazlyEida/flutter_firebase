import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_firebase/bloc/auth/auth_bloc.dart';
import 'package:flutter_firebase/bloc/states/auth_state.dart';
import 'package:flutter_firebase/component/helpers/helper.dart';
import 'package:flutter_firebase/data/category/source/category_firestore_service.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  List categories = [];

  getCategories() async {
    QuerySnapshot querySnapshot = await context.read<CategoryService>().all();
    setState(() {
      categories.addAll(querySnapshot.docs);
    });
  }
  @override
  void initState(){
    getCategories();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // bloc consumer with user details
    
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        print('home');
        print(state.toString());
        if (state is AuthError) {
          Helper.showMessage(context, state.message);
        }else if (state is AuthUnAuthenticated) {
          Navigator.of(context).pushReplacementNamed('/login');
        }else if (state is AuthAuthenticated) {
          print(state.user.username);
        }
      },
      builder: (context, state) {
        if (state is AuthLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is AuthAuthenticated) {
          return Scaffold(
            floatingActionButton: FloatingActionButton(
              backgroundColor: Colors.blue,
              onPressed: () {
                Navigator.of(context).pushNamed('/create-category');
              },
              child: const Icon(Icons.add,color:Colors.white),
            ),
            appBar: AppBar(
              title: const Text('Home'),
              automaticallyImplyLeading: false,
            ),
            body:  GridView.builder(
              itemCount: categories.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,mainAxisExtent: 160),
              itemBuilder: (context, index) {
                return  Card(
                child: Container(
                  padding:  const EdgeInsets.all(10),
                  child: Column(
                    children: [
                      Image.asset('lib/images/folder.png',height: 100,),
                      Text("${categories[index]['name']}")
                    ],
                  ),
                ),
              );
              }
            )
          );

        } 
        return  Center(child: Text(state.toString()));
        
      },
    );

  }
}