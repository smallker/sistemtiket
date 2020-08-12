import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lottie/lottie.dart';
import 'package:sistemtiket/LoginPage.dart';
import 'package:sistemtiket/Menu/History.dart';
import 'package:sistemtiket/Menu/Payment.dart';
import 'package:sistemtiket/services/Database.dart';
import 'package:after_init/after_init.dart';
import 'Menu/Account.dart';
import 'services/View.dart';

class Menu extends StatefulWidget {
  final String user;
  Menu({Key key, this.user}) : super(key: key);
  @override
  MenuState createState() => MenuState();
}

class MenuState extends State<Menu> with AfterInitMixin<Menu> {
  int saldo = 0;
  String name = '';
  int tiket = 0;
  @override
  void didInitState() {
    setState(() {
      ConnectDB().userdata(widget.user).then((value) {
        // print(value.toList());
        if (value != null) {
          setState(() {
            name = value.toList()[0].toString();
            // saldo = value.toList()[1];
            tiket = value.toList()[1];
            print(name);
          });
        }
      });
    });
    print('initialize');
  }

  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    View().init(context);
    return Container(
      color: CustomColor().primary80,
      child: SafeArea(
        child: WillPopScope(
          onWillPop: onWillPop,
          child: Scaffold(
            backgroundColor: CustomColor().primary.withOpacity(0.4),
            floatingActionButton: FloatingActionButton.extended(
              label: Text('Keluar'),
              icon: Icon(Icons.exit_to_app),
              backgroundColor: CustomColor().primary,
              onPressed: () => ConnectDB().logout().whenComplete(() =>
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => LoginPage()))),
            ),
            body: Stack(
              children: <Widget>[
                Positioned(
                  top: View.blockY * 5,
                  left: View.blockX * 10,
                  child: Container(
                    width: View.blockX * 80,
                    height: View.blockY * 15,
                    alignment: AlignmentDirectional.centerStart,
                    child: Container(
                      width: View.blockX * 80,
                      height: View.blockY * 13,
                      alignment: Alignment.center,
                      child: CustomCard(
                        color: CustomColor().primary,
                        lottie: 'assets/heart.json',
                        title: name,
                        subtitle: '',
                        function: null,
                      ),
                    ),
                  ),
                ),
                Positioned(
                    top: View.blockY * 30,
                    left: View.blockX * 10,
                    child: Column(
                      children: <Widget>[
                        Container(
                          width: View.blockX * 80,
                          height: View.blockY * 13,
                          alignment: Alignment.center,
                          child: CustomCard(
                              color: CustomColor().warning,
                              lottie: 'assets/ticket.json',
                              title: 'Ambil Nomor',
                              subtitle: 'Ambil nomor antrian anda',
                              function: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => Payment(
                                            email: widget.user,
                                          )))),
                        ),
                        Container(
                          width: View.blockX * 80,
                          height: View.blockY * 13,
                          alignment: Alignment.center,
                          child: CustomCard(
                            color: CustomColor().dark,
                            lottie: 'assets/account.json',
                            title: 'Akun Anda',
                            subtitle: 'Edit preferensi akun',
                            function: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Account(
                                          tiket: tiket.toString(),
                                          user: name,
                                        ))),
                          ),
                        ),
                        Container(
                          width: View.blockX * 80,
                          height: View.blockY * 13,
                          alignment: Alignment.center,
                          child: CustomCard(
                            color: CustomColor().green,
                            lottie: 'assets/history.json',
                            title: 'Jadwal Periksa',
                            subtitle: 'Lihat jadwal periksa',
                            function: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => History(
                                          user: widget.user,
                                        ))),
                          ),
                        )
                      ],
                    )),
                Positioned(
                  bottom: View.blockY * 0,
                  left: View.blockX * 5,
                  width: View.blockX * 50,
                  child: Lottie.asset('assets/support.json'),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  var backbuttonpressedTime;
  Future<bool> onWillPop() async {
    DateTime currentTime = DateTime.now();
    bool backButton = backbuttonpressedTime == null ||
        currentTime.difference(backbuttonpressedTime) > Duration(seconds: 3);
    if (backButton) {
      backbuttonpressedTime = currentTime;
      Fluttertoast.showToast(
          msg: "Tekan sekali lagi untuk keluar",
          backgroundColor: CustomColor().primary,
          textColor: Colors.white);
      return false;
    }
    SystemChannels.platform.invokeMethod('SystemNavigator.pop');
    return true;
  }
}
