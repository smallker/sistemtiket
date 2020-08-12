import 'package:flutter/material.dart';
// ignore: unused_import
import 'package:fluttertoast/fluttertoast.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:sistemtiket/RegisterPage.dart';
import 'package:sistemtiket/services/Database.dart';
import 'Menu.dart';
import 'services/View.dart';
import 'package:lottie/lottie.dart';

TextEditingController _password = TextEditingController();
TextEditingController _user = TextEditingController();

class LoginPage extends StatefulWidget {
  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  static const route = '/login';
  final _formKey = GlobalKey<FormState>();
  void dispose() {
    _password.clear();
    _user.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    View().init(context);
    return Scaffold(
      backgroundColor: Color(0xE0002E32),
      body: Center(
        child: Stack(
          children: <Widget>[
            Positioned(
              top: View.y / 5,
              left: View.x / 4,
              width: View.blockX * 50,
              child: Image.asset('assets/ic.png'),
            ),
            Positioned(
                top: View.y / 2.1,
                left: View.x / 7,
                width: View.blockX * 70,
                child: Form(
                    key: _formKey,
                    child: Column(
                      children: <Widget>[
                        _Form(hint: "Email"),
                        _Form(hint: "Kata sandi")
                      ],
                    ))),
            Positioned(
                top: View.blockY * 67,
                left: View.blockX * 15,
                right: View.blockX * 51,
                child: Button(
                  action: 'Masuk',
                  function: () => ConnectDB()
                      .auth(_user.text, _password.text)
                      .then((value) {
                    if (value == true)
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Menu(
                                    user: _user.text,
                                  )));
                    else
                      Fluttertoast.showToast(
                          msg: "Login Gagal",
                          backgroundColor: CustomColor().primary,
                          textColor: Colors.white);
                  }),
                )),
            Positioned(
              top: View.blockY * 67,
              left: View.blockX * 51,
              right: View.blockX * 15,
              child: Button(
                action: 'Daftar',
                function: () => Navigator.push(context,
                    MaterialPageRoute(builder: (context) => RegisterPage())),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ignore: todo
/*TODO: textfield untuk email dan password
  // ignore: todo
  TODO: menggunakan validator untuk verifikasi format email dan password
 */
class _Form extends StatefulWidget {
  final String hint;
  const _Form({Key key, this.hint}) : super(key: key);
  @override
  _FormState createState() => _FormState();
}

class _FormState extends State<_Form> {
  final formValidator = MultiValidator([
    RequiredValidator(errorText: 'harus diisi'),
    MinLengthValidator(8, errorText: 'Password minimal 8 karakter'),
  ]);
  @override
  Widget build(BuildContext context) {
    if (widget.hint == "Kata sandi") {
      return TextFormField(
        obscureText: true,
        controller: _password,
        style: TextStyle(color: Colors.white),
        validator: formValidator,
        decoration: InputDecoration(
            hintText: widget.hint,
            hoverColor: Colors.white,
            hintStyle: CustomText().buttontext,
            fillColor: Colors.white,
            focusColor: Colors.white),
      );
    } else {
      return TextFormField(
        controller: _user,
        validator: formValidator,
        style: TextStyle(color: Colors.white),
        decoration: InputDecoration(
            hintText: widget.hint, hintStyle: CustomText().buttontext),
      );
    }
  }
}