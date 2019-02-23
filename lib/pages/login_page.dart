import 'package:flutter/material.dart';
import 'package:flutter_shared_pref/pages/profile_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget{
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _usernameController = TextEditingController();
  static final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  Gradient linearGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment(0.7, 0.4),
    colors: [Colors.deepOrange[300],Colors.pink[600],Colors.blueAccent[700],
    ],
  );

  @override
  void dispose() {
    _usernameController.dispose();
    super.dispose();
  }

  _checkStatus() async{
    SharedPreferences _sPref = await SharedPreferences.getInstance();

    if(_sPref.getString('status').toString() == 'logged' && _sPref != null){
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (BuildContext context) => ProfilePage(),
        ),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    //print("in Login page");
    _checkStatus();

  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('Login Page'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          TextField(
            keyboardType: TextInputType.text,
            style: TextStyle(
                fontSize: 22.0,
                color: Colors.black
            ),
            controller: _usernameController,
            decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'Enter username',
                hintStyle: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold
                ),
                contentPadding: EdgeInsets.symmetric(
                    horizontal: 30.0, vertical: 20.0)
            ),
          ),
          SizedBox(
            height: 50.0,
          ),
          Center(
            child: MaterialButton(onPressed: () async {
              if(_usernameController.text.isNotEmpty){
                SharedPreferences _sPref = await SharedPreferences.getInstance();
                if(_sPref.getString('username').toString() == _usernameController.text && _sPref != null){
                  await _sPref.setString('status', 'logged');
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (BuildContext context) => ProfilePage(),
                    ),
                  );
                }else{
                  _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text('Username Not found!'), duration: Duration(seconds: 1),));
                }
              }else{
                _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text('Please enter username'), duration: Duration(seconds: 1),));
              }
            },
              splashColor: Colors.redAccent[100],
              child: ShaderMask(shaderCallback: (bounds){
                return linearGradient.createShader(Offset.zero & bounds.size);
              },
                child: Text("Log In",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white,
                      fontSize: 60.0),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}