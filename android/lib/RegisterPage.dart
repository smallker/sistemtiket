import 'package:lottie/lottie.dart';
import 'package:sistemtiket/services/Database.dart';

import 'services/View.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:form_field_validator/form_field_validator.dart';

final _formKey = GlobalKey<FormState>();
TextEditingController _name = TextEditingController();
TextEditingController _email = TextEditingController();
TextEditingController _telepon = TextEditingController();
TextEditingController _password = TextEditingController();
TextEditingController _passwordConfirm = TextEditingController();

class RegisterPage extends StatefulWidget {
  static const route = '/signup';
  @override
  _RegisterPage createState() => _RegisterPage();
}

class _RegisterPage extends State<RegisterPage> {
  void dispose() {
    if (_name.text != null) {
      _name.clear();
      _email.clear();
      _telepon.clear();
      _password.clear();
      _passwordConfirm.clear();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    View().init(context);
    return WillPopScope(
      onWillPop: () async => true,
      child: Scaffold(
        backgroundColor: CustomColor().primary.withOpacity(0.4),
        body: Stack(
          children: <Widget>[
            Positioned(
              top: View.y / 10,
              left: View.x / 4,
              width: View.blockX * 50,
              child: Lottie.asset('assets/heart.json'),
            ),
            Positioned(
                top: View.blockY * 35,
                left: View.blockX * 10,
                width: View.blockX * 80,
                child: Theme(
                  data: ThemeData(
                      primaryColor: CustomColor().primary,
                      hintColor: CustomColor().primary),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: <Widget>[
                        _Form(
                          hint: 'Nama lengkap',
                          controller: _name,
                        ),
                        _Form(
                          hint: 'Email',
                          controller: _email,
                        ),
                        _Form(
                          hint: 'No. Telepon',
                          controller: _telepon,
                        ),
                        _Form(
                          hint: 'Kata sandi',
                          controller: _password,
                        ),
                        _Form(
                          hint: 'Konfirmasi kata sandi',
                          controller: _passwordConfirm,
                        ),
                        Container(
                            width: View.blockX * 90,
                            child: Button(
                              action: 'Daftar',
                              function: () {
                                if (_formKey.currentState.validate()) {
                                  // Auth().signUp(name.text,email.text, password.text);
                                  ConnectDB()
                                      .register(_name.text, _email.text,
                                          _telepon.text, _password.text)
                                      .then((value) {
                                    if (value == true) {
                                      Fluttertoast.showToast(
                                          msg: "Berhasil melakukan pendaftaran",
                                          backgroundColor:
                                              CustomColor().primary,
                                          textColor: Colors.white);
                                      _name.clear();
                                      _email.clear();
                                      _telepon.clear();
                                      _password.clear();
                                      _passwordConfirm.clear();
                                      Navigator.of(context).pop(true);
                                    } else {
                                      Fluttertoast.showToast(
                                          msg: "Email sudah digunakan",
                                          backgroundColor:
                                              CustomColor().primary,
                                          textColor: Colors.white);
                                    }
                                  });
                                }
                              },
                            ))
                      ],
                    ),
                  ),
                )),
          ],
        ),
      ),
    );
  }
}

class _Form extends StatefulWidget {
  final String hint;
  final TextEditingController controller;
  const _Form({Key key, this.hint, this.controller}) : super(key: key);
  @override
  _FormState createState() => _FormState();
}

class _FormState extends State<_Form> {
  final passwordValidator = MultiValidator([
    RequiredValidator(errorText: 'harus diisi'),
    MinLengthValidator(8, errorText: 'Password minimal 8 karakter'),
  ]);
  final formValidator = MultiValidator([
    RequiredValidator(errorText: 'harus diisi'),
  ]);
  @override
  Widget build(BuildContext context) {
    if (widget.hint == 'Kata sandi') {
      return TextFormField(
        obscureText: true,
        controller: widget.controller,
        validator: passwordValidator,
        style: TextStyle(color: Colors.white),
        decoration: InputDecoration(
            hintText: widget.hint, hintStyle: CustomText().buttontext),
      );
    } else if (widget.hint == 'Konfirmasi kata sandi') {
      return TextFormField(
        obscureText: true,
        controller: widget.controller,
        style: TextStyle(color: Colors.white),
        validator: (val) => MatchValidator(errorText: 'Password harus sama')
            .validateMatch(val, _password.text),
        decoration: InputDecoration(
            hintText: widget.hint,
            hintStyle: CustomText().buttontext,
            fillColor: Colors.white),
      );
    } else {
      return TextFormField(
        controller: widget.controller,
        validator: formValidator,
        style: TextStyle(color: Colors.white),
        decoration: InputDecoration(
            hintText: widget.hint, hintStyle: CustomText().buttontext),
      );
    }
  }
}
