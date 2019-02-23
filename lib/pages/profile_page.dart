import 'package:flutter/material.dart';
import 'package:flutter_shared_pref/pages/login_page.dart';
import 'package:flutter_shared_pref/pages/register_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePage extends StatefulWidget{

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  Gradient linearGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment(0.7, 0.4),
    colors: [Colors.deepOrange[300],Colors.pink[600],Colors.blueAccent[700],
    ],
  );

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(title: Text('Profile'),),
      body : Center(
        child: MaterialButton(onPressed: () async {
          SharedPreferences _sPref = await SharedPreferences.getInstance();
          await _sPref.setString('status', 'registered');
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (BuildContext context) => LoginPage(),
                ),
              );

        },
          splashColor: Colors.redAccent[100],
          child: ShaderMask(shaderCallback: (bounds){
            return linearGradient.createShader(Offset.zero & bounds.size);
          },
            child: Text("Log Out",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white,
                  fontSize: 60.0),
            ),
          ),
        ),
      ),
    );
  }
}