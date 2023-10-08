import 'package:all_firebase/UI/Authentatication/verify_code_screen.dart';
import 'package:all_firebase/Utilities/utilities.dart';
import 'package:all_firebase/Widgets/reusuable_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class PhoneScreen extends StatefulWidget {
  const PhoneScreen({super.key});

  @override
  State<PhoneScreen> createState() => _PhoneScreenState();
}

class _PhoneScreenState extends State<PhoneScreen> {
  FirebaseAuth auth = FirebaseAuth.instance;
  bool loading = false;
  TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login with phone'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextFormField(
            controller: controller,
            keyboardType: TextInputType.phone,
            decoration: InputDecoration(
              hintText: 'Phone no',
              border: OutlineInputBorder(
                borderSide: BorderSide(width: 1),
              ),
            ),
            validator: (value){
              if(value!.isEmpty){
                return 'Enter Phone no';
              }
              else{
                return null;
              }
            },
          ),
          SizedBox(height: 30,),
          ReusuableButton(title: 'Continue',loading: loading, onTap: (){
            setState(() {
              loading = true;
            });
            auth.verifyPhoneNumber(
                phoneNumber: controller.text.toString(),
                verificationCompleted: (_){
                  setState(() {
                    loading = false;
                  });
                },
                verificationFailed: (e){
                  Utilities().toastMesssage(e.toString());
                  setState(() {
                    loading = false;
                  });
                },
                codeSent: (String verificationId,int? token){
                  setState(() {
                    loading = false;
                  });
                  Navigator.push(context, MaterialPageRoute(
                      builder: (context)=>VerifycodeScreen(verificationId: verificationId,)),
                  );
                },
                codeAutoRetrievalTimeout: (er){
                  setState(() {
                    loading = false;
                  });
                  Utilities().toastMesssage('dont');
                });
          }),
        ],
      ),
    );
  }
}
