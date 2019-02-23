import 'package:flutter/material.dart';
import 'package:flutter_shared_pref/pages/login_page.dart';
import 'package:flutter_shared_pref/pages/profile_page.dart';
import 'package:flutter_shared_pref/pages/register_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home: RegisterPage(),
      routes: <String,WidgetBuilder>{
        'Register Page':(context)=>RegisterPage(),
        'Login Page':(context)=> LoginPage(),
        'Profile Page':(context)=> ProfilePage(),
      },
    );
  }
}
