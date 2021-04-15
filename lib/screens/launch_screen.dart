


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:time_tracker_flutter_course/screens/home_screen/home_screen.dart';
import 'package:time_tracker_flutter_course/screens/sign_in_screen/sign_in_screen.dart';
import 'package:time_tracker_flutter_course/services/auth_service.dart';

class LaunchScreen extends StatefulWidget {
  @override
  _LaunchScreenState createState() => _LaunchScreenState();
}

class _LaunchScreenState extends State<LaunchScreen> with AfterLayoutMixin<LaunchScreen>{
  final user = AuthService().currentUser;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(15.0),
        child: Center(
          child: Image.asset('assets/images/dashemart-logo8.png'),
        ),
      ),
    );
  }

  @override
  void afterFirstLayout(BuildContext context) {
    // TODO: implement afterFirstLayout
    print('$user fcking user');
    Future.delayed(const Duration(milliseconds: 5000), () {
      if(user != null){
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (BuildContext context) => HomeScreen()));
      }
      else{
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (BuildContext context) => SignInScreen()));
      }
    });
  }
}

mixin AfterLayoutMixin<T extends StatefulWidget> on State<T> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance
        .addPostFrameCallback((_) => afterFirstLayout(context));
    print('fcking layf');


  }

  void afterFirstLayout(BuildContext context);
}
