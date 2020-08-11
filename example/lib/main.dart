import 'dart:async';

import 'package:fbroadcast_example/broadcast_keys.dart';
import 'package:fbroadcast_example/page_demo_1.dart';
import 'package:fbroadcast_example/page_demo_2.dart';
import 'package:fbroadcast_example/page_demo_3.dart';
import 'package:fbutton/fbutton.dart';
import 'package:fcommon/fcommon.dart';
import 'package:floading/floading.dart';
import 'package:flutter/material.dart';
import 'package:fbroadcast/fbroadcast.dart';
import 'package:ftoast/ftoast.dart';

import 'location_server.dart';

void main() {
  LocationServer();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var text = "Run Count And Goto Next";

  @override
  void initState() {
    FBroadcast.instance().register(Key_StopCount, (_, __) {
      runAddCount?.cancel();
      setState(() {
        text = "STOP!";
      });
    }, context: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print('text = $text');
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mainBackgroundColor,
        title: const Text(
          'FBroadcast',
          style: TextStyle(color: mainTextTitleColor),
        ),
        centerTitle: true,
      ),
      extendBodyBehindAppBar: true,
      body: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            FButton(
              width: 200,
              padding: EdgeInsets.only(top: 18.0, bottom: 18.0),
              alignment: Alignment.center,
              text: "Demo1: Runner",
              style: TextStyle(color: mainTextNormalColor),
              color: mainBackgroundColor,
              isSupportNeumorphism: true,
              corner: FCorner.all(6.0),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) {
                    return PageDemo1();
                  },
                ));
              },
            ),
            const SizedBox(height: 90),
            FButton(
              width: 200,
              padding: EdgeInsets.only(top: 18.0, bottom: 18.0),
              alignment: Alignment.center,
              text: "Demo2: User",
              style: TextStyle(color: mainTextNormalColor),
              color: mainBackgroundColor,
              isSupportNeumorphism: true,
              corner: FCorner.all(6.0),
              onPressed: () {
                FBroadcast.instance()
                    .stickyBroadcast(Key_MsgCount, value: ++msgCount);
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) {
                    return PageDemo2();
                  },
                ));
                addCount(context);
              },
            ),
            const SizedBox(height: 90),
            FButton(
              width: 200,
              padding: EdgeInsets.only(top: 18.0, bottom: 18.0),
              alignment: Alignment.center,
              text: "Demo3: Location",
              style: TextStyle(color: mainTextNormalColor),
              color: mainBackgroundColor,
              isSupportNeumorphism: true,
              corner: FCorner.all(6.0),
              onPressed: () {
                FBroadcast.instance()
                    .stickyBroadcast(Key_MsgCount, value: ++msgCount);
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) {
                    return PageDemo3();
                  },
                ));
              },
            ),
          ],
        ),
      ),
    );
  }

  int msgCount = 0;
  Timer runAddCount;

  addCount(BuildContext context) {
    runAddCount = Timer(Duration(milliseconds: 1000), () {
      FBroadcast.instance().broadcast(Key_MsgCount, value: ++msgCount);
      addCount(context);
    });
  }

  @override
  void dispose() {
    FBroadcast.instance().unregister(this);
    super.dispose();
  }
}
