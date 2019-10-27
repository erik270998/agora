import 'package:app/screens/feed_screen.dart';
import 'package:app/screens/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:app/screens/login_screen.dart';
import 'package:app/screens/signup_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  Widget _getScreenId() {
    return StreamBuilder<FirebaseUser>(
      stream: FirebaseAuth.instance.onAuthStateChanged, 
      builder: (BuildContext context, snapshot) {
        if (snapshot.hasData){
          return HomeScreen(userId: snapshot.data.uid,);
        } else
        return LoginScreen();
      },
    );
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'app',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
      primaryIconTheme: Theme.of(context).primaryIconTheme.copyWith(
      color: Colors.black,
      ),
      ),
      home: _getScreenId(),
      routes: {
        LoginScreen.id: (context) => LoginScreen(),
        SignupScreen.id: (context) => SignupScreen(),
        FeedScreen.id: (context) => FeedScreen(),
      },
    );
  }
}

