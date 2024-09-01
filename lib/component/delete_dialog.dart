import 'package:flutter/material.dart';

class DeleteDialog extends StatelessWidget {


  final Function(bool) onSave;
  DeleteDialog({super.key, required this.onSave});

  void _onSave(BuildContext context,bool answer) {
    onSave(answer);
    
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return  AlertDialog(
        actionsPadding: const EdgeInsets.all(8),
        title: const Text('Are sure you want to delete this record ?'),
        actions: [
          TextButton(
            onPressed: (){
              _onSave(context,false);
              Navigator.pop(context);
            },
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: (){
              _onSave(context,true);
            },
            child: const Text('Delete'),
          ),
        ],
      );
  }
}