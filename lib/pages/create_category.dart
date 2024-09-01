import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_firebase/component/custom_text_field.dart';
import 'package:flutter_firebase/component/custome_elevated_button.dart';
import 'package:flutter_firebase/component/helpers/helper.dart';
import 'package:flutter_firebase/data/category/source/category_firestore_service.dart';

class CreateCategory extends StatefulWidget {
  const CreateCategory({super.key});

  @override
  State<CreateCategory> createState() => _CreateCategoryState();
}

class _CreateCategoryState extends State<CreateCategory> {
  final _formKey = GlobalKey<FormState>();  

  TextEditingController name = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Create category")),
      body: Form(
        key: _formKey,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 20,horizontal: 25),
          child: Column(
            children: [
              CustomTextField(
                  text: 'Category name',
                  controller: name,
              ),
              const SizedBox(height: 20),
              CustomElevatedButton(
                  text: 'Create',
                  backgroundColor: const Color(0xff1F41BB),
                  onPressed: () async  {
                    if (_formKey.currentState?.validate() ?? false) {
                      try {
                        await context.read<CategoryService>().create(name.text);
                        Helper.showMessage(context, '${name.text} has been added successfully');
                        Navigator.pushNamed(context, '/home');
                      } catch (error) {
                        Helper.showMessage(context, 'An error occur');
                      }
                    }
                  },
                )
            ],
          ),
        ),
      ),
    );
  }
}