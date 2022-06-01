import 'dart:convert';
import 'package:flutter/foundation.dart';
export 'package:fbroadcast/stateful.dart';

/// [FBroadcast] 帮助开发者在应用内建立一套高效的广播系统，注册到系统中的接收者，将能接收到任意位置发送的对应类型的消息。
/// 同时，[FBroadcast] 还支持了粘性广播，这将帮助开发这轻松处理一些复杂的通讯场景。
///
/// [FBroadcast] Help developers build an efficient broadcast system in the application. Receivers registered in the system will be able to receive corresponding types of messages sent anywhere.
/// At the same time, [FBroadcast] also supports sticky broadcasting, which will help developers easily handle some complex communication scenarios.
class FBroadcast {
  static bool debug = false;
  static final Map<dynamic, FBroadcast> _broadcastMap = {};
  late Map<String, _Notifier<dynamic>> _map;
  late Map<String, List<_Notifier>> _stickyMap;
  late Map<Object?, List<ResultCallback>> _receiverCache;
  String _type = "extra";
  dynamic _key;

  FBroadcast._({String? type}) {
    _type = type ?? "extra";
    _map = {};
    _stickyMap = {};
    _receiverCache = {};
  }

  static FBroadcast _instance = FBroadcast._(type: "system");

  /// 获取 [FBroadcast] 系统实例，已进行注册/广播等操作
  ///
  /// Obtained [FBroadcast] system instance, registered/broadcast and other operations have been performed
  ///
  /// [context] 作用域环境。通过作用域环境获取到广播系统，其有效范围将会被限制在作用域范围内（即 context 环境中）。
  ///           作用域内发送的广播，只能被作用域内注册的接收器所接收。而其它作用域将不受其影响，即使它们使用了相同的 Key。
  ///           context 可以是任意类型的对象实例。
  ///           通过 [FBroadcast.dispose] 可以释放一个广播系统。
  ///           如果 [context] 为 null，将返回全局广播。
  /// [context] Scope environment. The broadcast system is acquired through the scope environment, and its effective scope will be limited within the scope (ie in the context environment).
  ///           Broadcasts sent within the scope can only be received by receivers registered in the scope. The other scopes will not be affected by it, even if they use the same Key.
  ///           context can be any type of object instance.
  ///           A broadcast system can be released through [FBroadcast.dispose].
  ///           If [context] is null, global broadcast will be returned.
  static FBroadcast instance([dynamic context]) {
    if (context == null) {
      return _instance;
    } else {
      if (_broadcastMap.containsKey(context) &&
          _broadcastMap[context] != null) {
        return _broadcastMap[context]!;
      } else {
        FBroadcast newObj = FBroadcast._();
        newObj._key = context;
        _broadcastMap[context] = newObj;
        return newObj;
      }
    }
  }

  /// 接收者可以通过该函数获取消息中的数据
  ///
  /// This function allows the receiver to get the data in the message
  static T? value<T>(String key) {
    if (_textIsEmpty(key)) return null;
    var value = instance()._map[key]?.value;
    if (value == null) return null;
    if (!(value is T)) {
      debugPrintStack(
          label: 'Error: value type [${value.runtimeType}] is not [$T]');
    }
    return value;
  }

  _Notifier _get(String key) {
    if (_textIsEmpty(key)) throw Exception("The key can't be null or empty!");
    if (!_map.containsKey(key)) {
      _map[key] = _Notifier(null);
    }
    return _map[key]!;
  }

  List _getReceivers(Object? context) {
    if (_receiverCache[context] == null) {
      _receiverCache[context] = [];
    }
    return _receiverCache[context]!;
  }

  /// 广播一条 [key] 类型的消息。
  /// 已经注册在系统中的接收者将会接收到本条消息。
  /// 接收者通过 [value] 可以获取到本条消息携带的数据。
  /// [key] - 消息类型
  /// [value] - 消息携带的数据。可以是任意类型或是null。
  /// [callback] - 能够收到接收器返回的消息
  /// [persistence] - 是否持久化消息类型。持久化的消息可以在任意时刻通过 [FBroadcast.value] 获取当前消息的数据包。默认情况下，未持久化的消息类型在没有接收者的时候会被移除，而持久化的消息类型则不会。开发者可以通过 [clear] 函数来移除持久化的消息类型。
  ///
  /// Broadcast a message of type [key].
  /// Recipients already registered in the system will receive this message.
  /// The receiver can get the data carried in this message through [value].
  /// [key] - Message type
  /// [value] - The data carried in the message. Can be any type or null.
  /// [callback] - Able to receive the message returned by the receiver
  /// [persistence] - Whether or not to persist message types. Persistent messages can be retrieved at any time by [FBroadcast. Value] for the current message packet. By default, unpersisted message types are removed without a receiver, while persisted message types are not. Developers can use the [clear] function to remove persistent message types.
  void broadcast(String key,
      {dynamic value, ValueCallback? callback, bool persistence = false}) {
    if (_textIsEmpty(key)) return;
    if (persistence && !_get(key).persistence) {
      _get(key).persistence = true;
    }
    _get(key).callback = callback;
    if (value == null || _get(key).value == value) {
      _get(key).notifyListeners();
    } else {
      _get(key).value = value;
    }
  }

