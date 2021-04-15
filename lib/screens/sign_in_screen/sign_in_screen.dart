

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:time_tracker_flutter_course/screens/home_screen/home_screen.dart';
import 'package:time_tracker_flutter_course/screens/sign_in_screen/sign_up_screen.dart';
import 'package:time_tracker_flutter_course/services/auth_service.dart';

class SignInScreen extends StatefulWidget{
  @override
  _SignInScreenState createState() => _SignInScreenState();
}
class _SignInScreenState extends State<SignInScreen>{
  final AuthService _auth = AuthService();


  @override
  void initState(){
    super.initState();
    _auth.authStateChanges().listen((user) {
      var authListen = user?.uid;
      if(authListen != null){
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (BuildContext context) => HomeScreen()));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
        centerTitle: true,
        elevation: 10.0,
      ),
      body: Container(
        padding: EdgeInsets.all(15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Sign in',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.w900
              ),
            ),
           googleButton(),
            sizeBoxSize(10.0),
            facebookButton(),
            sizeBoxSize(10.0),
            emailPassButton(),
            Padding(padding: EdgeInsets.all(10.0),
              child:Text('or',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
            ),
            signInAnon()
          ],
        ),
      )
    );
    throw UnimplementedError();
  }
  Widget sizeBoxSize(double heightSize){
    return SizedBox(height: heightSize);
  }
  Widget googleButton(){
    return SizedBox(height: 50,
      child: ElevatedButton.icon(
        label: Text('Sign in with Google',
          style: TextStyle(
            color: Colors.black,
            fontSize: 15.0,
          ),),
        onPressed: () async{
          print('Google');
          _auth.signInGoogle();
        },
        icon: Icon(FontAwesomeIcons.googlePlusG,color: Colors.black,),
        style: ElevatedButton.styleFrom(primary: Colors.white),
      ),
    );

  }
  Widget facebookButton(){
    return SizedBox(height: 50,
      child: ElevatedButton.icon(
        label: Text('Sign in with Facebook',
          style: TextStyle(
            color: Colors.white,
            fontSize: 15.0,
          ),),
        onPressed: (){
          print('Facebook');
          _auth.facebookSignIn();
        },
        icon: Icon(FontAwesomeIcons.facebookSquare,color: Colors.white,),
        style: ElevatedButton.styleFrom(primary: Colors.indigo),
      ),
    );


  }
  Widget emailPassButton(){
    return SizedBox(height: 50.0,
        child: ElevatedButton.icon(
          label: Text('Sign in with Email',
            style: TextStyle(
              color: Colors.white,
              fontSize: 15.0,
            ),),
          onPressed: (){
            print('user');
            Navigator.of(context).push(MaterialPageRoute(
              fullscreenDialog: true,
              builder: (context)=> SignUpScreen()
            ));
          },
          icon: Icon(FontAwesomeIcons.userAlt,color: Colors.white,),
          style: ElevatedButton.styleFrom(primary: Colors.teal),
        )
    );
  }

  Widget signInAnon(){
    return SizedBox(height: 50.0,
        child: ElevatedButton.icon(
          label: Text('Sign in Anonymous',
            style: TextStyle(
              color: Colors.black,
              fontSize: 15.0,
            ),),
          onPressed: () async{
            final userId  = await _auth.signInAnon();
            if(userId == null){
                print('something went wrong');
                return;
            }
          },
          icon: Icon(FontAwesomeIcons.userCircle,color: Colors.white,),
          style: ElevatedButton.styleFrom(primary: Colors.lightGreen),
        )
    );
  }

}