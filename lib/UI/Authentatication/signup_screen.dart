import 'package:all_firebase/UI/Authentatication/login_screen.dart';
import 'package:all_firebase/Utilities/utilities.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../Widgets/reusuable_button.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  TextEditingController econtroller = TextEditingController();
  TextEditingController pcontroller = TextEditingController();
  FirebaseAuth auth = FirebaseAuth.instance;
  bool loading = false;
  final globalKey = GlobalKey<FormState>();

  @override
  void dispose() {
    // TODO: implement dispose
    econtroller.dispose();
    pcontroller.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Form(
            key: globalKey ,
            child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextFormField(
                controller: econtroller,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  hintText: 'Email',
                  border: OutlineInputBorder(
                    borderSide: BorderSide(width: 1),
                  ),
                ),
                validator: (value){
                  if(value!.isEmpty){
                    return 'Enter email';
                  }
                  else{
                    return null;
                  }
                },
              ),
              SizedBox(height: 20,),
              TextFormField(
                controller: pcontroller,
                obscureText: false,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  hintText: 'Password',
                  border: OutlineInputBorder(
                    borderSide: BorderSide(width: 1),
                  ),
                ),
                validator: (value){
                  if(value!.isEmpty){
                    return 'Enter password';
                  }
                  else{
                    return null;
                  }
                },
              ),
              SizedBox(height: 20,),
              ReusuableButton(title: 'Signup',loading: loading, onTap: (){
                if(globalKey.currentState!.validate()){
                  setState(() {
                    loading = true;
                  });
                }
                auth.createUserWithEmailAndPassword(
                    email: econtroller.text.toString(),
                    password: pcontroller.text.toString()
                ).then((value) {
                  setState(() {
                    loading = false;
                  });
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginScreen()));
                }).onError((error, stackTrace){
                  setState(() {
                    loading = false;
                  });
                  Utilities().toastMesssage(error.toString());
                });
              }),
              SizedBox(height: 20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Already have an account?'),
                  TextButton(onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginScreen()));
                  },
                      child: Text('Login')),
                ],
              ),
            ],
          ),),
        ],
      ),
    );
  }
}
