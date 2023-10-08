import 'package:all_firebase/Widgets/reusuable_button.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class AddPostScreen extends StatefulWidget {
  const AddPostScreen({super.key});

  @override
  State<AddPostScreen> createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  TextEditingController controller = TextEditingController();
  final ref = FirebaseDatabase.instance.ref('Post');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Posts'),
      ),
      body: Column(
        children: [
          TextFormField(
            controller: controller,
            decoration: InputDecoration(
              hintText: 'Whats on your mind',
              border: OutlineInputBorder(
                borderSide: BorderSide(width: 1),
              ),
            ),
          ),
          ReusuableButton(title: 'Add', onTap: (){
            String id = DateTime.now().millisecondsSinceEpoch.toString();
            ref.child(id).set({
              'id' : id,
              'title': controller.text,
            });
          }),
        ],
      ),
    );
  }
}
