import 'package:all_firebase/UI/Authentatication/forgot_password.dart';
import 'package:all_firebase/UI/Authentatication/phone_screen.dart';
import 'package:all_firebase/UI/Authentatication/signup_screen.dart';
import 'package:all_firebase/UI/home_page.dart';
import 'package:all_firebase/Widgets/reusuable_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../Utilities/utilities.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController econtroller = TextEditingController();
  TextEditingController pcontroller = TextEditingController();
  FirebaseAuth auth = FirebaseAuth.instance;
  final globalKey = GlobalKey<FormState>();
  bool loading = false;

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
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20.0,horizontal: 10),
        child: Column(
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
                  ReusuableButton(title: 'Login',loading: loading, onTap: (){
                    if(globalKey.currentState!.validate()){
                      setState(() {
                        loading = true;
                      });
                    }
                    auth.signInWithEmailAndPassword(
                        email: econtroller.text.toString(),
                        password: pcontroller.text.toString()
                    ).then((value) {
                      loading = false;
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>HomePage()));
                    }).onError((error, stackTrace){
                      loading = true;
                      Utilities().toastMesssage(error.toString());
                    });
                  }),SizedBox(height: 20,),

                  ReusuableButton(title: 'Login with phone number', onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>PhoneScreen()));
                  }),
                  SizedBox(height: 20,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Already have an account?'),
                      TextButton(onPressed: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>SignupScreen()));
                      },
                          child: Text('Signup')),
                    ],
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: TextButton(onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>ForgotPasswordScreen()));
                    },
                        child: Text('Forgot password?',style: TextStyle(fontWeight: FontWeight.bold),)),
                  ),
                ],
              ),),
          ],
        ),
      ),
    );
  }
}
