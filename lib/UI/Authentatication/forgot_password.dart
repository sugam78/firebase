import 'package:all_firebase/Utilities/utilities.dart';
import 'package:all_firebase/Widgets/reusuable_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  TextEditingController controller = TextEditingController();
  final auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Forgot password'),
      ),
      body: Column(
        children: [
          TextFormField(
            controller: controller,
            decoration: InputDecoration(
              hintText: 'Enter your email',
              border: OutlineInputBorder(),
            ),
          ),
          ReusuableButton(title: 'Send reset link', onTap: (){
            auth.sendPasswordResetEmail(email: controller.text.toString()).then((value) {
              Utilities().toastMesssage('We have sent you email go and check');
            }).onError((error, stackTrace) {
              Utilities().toastMesssage(error.toString());
            });
          }),
        ],
      ),
    );
  }
}
