import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sistemtiket/services/Database.dart';


class CustomDialog {
  // BuildContext context;
  // NamePhoneDialog(this.context);

  namaDialog(BuildContext context) async {
    TextEditingController nama = TextEditingController();
    var prefs = await SharedPreferences.getInstance();
    String email = prefs.getString('user');
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Ganti nama anda'),
            content: TextField(
              controller: nama,
              decoration: InputDecoration(hintText: "Masukkan nama"),
            ),
            actions: <Widget>[
              new FlatButton(
                child: new Text('Atur'),
                onPressed: () {
                  ConnectDB().updateName(nama.text, email).whenComplete(() {
                    Navigator.pop(context);
                    nama.clear();
                  });
                },
              )
            ],
          );
        });
  }

  // @override
  // // ignore: override_on_non_overriding_member
  phoneDialog(BuildContext context) async {
    TextEditingController telepon = TextEditingController();
    var prefs = await SharedPreferences.getInstance();
    String email = prefs.getString('user');
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Ganti No. Telepon'),
            content: TextField(
              controller: telepon,
              decoration: InputDecoration(hintText: "Masukkan no. telepon"),
              keyboardType: TextInputType.phone,
            ),
            actions: <Widget>[
              new FlatButton(
                child: new Text('Atur'),
                onPressed: () {
                  ConnectDB().updatePhone(telepon.text, email).whenComplete(() {
                    Navigator.pop(context);
                    telepon.clear();
                  });
                },
              )
            ],
          );
        });
  }
}