  /// 广播一条 [key] 类型的粘性消息。
  /// 如果广播系统中还有没注册该类型的接收者，本条消息将被滞留在系统中。一旦有该类型接收者被注册，本条消息将会被立即发送给接收者。
  /// 如果系统中已经注册有该类型的接收者，本条消息将会被立即发送给接收者。
  /// 接收者通过 [value] 可以获取到本条消息携带的数据。
  /// [key] - 消息类型
  /// [value] - 消息携带的数据。可以是任意类型或是null。
  /// [callback] - 能够收到接收器返回的消息
  /// [persistence] - 是否持久化消息类型。持久化的消息可以在任意时刻通过 [FBroadcast.value] 获取当前消息的数据包。默认情况下，未持久化的消息类型在没有接收者的时候会被移除，而持久化的消息类型则不会。开发者可以通过 [clear] 函数来移除持久化的消息类型。
  ///
  /// Broadcast a sticky message of type [key].
  /// If there are unregistered receivers of this type in the broadcast system, this message will be stuck in the system. Once a recipient of this type is registered, this message will be sent to the recipient immediately.
  /// If this type of receiver is already registered in the system, this message will be sent to the receiver immediately.
  /// The receiver can get the data carried in this message through [value].
  ///
  /// [key] - Message type
  /// [value] - The data carried in the message. Can be any type or null.
  /// [callback] - Able to receive the message returned by the receiver
  /// [persistence] - Whether or not to persist message types. Persistent messages can be retrieved at any time by [FBroadcast. Value] for the current message packet. By default, unpersisted message types are removed without a receiver, while persisted message types are not. Developers can use the [clear] function to remove persistent message types.
  void stickyBroadcast(String key,
      {dynamic value, ValueCallback? callback, bool persistence = false}) {
    if (_map == null) return;
    if (_textIsEmpty(key)) return;
    if (persistence && !_get(key).persistence) {
      _get(key).persistence = true;
    }
    if (_map.containsKey(key) && _map[key]!.hasListeners) {
      broadcast(key, value: value, callback: callback);
    } else {
      if (_stickyMap[key] == null) {
        _stickyMap[key] = [];
      }
      _stickyMap[key]!.add(_Notifier(value)..callback = callback);
    }
  }

  /// 注册指定类型的接收者。
  /// 如果传入了 [context] 环境，该接收者将会被注册到环境中。环境可以是任意类型的对象，例如：页面、类..
  /// 接收者通过 [value] 可以获取到本条消息携带的数据。
  /// 当调用 [unregister] 时，该接收者即会被清除。
  /// [key] - 消息类型
  /// [receiver] - 接收者
  /// [context] - 环境。不为null，[receiver] 将会被注册到环境中。
  /// [more] - 方便一次注册多个接收者
  ///
  /// Register recipients of the specified type.
  /// If the [context] environment is passed in, the recipient will be registered in the environment. The environment can be any type of object, for example: page, class...
  /// The receiver can get the data carried in this message through [value].
  /// When [unregister] is called, the receiver will be cleared.
  /// [key]-message type
  /// [receiver] - receiver
  /// [context] - context. Not null, [receiver] will be registered in the environment.
  /// [more] - Make it easy to register multiple recipients at once
  FBroadcast register(
    String key,
    ResultCallback receiver, {
    Object? context,
    Map<String, ResultCallback>? more,
  }) {
    if (_map == null) return this;
    if (!_textIsEmpty(key)) {
      _get(key).addListener(receiver);
      if (!_getReceivers(context).contains(receiver)) {
        _receiverCache[context]!.add(receiver);
      }
      if (_stickyMap[key] != null) {
        _stickyMap[key]!.forEach((element) {
          _Notifier notifier = element;
//          _stickyMap.remove(key);
          broadcast(key, value: notifier.value, callback: notifier.callback);
        });
        _stickyMap.remove(key);
      }
    }
    if (more?.isNotEmpty ?? false) {
      more?.forEach((key, value) {
        _get(key).addListener(value);
        if (!_getReceivers(context).contains(value)) {
          _receiverCache[context]!.add(value);
        }
        if (_stickyMap[key] != null) {
          _stickyMap[key]?.forEach((element) {
            _Notifier notifier = element;
//          _stickyMap.remove(key);
            broadcast(key, value: notifier.value, callback: notifier.callback);
          });
          _stickyMap.remove(key);
        }
      });
    }
    return this;
  }

