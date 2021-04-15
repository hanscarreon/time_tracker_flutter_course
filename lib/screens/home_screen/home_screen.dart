import 'package:flutter/material.dart';
import 'package:time_tracker_flutter_course/screens/sign_in_screen/sign_in_screen.dart';
import 'package:time_tracker_flutter_course/services/auth_service.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final AuthService _auth = AuthService();

  @override
  void initState(){
    super.initState();
    _auth.authStateChanges().listen((user) {
      var authListen = user?.uid;
      if(authListen == null){
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (BuildContext context) => SignInScreen()));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        title: Text('Dashemart'),
        centerTitle: true,
      ),
      body: Container(child: ElevatedButton(
        child: Text('Logout'),
        onPressed: () async =>  await _auth.signOut(),
      ),),
    );
  }


}

