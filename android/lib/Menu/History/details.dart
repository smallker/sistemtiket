import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sistemtiket/Menu.dart';
import 'package:sistemtiket/services/Database.dart';
import '../../services/View.dart';

class TicketDetails extends StatefulWidget {
  final String email, dokter, waktu, id;
  final int harga;
  TicketDetails(
      {Key key, this.email, this.dokter, this.waktu, this.id, this.harga})
      : super(key: key);
  @override
  _TicketDetails createState() => _TicketDetails();
}

class _TicketDetails extends State<TicketDetails> {
  bool iscancel = false;
  @override
  void initState() {
    super.initState();
    print('${widget.id}');
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _dialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        return AlertDialog(
          title: Text('Batalkan pemesanan?'),
          content: Text(
              'Pesanan anda untuk nomor antrian ${widget.id} akan dibatalkan'),
          actions: <Widget>[
            FlatButton(
              child: Text('Batal'),
              onPressed: () => Navigator.pop(context),
            ),
            FlatButton(
              child: Text('Lanjutkan'),
              onPressed: () {
                setState(() {
                  iscancel = true;
                });
                Navigator.pop(context);
                ConnectDB().cancelOrder(
                    widget.email, widget.id, widget.dokter, widget.harga);
              },
            ),
          ],
        );
      },
    );
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

  @override
  Widget build(BuildContext context) {
    View().init(context);
    List<String> waktu = widget.waktu.split('.');
    return Container(
      color: CustomColor().dark,
      child: SafeArea(
          child: WillPopScope(
        onWillPop: () => onWillpop(context),
        child: Scaffold(
          floatingActionButton: iscancel == false
              ? FloatingActionButton.extended(
                  icon: Icon(Icons.cancel),
                  backgroundColor: CustomColor().dark,
                  label: Text('Batalkan pesanan'),
                  tooltip: 'Batalkan pesanan anda',
                  onPressed: () => _dialog(context),
                )
              : FloatingActionButton.extended(
                  backgroundColor: CustomColor().dark,
                  label: Text('Pesanan dibatalkan'),
                  tooltip: 'Pesanan telah dibatalkan',
                  onPressed: () => null,
                ),
          backgroundColor: CustomColor().dark,
          appBar: AppBar(
            iconTheme: IconThemeData(color: Colors.white),
            backgroundColor: CustomColor().dark,
          ),
          body: Stack(
            children: <Widget>[
              Positioned(
                width: View.x,
                height: View.y / 3,
                top: 0,
                child: Center(
                  child: Lottie.asset('assets/support.json'),
                ),
              ),
              Positioned(
                width: View.x,
                top: View.y / 3,
                height: View.y / 2,
                child: Center(
                    child: Column(
                  children: <Widget>[
                    CustomCard(
                      icon: Icon(
                        Icons.note_add,
                        color: Colors.white,
                      ),
                      color: CustomColor().dark,
                      title: widget.id,
                      subtitle: 'Nomor antrian',
                    ),
                    CustomCard(
                      icon: Icon(
                        Icons.person,
                        color: Colors.white,
                      ),
                      color: CustomColor().dark,
                      title: widget.dokter,
                      subtitle: 'Nama dokter',
                    ),
                    // CustomCard(
                    //   icon: Icon(
                    //     Icons.account_balance_wallet,
                    //     color: Colors.white,
                    //   ),
                    //   color: CustomColor().dark,
                    //   title: widget.harga.toString(),
                    //   subtitle: 'Biaya',
                    // ),
                    CustomCard(
                      icon: Icon(
                        Icons.timer,
                        color: Colors.white,
                      ),
                      color: CustomColor().dark,
                      title: waktu[0],
                      subtitle: 'Waktu pemeriksaan',
                    ),
                  ],
                )),
              )
            ],
          ),
        ),
      )),
    );
  }
}
