import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:sistemtiket/services/View.dart';

class PaymentState extends StatefulWidget {
  final bool success;
  PaymentState({Key key, this.success}) : super(key: key);
  @override
  _PaymentState createState() => _PaymentState();
}

class _PaymentState extends State<PaymentState> {
  @override
  Widget build(BuildContext context) {
    View().init(context);
    return Container(
      color: CustomColor().dark,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: CustomColor().dark,
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                widget.success == true
                    ? Container(
                        width: View.blockX * 20,
                        child: Lottie.asset('assets/success.json'),
                      )
                    : Container(
                        width: View.blockX * 20,
                        child: Lottie.asset('assets/fail.json'),
                      ),
                widget.success == true
                    ? Text(
                        'Berhasil melakukan pemesanan',
                        style: CustomText().buttontext,
                      )
                    : Text('Kuota Habis', style: CustomText().buttontext),
                Container(
                  margin: EdgeInsets.only(top: 10),
                  decoration: BoxDecoration(
                      color: CustomColor().primary,
                      borderRadius: BorderRadius.circular(10)),
                  child: FlatButton(
                    child: Text(
                      'Kembali',
                      style: CustomText().buttontext,
                    ),
                    onPressed: () => Navigator.pop(context),
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
