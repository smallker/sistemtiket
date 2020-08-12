import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:lottie/lottie.dart';

class View {
  MediaQueryData _mediaQueryData;
  static double x;
  static double y;
  static double blockX;
  static double blockY;
  void init(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    _mediaQueryData = MediaQuery.of(context);
    x = _mediaQueryData.size.width;
    y = _mediaQueryData.size.height;
    blockX = x / 100;
    blockY = y / 100;
  }
}

class Button extends StatelessWidget {
  final String action;
  final Function function;
  const Button({Key key, this.action, this.function}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: CustomColor().primary.withOpacity(0.4)),
      child: FlatButton(
        child: Text(
          action,
          style: CustomText().buttontext,
        ),
        onPressed: function,
      ),
    );
  }
}

class CustomColor {
  final text = Color(0xFF707070);
  final primary = Color(0xFF1D99A7);
  final primary80 = Color(0xBF1D99A7);
  final warning = Color(0xFFE27070);
  final green = Color(0xFF19782E);
  final dark = Color(0xFF172F37);
}

class CustomText {
  final buttontext = TextStyle(color: Colors.white, fontSize: View.blockX * 4);
}

class CustomCard extends StatefulWidget {
  final Color color;
  final String title, subtitle, lottie;
  final Icon icon;
  final Function function;
  const CustomCard(
      {Key key,
      this.lottie,
      this.color,
      this.title,
      this.icon,
      this.function,
      this.subtitle})
      : super(key: key);
  @override
  CustomCardState createState() => CustomCardState();
}

class CustomCardState extends State<CustomCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10), color: widget.color),
      margin: EdgeInsets.only(top: 5, bottom: 5),
      child: ListTile(
        leading: widget.lottie != null
            ? Lottie.asset(widget.lottie, width: View.blockX * 15)
            : widget.icon,
        title: Text(widget.title,
            style: TextStyle(fontSize: View.blockX * 6, color: Colors.white)),
        subtitle: Text(
          widget.subtitle,
          style: TextStyle(fontSize: View.blockX * 4, color: Colors.white),
        ),
        onTap: widget.function,
      ),
    );
  }
}
