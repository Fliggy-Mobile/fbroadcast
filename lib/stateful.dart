import 'package:fbroadcast/fbroadcast.dart';
import 'package:flutter/material.dart';

typedef StatefulCallback = void Function(StateSetter setState, Map data);
typedef StatefulBuilder = Widget Function(
    BuildContext context, StateSetter setState, Map data);

class Stateful extends StatefulWidget {
  final StatefulCallback? initState;
  final ValueCallback? didUpdateWidget;
  final ValueCallback? dispose;
  final StatefulBuilder builder;

  Stateful({
    Key? key,
    this.initState,
    this.didUpdateWidget,
    this.dispose,
    required this.builder,
  }) : super(key: key);

  @override
  _StatefulState createState() => _StatefulState();
}

class _StatefulState extends State<Stateful> {
  Map data = {};

  @override
  void initState() {
    data["this"] = this;
    widget.initState?.call(setState, data);
    super.initState();
  }

  @override
  void didUpdateWidget(Stateful oldWidget) {
    widget.didUpdateWidget?.call(data);
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder(context, setState, data);
  }

  @override
  void dispose() {
    widget.dispose?.call(data);
    data.clear();
    FBroadcast.instance().unregister(data);
    FBroadcast.instance().unregister(this);
    super.dispose();
  }
}
