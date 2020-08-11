import 'package:fbroadcast/fbroadcast.dart';
import 'package:fbroadcast_example/broadcast_keys.dart';
import 'package:fbroadcast_example/runner.dart';
import 'package:fbutton/fbutton.dart';
import 'package:fcommon/fcommon.dart';
import 'package:floading/floading.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fsuper/fsuper.dart';

class PageDemo3 extends StatefulWidget {
  @override
  _PageDemo3State createState() => _PageDemo3State();
}

class _PageDemo3State extends State<PageDemo3> {
  List<double> location = [];

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return Future.value(true);
      },
      child: Material(
        child: Container(
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Stack(
                children: <Widget>[
                  buildBoard(),
                  ...buildGrid(),
                ],
              ),
              const SizedBox(height: 100),
              FButton(
                width: 150,
                height: 50,
                text: "Location",
                style: TextStyle(color: mainTextTitleColor),
                alignment: Alignment.center,
                color: mainBackgroundColor,
                isSupportNeumorphism: true,
                corner: FCorner.all(6.0),
                onPressed: () {
                  FLoading.show(context,
                      color: Colors.black26, loading: buildLoading());
                  /// request location
                  FBroadcast.instance().broadcast(Key_Location,
                      callback: (location) {
                    /// The message returned by the receiver
                    setState(() {
                      FLoading.hide();
                      this.location = location;
                    });
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildBoard() {
    var hasLocation = (location != null && location.isNotEmpty);
    return FSuper(
      width: 280,
      height: 150,
      backgroundColor: Colors.white,
      corner: FCorner.all(6.0),
      shadowColor: mainShadowColor,
      shadowBlur: 5.0,
      shadowOffset: Offset(2.0, 2.0),
      style: TextStyle(color: Colors.greenAccent, fontSize: 25),
      textAlignment: Alignment.center,
      child1: !hasLocation
          ? null
          : FSuper(
              width: 5,
              height: 5,
              corner: FCorner.all(2.5),
              backgroundColor: Colors.redAccent,
            ),
      child1Alignment: Alignment.topLeft,
      child1Margin: !hasLocation
          ? EdgeInsets.only(left: 0, top: 0)
          : EdgeInsets.only(left: location[0], top: location[1]),
      child2: Text(
        !hasLocation
            ? ""
            : "(${location[0].toStringAsFixed(2)}, ${location[1].toStringAsFixed(2)})",
        style: TextStyle(color: Colors.redAccent, fontSize: 8),
      ),
      child2Alignment: Alignment.topLeft,
      child2Margin: !hasLocation
          ? EdgeInsets.only(left: 0, top: 0)
          : EdgeInsets.only(
              left: location[0] + 5 + 2, top: location[1] + 5 + 2),
    );
  }

  Material buildLoading() {
    return Material(
        color: Colors.transparent,
        child: FSuper(
          text: "    Locating..",
          spans: [
            TextSpan(text: "\nPlease wait", style: TextStyle(fontSize: 11))
          ],
          style: TextStyle(color: mainTextTitleColor, fontSize: 20),
          child1: CupertinoActivityIndicator(radius: 6),
          child1Alignment: Alignment.topLeft,
          child1Margin: EdgeInsets.only(top: 5.5),
        ));
  }

  List<Widget> buildGrid() {
    return [
      Container(
        width: 280,
        height: 150,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Container(
              width: 280,
              height: 0.5,
              color: Colors.grey[400],
            ),
            Container(
              width: 280,
              height: 0.5,
              color: Colors.grey[400],
            ),
            Container(
              width: 280,
              height: 0.5,
              color: Colors.grey[400],
            ),
          ],
        ),
      ),
      Container(
        width: 280,
        height: 150,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Container(
              width: 0.5,
              height: 150,
              color: Colors.grey[400],
            ),
            Container(
              width: 0.5,
              height: 150,
              color: Colors.grey[400],
            ),
            Container(
              width: 0.5,
              height: 150,
              color: Colors.grey[400],
            ),
          ],
        ),
      ),
    ];
  }
}
