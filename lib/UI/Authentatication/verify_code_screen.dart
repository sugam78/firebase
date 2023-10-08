import 'package:all_firebase/UI/home_page.dart';
import 'package:all_firebase/Utilities/utilities.dart';
import 'package:all_firebase/Widgets/reusuable_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class VerifycodeScreen extends StatefulWidget {
  String verificationId;
  VerifycodeScreen({super.key,required this.verificationId});

  @override
  State<VerifycodeScreen> createState() => _VerifycodeScreenState();
}

class _VerifycodeScreenState extends State<VerifycodeScreen> {
  TextEditingController controller = TextEditingController();
  FirebaseAuth auth = FirebaseAuth.instance;
  bool loading  = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Verify Code'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
        TextFormField(
          controller: controller,
          keyboardType: TextInputType.phone,
          decoration: InputDecoration(
            hintText: 'Enter verification code',
            border: OutlineInputBorder(
              borderSide: BorderSide(width: 1),
            ),
          ),
          validator: (value){
            if(value!.isEmpty){
              return 'Enter Code';
            }
            else{
              return null;
            }
          },
        ),
        SizedBox(height: 30,),
        ReusuableButton(title: 'Verify',loading: loading, onTap: ()async{
          setState(() {
            loading = true;
          });
          final credential =  PhoneAuthProvider.credential(
              verificationId: widget.verificationId , smsCode: controller.text
          );
          try{
            setState(() {
              loading = false;
            });
           await auth.signInWithCredential(credential);
            Navigator.push(context, MaterialPageRoute(builder: (context)=> HomePage()));
          }
          catch(e){
            setState(() {
              loading = false;
            });
            Utilities().toastMesssage(e.toString());
          }
        }),
      ],),
    );
  }
}
