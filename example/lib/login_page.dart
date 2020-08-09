import 'package:fbroadcast/fbroadcast.dart';
import 'package:fbroadcast_example/broadcast_keys.dart';
import 'package:fbroadcast_example/handler_login.dart';
import 'package:fbutton/fbutton.dart';
import 'package:fcommon/fcommon.dart';
import 'package:floading/floading.dart';
import 'package:flutter/material.dart';
import 'package:fsearch/fsearch.dart';
import 'package:fsuper/fsuper.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  LoginHandler handler = LoginHandler();
  FSearchController _controller1 = FSearchController();
  FSearchController _controller2 = FSearchController();

  @override
  void initState() {
    super.initState();
    _controller1.setListener(() {
      /// update userName
      handler.userName = _controller1.text;
    });
    _controller2.setListener(() {
      /// update password
      handler.password = _controller2.text;
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return Future.value(true);
      },
      child: Material(
        child: Scaffold(
          appBar: AppBar(
            title: Text(
              'Login',
              style: TextStyle(color: mainTextTitleColor),
            ),
            backgroundColor: Colors.white,
            centerTitle: true,
            leading: FButton(
              image: Icon(Icons.arrow_back_ios, color: mainTextTitleColor),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
          body: Container(
            padding: EdgeInsets.only(left: 50, right: 50),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  "Login",
                  style: TextStyle(
                      color: mainTextTitleColor,
                      fontSize: 50,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 50),
                FSearch(
                  controller: _controller1,
                  width: double.infinity,
                  height: 50,
                  hints: ["User Name", ""],
                  padding: EdgeInsets.only(left: 8.0, right: 8.0),
                  strokeColor: mainTextTitleColor,
                  corner: FSearchCorner.all(6.0),
                  shadowColor: mainShadowColor,
                  shadowBlur: 5.0,
                  backgroundColor: Colors.white,
                ),
                const SizedBox(height: 30),
                FSearch(
                  controller: _controller2,
                  width: double.infinity,
                  height: 50,
                  hints: ["Password", ""],
                  padding: EdgeInsets.only(left: 8.0, right: 8.0),
                  strokeColor: mainTextTitleColor,
                  corner: FSearchCorner.all(6.0),
                  shadowColor: mainShadowColor,
                  shadowBlur: 5.0,
                  backgroundColor: Colors.white,
                ),
                const SizedBox(height: 15),
                Text(
                  "Forgot your password?",
                  style: TextStyle(fontSize: 11, color: Colors.blueAccent),
                ),
                const SizedBox(height: 25),
                Stateful(
                  initState: (setState, data) {
                    /// register login receiver
                    FBroadcast.instance().register(
                      Key_Login,

                      /// refresh ui
                      (value) => setState(() {}),
                      more: {
                        /// register user receiver
                        Key_User: (value) {
                          FLoading.hide();
                          Navigator.pop(context);
                        },
                      },

                      /// bind context
                      context: data,
                    );
                  },
                  builder: (context, setState, data) {
                    return FButton(
                      width: double.infinity,
                      height: 50,
                      color: Colors.pink,
                      corner: FCorner.all(25),
                      clickEffect: true,
                      shadowBlur: 10.0,
                      shadowColor: Colors.pink[300].withOpacity(0.8),
                      text: "LOGIN",
                      style: TextStyle(color: Colors.white, fontSize: 18),
                      disableStyle: TextStyle(
                          color: Colors.white.withOpacity(0.7), fontSize: 18),
                      alignment: Alignment.center,
                      highlightColor: Colors.pink,
                      disabledColor: Colors.pink.withOpacity(0.1),

                      /// Key_Login value=true is allowed to click login
                      onPressed: !(FBroadcast.value(Key_Login) ?? false)
                          ? null
                          : () {
                              _controller1.clearFocus();
                              _controller2.clearFocus();
                              FLoading.show(context);
                              handler.login();
                            },
                    );
                  },
                ),
                const SizedBox(height: 25),
                FSuper(
                  textAlignment: Alignment.center,
                  text: "Don't have account?",
                  style: TextStyle(color: mainTextSubColor, fontSize: 11),
                  spans: [
                    TextSpan(
                        text: " Sign up", style: TextStyle(color: Colors.pink))
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
