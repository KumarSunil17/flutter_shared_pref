import 'package:flutter/material.dart';
import 'package:flutter_shared_pref/pages/login_page.dart';
import 'package:flutter_shared_pref/pages/profile_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegisterPage extends StatefulWidget{
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {

  Gradient linearGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment(0.7, 0.4),
    colors: [Colors.deepOrange[300],Colors.pink[600],Colors.blueAccent[700],
    ],
  );

  var _usernameController = new TextEditingController();

  static final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  _checkStatus() async{
    SharedPreferences _sPref =  await SharedPreferences.getInstance();
    print('status : '+_sPref.getString('status').toString());

    if( _sPref.getString('status').toString() == 'registered'){
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (BuildContext context) => LoginPage(),
          ),
        );
      }else if(_sPref.getString('status').toString() == 'logged'){
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
    _checkStatus();
  }

@override
  void dispose() {
    super.dispose();
    _usernameController.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('Register Page'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width/1.5,
            height: MediaQuery.of(context).size.height/10,
            margin: EdgeInsets.only(
              bottom: 5.0,
              left: MediaQuery.of(context).size.width/10,
              right: MediaQuery.of(context).size.width/10,
              top: 5.0,
            ),
            child: TextField(
              keyboardType: TextInputType.text,
              controller: _usernameController,
              style: TextStyle(fontSize: 20.0,
                  decorationColor: Colors.blueGrey
              ),
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius:BorderRadius.circular(6.0),
                ),
                hintText: 'Enter a username',
                hintStyle: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold
                ),
                contentPadding: EdgeInsets.symmetric(
                    horizontal: 30.0, vertical: 20.0,
                )
              ),
            ),
          ),
          Center(
            child: MaterialButton(onPressed: () async {
                if(_usernameController.text.isNotEmpty){
                  //SharedPreference Part
                  SharedPreferences _sPref = await SharedPreferences.getInstance();
                  await _sPref.setString('username', _usernameController.text).whenComplete((){
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                          builder: (BuildContext context) => LoginPage(),
                      ),
                    );
                  });
                  await _sPref.setString('status', 'registered');

                }else{
                  _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text('Please enter a username'), duration: Duration(seconds: 1),));
                }
              },
              splashColor: Colors.redAccent[100],
              child: ShaderMask(shaderCallback: (bounds){
                return linearGradient.createShader(Offset.zero & bounds.size);
              },
              child: Text("Register",
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