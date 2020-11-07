import 'package:flutter/material.dart';
import 'package:studentappoficial/addstudent.dart';
import 'package:studentappoficial/login.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:studentappoficial/studentlist.dart';
import 'package:studentappoficial/addstudent.dart';
/*import 'package:studentappoficial/addstudent.dart'*/

void main() => runApp(Studentapp());

class Studentapp extends StatelessWidget {
  const Studentapp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Studentapp",
      home: Inicio(),
    );
  }
}

class Inicio extends StatefulWidget {
  Inicio({Key key}) : super(key: key);

  @override
  _InicioState createState() => _InicioState();
}

class _InicioState extends State<Inicio> {
  SharedPreferences sharedPreferences;

  @override
  void initState() {
    super.initState();
    checkLoginStatus();
  }

  checkLoginStatus() async {
    sharedPreferences = await SharedPreferences.getInstance();
    if (sharedPreferences.getString("token") == null) {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (BuildContext context) => LoginPage()),
          (Route<dynamic> route) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Student",
          style: TextStyle(color: Colors.red),
        ),
        actions: <Widget>[
          FlatButton(
            onPressed: () {
              sharedPreferences.clear();
              // ignore: deprecated_member_use
              sharedPreferences.commit();
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(
                      builder: (BuildContext context) => LoginPage()),
                  (Route<dynamic> route) => false);
            },
            child: Text("Log Out",
                style: TextStyle(
                    color: Colors
                        .greenAccent)), //ESTA EN LA LISTA EL LOGOUT que es cerrar sesion
          ),
        ],
      ),
      body: Center(child: JobsListView()),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _navigateToAddScreen(context);
        },
        tooltip: 'Increment',
        child: Icon(
          Icons.add,
          color: Colors.white70,
        ),
        backgroundColor: Colors.red[600],
      ),
    );
    drawer:
    Drawer();
  }

  _navigateToAddScreen(BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Addstudent()),
    );
  }
}
