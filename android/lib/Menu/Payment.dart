import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sistemtiket/Menu/Paymentstate.dart';
import 'package:sistemtiket/services/Database.dart';
import '../Menu.dart';
import '../services/View.dart';

class Payment extends StatefulWidget {
  final String email;
  Payment({Key key, this.email}) : super(key: key);
  @override
  _Payment createState() => _Payment();
}

class _Payment extends State<Payment> {
  List<String> poli = ['poliumum', 'polijantung', 'poliparu'];
  List<String> dokter = [''];
  List<int> harga = [];
  String polihint = 'Pilih Poli';
  String dokterhint = 'Pilih Dokter';
  @override
  void initState() {
    super.initState();
    print('init payment');
  }

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

  void _dialog(BuildContext context, int harga) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        return AlertDialog(
          title: Text('Lanjutkan pemesanan'),
          content:
              Text('Anda akan memesan tiket untuk $dokterhint dari $polihint?'),
          actions: <Widget>[
            FlatButton(
              child: Text('Batal'),
              onPressed: () => Navigator.pop(context),
            ),
            FlatButton(
                child: Text('Lanjutkan'),
                onPressed: () => ConnectDB()
                        .getTicket(polihint, dokterhint, widget.email, harga)
                        .then((value) {
                      Navigator.pop(context);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => PaymentState(
                                    success: value,
                                  )));
                    })),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    View().init(context);
    return Container(
      color: CustomColor().dark,
      child: SafeArea(
          child: WillPopScope(
        onWillPop: () => onWillpop(context),
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: CustomColor().dark,
            iconTheme: IconThemeData(color: Colors.white),
          ),
          backgroundColor: CustomColor().dark,
          body: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  flex: 2,
                  child: Lottie.asset('assets/ticket.json'),
                ),
                Expanded(
                  flex: 5,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      DropdownButton(
                        style: TextStyle(color: Colors.white),
                        hint: Text(
                          polihint,
                          style: TextStyle(color: Colors.white),
                        ),
                        dropdownColor: CustomColor().dark,
                        iconEnabledColor: Colors.white,
                        items: poli.map((item) {
                          return DropdownMenuItem(
                            value: item,
                            onTap: () {
                              dokter.clear();
                              harga.clear();
                              ConnectDB().listDokter(item).then((value) {
                                value.forEach((element) {
                                  setState(() {
                                    polihint = item;
                                    dokter.add(element['dokter'].toString());
                                    harga.add(element['harga']);
                                  });
                                });
                              });
                            },
                            child: SizedBox(
                              width: View.blockX * 60,
                              child: Text(
                                item,
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          );
                        }).toList(),
                        onChanged: (_) {},
                      ),
                      DropdownButton(
                        style: TextStyle(color: Colors.white),
                        hint: Text(
                          dokterhint,
                          style: TextStyle(color: Colors.white),
                        ),
                        dropdownColor: CustomColor().dark,
                        iconEnabledColor: Colors.white,
                        items: dokter.map((item) {
                          return DropdownMenuItem(
                            value: item,
                            onTap: () {
                              print(dokter.indexOf(item));
                              setState(() {
                                dokterhint = item;
                              });
                            },
                            child: SizedBox(
                              width: View.blockX * 60,
                              child: Text(
                                item,
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          );
                        }).toList(),
                        onChanged: (_) {},
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    decoration: BoxDecoration(),
                    child: FlatButton.icon(
                      icon: Icon(
                        Icons.send,
                        color: Colors.white,
                      ),
                      label: Text(
                        'Proses',
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () {
                        try {
                          var index = dokter.indexOf(dokterhint);
                          _dialog(context, harga[index]);
                        } catch (e) {
                          Fluttertoast.showToast(
                              msg: "Pilih poli & dokter terlebih dahulu",
                              backgroundColor: CustomColor().primary,
                              textColor: Colors.white);
                        }
                      },
                    ),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Container(),
                )
              ],
            ),
          ),
        ),
      )),
    );
  }
}
