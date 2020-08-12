import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sistemtiket/Menu.dart';
import 'package:sistemtiket/Menu/Account/dialog.dart';
import 'package:sistemtiket/Menu/Account/password.dart';
import '../services/View.dart';

class Account extends StatelessWidget {
  final String user, tiket;
  Account({Key key, this.user, this.tiket}) : super(key: key);

  Future<bool> onWillpop(BuildContext context) async {
    var prefs = await SharedPreferences.getInstance();
    String user = prefs.getString('user');
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => Menu(
                  user: user,
                )));
    return true;
  }

  @override
  Widget build(BuildContext context) {
    View().init(context);
    return Container(
      color: CustomColor().dark,
      child: SafeArea(
        child: WillPopScope(
          onWillPop: () async => onWillpop(context),
          child: Scaffold(
            appBar: AppBar(
              backgroundColor: CustomColor().dark,
              iconTheme: IconThemeData(color: Colors.white),
            ),
            backgroundColor: CustomColor().dark,
            body: Stack(
              children: <Widget>[
                Positioned(
                  top: View.blockY * 5,
                  left: View.blockX * 5,
                  width: View.blockX * 90,
                  child: CustomCard(
                    color: CustomColor().dark,
                    lottie: 'assets/account.json',
                    title: user,
                    subtitle: 'Tiket : $tiket',
                  ),
                ),
                Positioned(
                  top: View.blockY * 25,
                  left: View.blockX * 5,
                  width: View.blockX * 90,
                  child: Column(
                    children: <Widget>[
                      CustomCard(
                        color: CustomColor().dark,
                        icon: Icon(
                          Icons.person,
                          color: Colors.white,
                        ),
                        title: 'Ubah Nama',
                        subtitle: 'sesuaikan nama anda',
                        function: () => CustomDialog().namaDialog(context),
                      ),
                      CustomCard(
                        color: CustomColor().dark,
                        icon: Icon(
                          Icons.phone,
                          color: Colors.white,
                        ),
                        title: 'Ganti No.Telepon',
                        subtitle: 'ganti nomor telepon anda',
                        function: () => CustomDialog().phoneDialog(context),
                      ),
                      CustomCard(
                        color: CustomColor().dark,
                        icon: Icon(
                          Icons.vpn_key,
                          color: Colors.white,
                        ),
                        title: 'Ganti Password',
                        subtitle: 'ganti password lama anda',
                        function: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => PasswordPage())),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
