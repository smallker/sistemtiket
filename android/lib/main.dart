import 'package:flutter/material.dart';
import 'package:sistemtiket/LoginPage.dart';
import 'Menu.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var islogin = prefs.getBool('islogin');
  var user = prefs.getString('user');
  runApp(Main(
    islogin: islogin,
    user: user,
  ));
}

class Main extends StatelessWidget {
  final bool islogin;
  final String user;
  Main({Key key, this.islogin, this.user}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Sistem Antri Tiket',
      theme: ThemeData(
          primarySwatch: Colors.blue,
          textSelectionColor: Colors.white,
          focusColor: Colors.white,
          primaryColor: Colors.white,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          hintColor: Colors.white),
      home: islogin == null || islogin == false
          ? LoginPage()
          : Menu(
              user: user,
            ),
    );
  }
}
