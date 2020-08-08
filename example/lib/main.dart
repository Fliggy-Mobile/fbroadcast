import 'dart:async';

import 'package:fbroadcast_example/broadcast_keys.dart';
import 'package:fbroadcast_example/page_demo_1.dart';
import 'package:fbutton/fbutton.dart';
import 'package:fcommon/fcommon.dart';
import 'package:flutter/material.dart';
import 'package:fbroadcast/fbroadcast.dart';

void main() {
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
    FBroadcast.instance().register(Key_StopCount, () {
      runAddCount?.cancel();
      print('STOP!');
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
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            alignment: Alignment.center,
            child: FButton(
              padding: EdgeInsets.only(
                  left: 16.0, right: 16.0, top: 12.0, bottom: 12.0),
              text: text,
              style: TextStyle(color: mainTextNormalColor),
              color: mainBackgroundColor,
              isSupportNeumorphism: true,
              corner: FCorner.all(6.0),
              onPressed: () {
                FBroadcast.instance().stickyBroadcast(Key_MsgCount, ++msgCount);
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) {
                    return PageDemo1();
                  },
                ));
                addCount();
                setState(() {
                  text = "Run Count And Goto Next";
                });
              },
            ),
          ),
        ],
      ),
    );
  }

  int msgCount = 0;
  Timer runAddCount;

  addCount() {
    runAddCount = Timer(Duration(milliseconds: 1000), () {
      FBroadcast.instance().broadcast(Key_MsgCount, ++msgCount);
      addCount();
    });
  }

  @override
  void dispose() {
    FBroadcast.instance().unregister(this);
    super.dispose();
  }
}
