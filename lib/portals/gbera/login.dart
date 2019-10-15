import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gbera/netos/common.dart';


class LoginPage extends StatefulWidget {
  const LoginPage({Key key, this.context}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final PageContext context;

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    final TextEditingController _usernameController = TextEditingController();
    final TextEditingController _passwordController = TextEditingController();

    return Scaffold(
//      resizeToAvoidBottomPadding: false,
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          children: <Widget>[
            const SizedBox(height: 80.0),
            Column(
              children: <Widget>[
//                Image.asset('packages/shrine_images/diamond.png'),
                const SizedBox(height: 16.0),
                Text(
                  '金证时代',
                  style: Theme.of(context).textTheme.headline,
                ),
              ],
            ),
            const SizedBox(height: 120.0),
            PrimaryColorOverride(
              color: Colors.red,
              child: TextField(
                controller: _usernameController,
                decoration: const InputDecoration(
                  labelText: '用户名',
                ),
              ),
            ),
            const SizedBox(height: 12.0),
            PrimaryColorOverride(
              color: Colors.red,
              child: TextField(
                controller: _passwordController,

                decoration: const InputDecoration(
                  labelText: '密码',
                ),
              ),
            ),
            Wrap(
              children: <Widget>[
                ButtonBar(
                  children: <Widget>[
                    FlatButton(
                      child: const Text('重置'),
                      shape: const BeveledRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(7.0)),
                      ),
                      onPressed: () {
                        _passwordController.text = '';
                        _usernameController.text = '';
                      },
                    ),
                    RaisedButton(
                      child: const Text('登录'),
                      elevation: 8.0,
                      shape: const BeveledRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(7.0)),
                      ),
                      onPressed: () {
                        //widget.context.forward("gbera://home2.page");
//                      Navigator.of(context).pushNamed('/error.page');
                        LoginAction loginAction = LoginAction(
                          context: widget.context,
                          user: _usernameController.text,
                          pwd: _passwordController.text,
                        ).login();
                      },
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class PrimaryColorOverride extends StatelessWidget {
  const PrimaryColorOverride({Key key, this.color, this.child})
      : super(key: key);

  final Color color;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Theme(
      child: child,
      data: Theme.of(context).copyWith(primaryColor: color),
    );
  }
}

class LoginAction {
  final String user;
  final String pwd;
  final PageContext context;

  const LoginAction({this.user, this.pwd, this.context});

  login() {
    int pos = user.lastIndexOf("@");
    var account = '';
    var appid = '';
    if (pos < 0) {
      account = user;
    } else {
      account = user.substring(0, pos);
      appid = user.substring(pos + 1, user.length);
    }
    if (appid == null || appid == '') {
      appid = 'gbera';
    }
    context.ports(
      'get http://47.105.165.186/uc/auth?appid=$appid http/1.1',
      restCommand: 'auth',
      parameters: {
        "accountName": account,
        "password": pwd,
      },
      onsucceed: ({dynamic rc, dynamic response}) {
        forwardOK(rc);
      },
      onerror: ({e, stack}) {
        forwardError(e);
      },
      onReceiveProgress: (i, j) {
        print('$i-$j');
      },
    );
  }

  void forwardOK(rc) {
    print('ok:${rc['dataText']}');
    context.forward("gbera://scaffold/withbottombar");
  }

  void forwardError(e) {
    print('error:${e.response.data}');
    context.forward(
      "gbera://error",
      arguments: {
        'error': e,
      },
    );
//    context.forward("gbera://error.page", arguments: {"error": '$e'});
  }
}