  /// 移除指定的接收者 [receiver]。
  /// 如果指定了 [key]、[context] 将有助于更快的移除指定接收者。
  /// [receiver] - 接收者
  /// [key] - 消息类型
  /// [context] - 环境。
  ///
  /// Remove the specified receiver [receiver].
  /// If [key] and [context] are specified, it will help to remove the specified recipient faster.
  /// [receiver] - receiver
  /// [key]-message type
  /// [context] - context.
  void remove(ResultCallback receiver, {String? key, Object? context}) {
    if (_map == null) return;
    if (receiver == null) return;
    if (!_textIsEmpty(key)) {
      _get(key!).removeListener(receiver);
    } else {
      _map.forEach((k, value) {
        value.removeListener(receiver);
      });
    }
    _cleanMap();
    if (context != null) {
      _getReceivers(context).remove(receiver);
      if (_getReceivers(context).isEmpty) {
        _receiverCache.remove(context);
      }
    } else {
      List<Object?> needRemove = [];
      _receiverCache.forEach((k, value) {
        value.remove(receiver);
        if (value.isEmpty) needRemove.add(k);
      });
      needRemove.forEach((k) {
        _receiverCache.remove(k);
      });
    }
  }

  /// 移除广播系统中，注册到 [context] 环境内的所有接收者。
  /// 例如，在页面关闭时，开发者可以通过 [unregister] 一次性移除注册到该环境内的所有接收者。
  /// 当然，前提时在接收者通过 [register] 注册的时候，传入 [context]，将接收者注册到该环境中。
  /// [context] - 环境。
  ///
  /// Remove all receivers registered in the [context] environment from the broadcast system.
  /// For example, when the page is closed, the developer can use [unregister] to remove all recipients registered in the environment at once.
  /// Of course, the prerequisite is that when the receiver registers through [register], pass in [context] to register the receiver to the environment.
  /// [context] - context.
  void unregister(Object context, {bool async = false}) {
    if (async) {
      _unregisterAsync(context);
    } else {
      _unregister(context);
    }
  }

  void _unregister(Object context) {
    if (_map == null) return;
    for (ResultCallback listener in _getReceivers(context)) {
      _map.forEach((key, notifier) {
        notifier.removeListener(listener);
      });
    }
    _cleanMap();
    _getReceivers(context).clear();
    _receiverCache.remove(context);
  }

  /// 异步解注册，防止注册过多导致解注册时卡顿
  Future<bool> _unregisterAsync(Object context) async {
    if (_map == null) return false;
    List notifys = _map.values.toList();
    for (ResultCallback listener in _getReceivers(context)) {
      for (_Notifier notify in notifys) {
        await Future.delayed(Duration(milliseconds: 0));
        notify.removeListener(listener);
      }
    }
    _cleanMap();
    _getReceivers(context).clear();
    _receiverCache.remove(context);
    return true;
  }

  /// 移除没有接收器，且不持久化的 [_Notifier]
  ///
  /// Removes a [Notifier] that does not have a receiver and is not persistent
  void _cleanMap() {
    if (_map == null) return;
    List<String> needRemove = [];
    _map.forEach((key, value) {
      if (!value.hasListeners && !value.persistence) {
        needRemove.add(key);
      }
    });
    needRemove.forEach((key) {
      clear(key);
    });
  }

  /// 移除广播系统中的指定 [key] 类型的所有接收者，以及该类型的粘性广播。
  /// [key] - 类型
  ///
  /// Remove all receivers of the specified [key] type in the broadcast system and sticky broadcasts of that type.
  ///  [key] - type
  void clear(String key) {
    if (_map == null) return;
    _Notifier? remove = _map.remove(key);
    if (remove?.hasListeners ?? false) {
      remove?.listeners?.forEach((receiver) {
        _receiverCache.forEach((key, value) {
          value.remove(receiver);
        });
      });
      List<Object?> needRemove = [];
      _receiverCache.forEach((k, value) {
        if (value.isEmpty) needRemove.add(k);
      });
      needRemove.forEach((k) {
//        print('needRemove = $k');
        _receiverCache.remove(k);
      });
//      print('size = ${_receiverCache.length}');
    }
    remove?.dispose();
    _stickyMap.remove(key);
  }

