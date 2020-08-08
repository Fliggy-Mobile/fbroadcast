import 'package:fbroadcast/fbroadcast.dart';
import 'package:fbroadcast_example/broadcast_keys.dart';
import 'package:fbutton/fbutton.dart';
import 'package:fcommon/fcommon.dart';
import 'package:flutter/material.dart';
import 'package:fsuper/fsuper.dart';

// ignore: camel_case_types
class PageDemo1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: Colors.white,
        child: Stack(
          children: <Widget>[
            FSuper(
              width: double.infinity,
              height: 250.0,
              gradient: LinearGradient(colors: [
                Color(0xffe1eec3),
                Color(0xfff05053),
//              Color(0xfff7797d),
              ]),
            ),
            Container(
              margin:
                  EdgeInsets.only(top: MediaQuery.of(context).viewPadding.top),
              height: 48,
              child: FButton(
                width: 48,
                image: Icon(Icons.arrow_back_ios, color: Colors.grey[200],),
                onPressed: () {
                  Navigator.pop(
                    context,
                  );
                },
              ),
            ),
            FSuper(
              width: double.infinity,
              height: double.infinity,
              margin: EdgeInsets.only(top: 230),
              backgroundColor: Colors.white,
              shadowColor: mainShadowColor,
              shadowBlur: 10.0,
              corner: FCorner(leftTopCorner: 22, rightTopCorner: 22),

              /// avatar
              child1: Avatar(),
              child1Alignment: Alignment.topCenter,
              child1Margin: EdgeInsets.only(bottom: 35),
              child2: Container(
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.all(12),
                child: Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        FSuper(
                          width: 200,
                          height: 100,
                          backgroundColor: mainBackgroundColor,
                          corner: FCorner.all(6.0),
                        ),
                        FSuper(
                          width: 150,
                          height: 100,
                          backgroundColor: mainBackgroundColor,
                          corner: FCorner.all(6.0),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    FSuper(
                      width: double.infinity,
                      height: 100,
                      backgroundColor: mainBackgroundColor,
                      corner: FCorner.all(6.0),
                    ),
                    const SizedBox(height: 16),
                    FSuper(
                      width: double.infinity,
                      height: 100,
                      backgroundColor: mainBackgroundColor,
                      corner: FCorner.all(6.0),
                    ),
                    const SizedBox(height: 16),
                    FSuper(
                      width: double.infinity,
                      height: 100,
                      backgroundColor: mainBackgroundColor,
                      corner: FCorner.all(6.0),
                    ),
                  ],
                ),
              ),
              child2Alignment: Alignment.topLeft,
              child2Margin: EdgeInsets.only(top: 80),
            ),
          ],
        ),
      ),
    );
  }
}

class Avatar extends StatefulWidget {
  @override
  _AvatarState createState() => _AvatarState();
}

class _AvatarState extends State<Avatar> {
  int msgCount = 0;

  @override
  void initState() {
    super.initState();
    FBroadcast.instance().register(Key_MsgCount, () {
      setState(() {
        msgCount = FBroadcast.instance().value(Key_MsgCount);
      });
    }, context: this);
  }

  @override
  Widget build(BuildContext context) {
    return FSuper(
      width: 90,
      height: 90,
      corner: FCorner.all(50),
      backgroundImage: AssetImage("assets/logo.png"),
      shadowColor: mainShadowColor,
      shadowBlur: 10.0,
      redPoint: msgCount > 0,
      redPointOffset: Offset(2.0, 2.0),
      redPointText: msgCount?.toString() ?? "",
    );
  }
  
  @override
  void dispose() {
    super.dispose();
    FBroadcast.instance().broadcast(Key_StopCount);
    FBroadcast.instance().unregister(this);
  }
}
