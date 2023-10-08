import 'package:all_firebase/UI/SplashScreen/splash_services.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    SplashServices().isLogin(context);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Image(
        image: NetworkImage('https://img.artrabbit.com/events/runnymede-spring-open/images/aEtmRBfbfvIb/460x460/0f83c9cf5842c40a01033947a931e733-0.jpg'),
      ),
    );
  }
}
