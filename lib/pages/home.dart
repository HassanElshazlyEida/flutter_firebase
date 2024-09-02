import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_firebase/bloc/auth/auth_bloc.dart';
import 'package:flutter_firebase/bloc/events/auth_event.dart';
import 'package:flutter_firebase/bloc/states/auth_state.dart';
import 'package:flutter_firebase/component/delete_dialog.dart';
import 'package:flutter_firebase/component/helpers/helper.dart';
import 'package:flutter_firebase/data/category/source/category_firestore_service.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  List categories = [];
  bool isLoading = true;
  getCategories() async {
    QuerySnapshot querySnapshot = await context.read<CategoryService>().all();
    isLoading = false;
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
              actions: [
                IconButton(onPressed: (){
                  BlocProvider.of<AuthBloc>(context).add(SignOutRequested());
                }, icon: const Icon(Icons.logout))
              ],
              automaticallyImplyLeading: false,
            ),
            body: isLoading == true ?   const Center(child: CircularProgressIndicator()) : 
             categories.isEmpty
              ?  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset('lib/images/empty.png',height: 200,),
                       Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextButton(
                        child: const Text("Create new category",
                        style:  TextStyle(color: Colors.blue,fontSize: 20)),
                        onPressed: () {
                          Navigator.pushNamed(context, '/create-category');
                        }),
                       const  Icon(Icons.navigate_next,color:Colors.blue),
                      ],
                      )
                    ],
                  )
              :GridView.builder(
              itemCount: categories.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,mainAxisExtent: 200),
              itemBuilder: (context, index) {
                return  Card(
                child: Container(
                  padding:  const EdgeInsets.all(10),
                  child: Column(
                    children: [
                      Image.asset('lib/images/folder.png',height: 100,),
                      Text("${categories[index]['name']}"),
                      TextButton(onPressed: (){
                        showDialog(context: context, builder: (context){
                          return DeleteDialog(
                            onSave:(bool answer) async {
                              try {
                                await context.read<CategoryService>().delete(categories[index].id);
                             
                                Helper.showMessage(context, "${categories[index]['name']} has been removed");

                                setState(() {
                                  categories.removeAt(index);
                                });
                              }catch (error) {
                                Helper.showMessage(context, 'An error occur');
                              } 
                            
                            },
                          );
                        });
                      }, child: const Icon(Icons.delete,color: Colors.red,))
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