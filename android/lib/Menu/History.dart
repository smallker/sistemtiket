import 'package:flutter/material.dart';
import 'package:sistemtiket/Menu/History/details.dart';
import '../services/Database.dart';
import '../services/View.dart';

class History extends StatefulWidget {
  final String user;
  History({Key key, this.user}) : super(key: key);
  @override
  _History createState() => _History();
}

class _History extends State<History> {
  List<String> id = [];
  List<String> waktu = [];
  List<String> dokter = [];
  List<int> harga = [];
  void initState() {
    super.initState();
    ConnectDB().getHistory(widget.user).then((value) {
      print(value);
      value.forEach((element) {
        print(element);
        setState(() {
          var time = element['waktu'];
          var parsetime = DateTime.fromMillisecondsSinceEpoch(time);
          id.add(element['id'].toString());
          waktu.add(parsetime.toString());
          dokter.add(element['dokter'].toString());
          harga.add(element['harga']);
        });
      });
    });
  }

  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    View().init(context);
    // id = id.reversed;
    // waktu = waktu.reversed;
    // dokter = dokter.reversed;
    // harga = harga.reversed;
    return Container(
      color: CustomColor().dark,
      child: SafeArea(
          child: Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.white),
          backgroundColor: CustomColor().dark,
        ),
        backgroundColor: CustomColor().dark,
        body: Stack(
          children: <Widget>[
            Positioned(
              top: View.blockY * 5,
              left: View.blockX * 10,
              child: Container(
                width: View.blockX * 80,
                height: View.blockY * 13,
                alignment: Alignment.center,
                child: CustomCard(
                  color: CustomColor().green,
                  lottie: 'assets/history.json',
                  title: 'Riwayat Transaksi',
                  subtitle: 'Riwayat transaksi anda',
                  function: null,
                ),
              ),
            ),
            Positioned(
              top: View.blockY * 20,
              left: View.blockX * 10,
              width: View.blockX * 80,
              height: View.blockY * 60,
              child: ListView.builder(
                itemCount: id.length,
                itemBuilder: (context, index) {
                  return CustomCard(
                    color: CustomColor().primary,
                    icon: Icon(
                      Icons.history,
                      color: Colors.white,
                    ),
                    title: 'No. Antri : ${id[index]}',
                    subtitle: waktu[index],
                    function: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (_) => TicketDetails(
                                    dokter: dokter[index],
                                    email: widget.user,
                                    id: id[index],
                                    // harga: harga[index],
                                    waktu: waktu[index],
                                  )));
                    },
                  );
                },
              ),
            )
          ],
        ),
      )),
    );
  }
}
