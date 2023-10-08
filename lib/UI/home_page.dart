import 'package:all_firebase/UI/Authentatication/login_screen.dart';
import 'package:all_firebase/UI/Database/posts.dart';
import 'package:all_firebase/UI/FireStore/show_data.dart';
import 'package:all_firebase/UI/Image/upload_image.dart';
import 'package:all_firebase/Utilities/utilities.dart';
import 'package:all_firebase/Widgets/reusuable_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  FirebaseAuth auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Store anything'),
        actions: [
          IconButton(onPressed: (){
            auth.signOut().then((value) {
              Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginScreen()));
            }).onError((error, stackTrace) {
              Utilities().toastMesssage(error.toString());
            });
          },
        icon:Icon(Icons.login) ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ReusuableButton(title: 'Post Something in RealtimeFirebase', onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>PostScreen()));
            }),
            SizedBox(height: 35,),
            ReusuableButton(title: 'Post Something in FireStore', onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>DataScreen()));
            }),
            SizedBox(height: 35,),
            ReusuableButton(title: 'Upload Image', onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>ImageScreen()));
            }),
          ],
        ),
      ),
    );
  }
}
