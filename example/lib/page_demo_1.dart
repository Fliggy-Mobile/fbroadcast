import 'package:fbroadcast/fbroadcast.dart';
import 'package:fbroadcast_example/broadcast_keys.dart';
import 'package:fbroadcast_example/runner.dart';
import 'package:fbutton/fbutton.dart';
import 'package:fcommon/fcommon.dart';
import 'package:flutter/material.dart';
import 'package:fsuper/fsuper.dart';

class PageDemo1 extends StatelessWidget {
  Runner runner = Runner();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        FBroadcast.instance().clear(Key_RunnerState);
        return Future.value(true);
      },
      child: Material(
        child: Container(
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Stateful(
                /// init
                initState: (setState, data) {
                  FBroadcast.instance().register(
                    Key_RunnerState,
                    (value, _) {
                      /// update
                      setState(() {});
                    },

                    /// bind context
                    context: data,
                  );
                },
                builder: (context, setState, data) {
                  return FSuper(
                    width: 280,
                    height: 150,
                    backgroundColor: Colors.grey[800],
                    corner: FCorner.all(6.0),
                    shadowColor: mainShadowColor,
                    shadowBlur: 5.0,
                    shadowOffset: Offset(2.0, 2.0),
                    style: TextStyle(color: Colors.greenAccent, fontSize: 25),
                    textAlignment: Alignment.center,

                    /// get value
                    text: FBroadcast.value(Key_RunnerState) ?? "Preparing..",
                  );
                },
              ),
              const SizedBox(height: 100),
              FButton(
                width: 100,
                height: 50,
                text: "Start",
                style: TextStyle(color: mainTextTitleColor),
                alignment: Alignment.center,
                color: mainBackgroundColor,
                isSupportNeumorphism: true,
                corner: FCorner.all(6.0),
                onPressed: () {
                  /// send run message
                  FBroadcast.instance()
                      .broadcast(Key_RunnerState, value: "Running...");
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