  /// 会移除当前广播系统实例中的所有的数据。
  ///
  /// All data in the current broadcast system instance will be removed.
  void dispose() {
    if (_type == "extra" && _key != null) {
      _broadcastMap.remove(_key);
    }
  }

  /// 输出 FBroadcast 系统中的驻留广播信息
  static void printFBroadcastInfo() {
    if (FBroadcast.debug) {
      _printFBroadcastInfo(fBroadcast: FBroadcast.instance());
      FBroadcast._broadcastMap.forEach((key, value) {
        _printFBroadcastInfo(context: key, fBroadcast: value);
      });
    }
  }

  static void _printFBroadcastInfo(
      {dynamic context, required FBroadcast fBroadcast}) {
    int total1 = 0;
    Map reciverInfos1 = {};
    fBroadcast._map.forEach((key, value) {
      int count = value._listeners?.length ?? 0;
      total1 += count;
      reciverInfos1[key] = {
        "count": count,
      };
    });
    int total2 = 0;
    Map reciverInfos2 = {};
    fBroadcast._stickyMap.forEach((key, value) {
      int count = value.length;
      total2 += count;
      reciverInfos2[key] = {
        "count": count,
      };
    });
    String tag = context == null ? "【系统级】" : "【${context.toString()}级】";
    if (reciverInfos1.isEmpty && reciverInfos2.isEmpty) {
      _fdebugPrint("$tag当前系统中无驻留广播");
    } else {
      if (reciverInfos1.isNotEmpty) {
        _fdebugPrint(
            "$tag当前驻留系统的[普通广播]，共 $total1 条：${jsonEncode(reciverInfos1)}");
      }
      if (reciverInfos2.isNotEmpty) {
        _fdebugPrint(
            "$tag当前驻留系统的[Sticky 广播]，共 $total2 条：${jsonEncode(reciverInfos2)}");
      }
    }
  }
}

/// --------------------------------------------------------------------------------
bool _textIsEmpty(String? text) {
  return text == null || text.length == 0;
}

typedef ValueCallback<T> = void Function(T value);
typedef ResultCallback<T> = void Function(T value, ValueCallback? callback);

class _Notifier<T> {
  late bool persistence;
  ValueCallback? callback;

  T get value => _value;
  late T _value;

  set value(T newValue) {
    if (_value == newValue) return;
    _value = newValue;
    notifyListeners();
  }

  ObserverList<ResultCallback>? _listeners = ObserverList<ResultCallback>();

  _Notifier(
    value, {
    this.persistence = false,
  }) {
    _value = value;
  }

  bool _debugAssertNotDisposed() {
    assert(() {
      if (_listeners == null) {
        throw FlutterError('A $runtimeType was used after being disposed.\n'
            'Once you have called dispose() on a $runtimeType, it can no longer be used.');
      }
      return true;
    }());
    return true;
  }

  ObserverList<ResultCallback>? get listeners {
    return _listeners;
  }

  bool get hasListeners {
    assert(_debugAssertNotDisposed());
    return _listeners?.isNotEmpty ?? false;
  }

  void addListener(ResultCallback listener) {
    assert(_debugAssertNotDisposed());
    _listeners?.add(listener);
  }

  void removeListener(ResultCallback listener) {
    assert(_debugAssertNotDisposed());
    _listeners?.remove(listener);
  }

  void dispose() {
    assert(_debugAssertNotDisposed());
    _listeners = null;
  }

  void notifyListeners() {
    assert(_debugAssertNotDisposed());
    if (_listeners != null) {
      final List<ResultCallback> localListeners = List.from(_listeners!);
      for (final ResultCallback listener in localListeners) {
        try {
          if (_listeners!.contains(listener)) listener(value, callback);
        } catch (exception) {}
      }
      callback = null;
    }
  }

  @override
  String toString() => '${describeIdentity(this)}($value)';
}

_fdebugPrint(String msg, {String tag = "FBroadcast: "}) {
  if (FBroadcast.debug) {
    var dateTime = DateTime.now();
    String r = "[$dateTime(${dateTime.millisecondsSinceEpoch})] $tag $msg";
    if (r.length < 800) {
      print(r);
    } else {
      _segmentationPrint(r);
    }
  }
}

void _segmentationPrint(String msg) {
  print("------- split log start -------");
  var outStr = StringBuffer();
  for (var index = 0; index < msg.length; index++) {
    outStr.write(msg[index]);
    if (index % 800 == 0 && index != 0) {
      print(outStr);
      outStr.clear();
      var lastIndex = index + 1;
      if (msg.length - lastIndex < 800) {
        var remainderStr = msg.substring(lastIndex, msg.length);
        print(remainderStr);
        break;
      }
    }
  }
  print("------- split log end -------");
}
