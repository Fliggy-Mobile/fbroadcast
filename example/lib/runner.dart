import 'dart:async';

import 'package:fbroadcast/fbroadcast.dart';
import 'package:fbroadcast_example/broadcast_keys.dart';

class Runner {
  Runner() {
    /// register
    FBroadcast.instance().register(Key_RunnerState, (value, _) {
      if (value is String && value.contains("Run")) {
        /// receive start run message
        FBroadcast.instance().broadcast(Key_RunnerState, value: "0m..");
        run(20);
      }
    });
  }

  run(double distance) {
    /// send running message
    Timer(Duration(milliseconds: 500), () {
      FBroadcast.instance().broadcast(Key_RunnerState, value: "${distance.toInt()}m..");
      var newDistance = distance + 20;
      if (newDistance > 100) {
        FBroadcast.instance().broadcast(Key_RunnerState, value: "Win!\nTotal time is 2.5s");
      } else {
        run(newDistance);
      }
    });
  }
}
