import 'package:all_firebase/Widgets/reusuable_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AddDataScreen extends StatefulWidget {
  const AddDataScreen({super.key});

  @override
  State<AddDataScreen> createState() => _AddDataScreenState();
}

class _AddDataScreenState extends State<AddDataScreen> {
  TextEditingController controller = TextEditingController();
  final ref = FirebaseFirestore.instance.collection('user');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add in Firestore'),
      ),
      body: Column(
        children: [
          TextFormField(
            controller: controller,
            decoration: InputDecoration(
              hintText: 'Whats on your mind',
              border: OutlineInputBorder(),
            ),
          ),
          ReusuableButton(title: 'Add', onTap: (){
            String id = DateTime.now().millisecondsSinceEpoch.toString();
            ref.doc(id).set({
              'title': controller.text,
              'id': id
            });
          }),
        ],
      ),
    );
  }
}
