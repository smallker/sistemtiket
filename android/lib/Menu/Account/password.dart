import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sistemtiket/services/Database.dart';
import '../../services/View.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:after_init/after_init.dart';

TextEditingController _passwordold = TextEditingController();
TextEditingController _password = TextEditingController();
TextEditingController _passwordConfirm = TextEditingController();

class PasswordPage extends StatefulWidget {
  @override
  ChangePasswordState createState() => ChangePasswordState();
}

class ChangePasswordState extends State<PasswordPage>
    with AfterInitMixin<PasswordPage> {
  final _formKey = GlobalKey<FormState>();
  void dispose() {
    if (_passwordold.text != null) {
      _passwordold.clear();
      _password.clear();
      _passwordConfirm.clear();
    }
    super.dispose();
  }

  String user = '';
  @override
  void didInitState() {
    var prefs = SharedPreferences.getInstance();
    prefs.then((value) {
      user = value.getString('user');
    });
  }

  @override
  Widget build(BuildContext context) {
    View().init(context);
    return Container(
      color: CustomColor().dark,
      child: SafeArea(
        child: WillPopScope(
          onWillPop: () async => true,
          child: Scaffold(
            backgroundColor: CustomColor().dark,
            appBar: AppBar(
              title: Text(
                'Ganti password',
                style: CustomText().buttontext,
              ),
              backgroundColor: CustomColor().dark,
              iconTheme: IconThemeData(color: Colors.white),
            ),
            body: Stack(
              children: <Widget>[
                Positioned(
                  top: View.y / 10,
                  left: View.x / 4,
                  width: View.blockX * 50,
                  child: Lottie.asset('assets/password.json'),
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
                              hint: 'Password lama',
                              controller: _passwordold,
                            ),
                            _Form(
                              hint: 'Password baru',
                              controller: _password,
                            ),
                            _Form(
                              hint: 'Konfirmasi Password',
                              controller: _passwordConfirm,
                            ),
                            Container(
                                width: View.blockX * 90,
                                child: Button(
                                  action: 'Ganti Password',
                                  function: () {
                                    if (_formKey.currentState.validate()) {
                                      ConnectDB()
                                          .updatePassword(user,
                                              _passwordold.text, _password.text)
                                          .then((value) {
                                        if (value) {
                                          Fluttertoast.showToast(
                                              msg: "Password diganti",
                                              backgroundColor:
                                                  CustomColor().primary,
                                              textColor: Colors.white);
                                          Navigator.pop(context);
                                        } else
                                          Fluttertoast.showToast(
                                              msg: "Password salah",
                                              backgroundColor:
                                                  CustomColor().primary,
                                              textColor: Colors.white);
                                        Navigator.pop(context);
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
    if (widget.hint == 'Password baru') {
      return TextFormField(
        obscureText: true,
        controller: widget.controller,
        validator: passwordValidator,
        decoration: InputDecoration(
            hintText: widget.hint, hintStyle: CustomText().buttontext),
      );
    } else if (widget.hint == 'Konfirmasi Password') {
      return TextFormField(
        obscureText: true,
        controller: widget.controller,
        validator: (val) => MatchValidator(errorText: 'Password harus sama')
            .validateMatch(val, _password.text),
        decoration: InputDecoration(
            hintText: widget.hint,
            hintStyle: CustomText().buttontext,
            fillColor: Colors.white),
      );
    } else {
      return TextFormField(
        obscureText: true,
        controller: widget.controller,
        validator: formValidator,
        decoration: InputDecoration(
            hintText: widget.hint, hintStyle: CustomText().buttontext),
      );
    }
  }
}
