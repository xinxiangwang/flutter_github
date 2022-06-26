import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled/common/GmLocalizations.dart';
import 'package:untitled/common/global.dart';

import '../common/Git.dart';
import '../models/user.dart';

class LoginRoute extends StatefulWidget {
  const LoginRoute({Key? key}) : super(key: key);

  @override
  State<LoginRoute> createState() => _LoginRouteState();
}

class _LoginRouteState extends State<LoginRoute> {
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _pwdController = TextEditingController();
  bool pwdShow = false;
  GlobalKey _formKey = GlobalKey<FormState>();
  bool _nameAutoFocus = true;
  @override
  void initState() {
    _usernameController.text = Global.profile.lastLogin ?? '';
    if (_usernameController.text.isNotEmpty) {
      _nameAutoFocus = false;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var gm = GmLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(gm!.login),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            children: [
              TextFormField(
                autofocus: _nameAutoFocus,
                controller: _usernameController,
                decoration: InputDecoration(
                  labelText: '请输入账号2',
                  hintText: '请输入账号1',
                  prefixIcon: Icon(Icons.person),
                ),
                validator: (v) {
                  return v == null || v.trim().isNotEmpty ? null : '用户名必填';
                },
              ),
              TextFormField(
                controller: _pwdController,
                autofocus: !_nameAutoFocus,
                decoration: InputDecoration(
                  labelText: '请输入密码',
                  hintText: '请输入密码1',
                  prefixIcon: Icon(Icons.lock),
                  suffixIcon: IconButton(
                    icon:
                        Icon(pwdShow ? Icons.visibility_off : Icons.visibility),
                    onPressed: () {
                      setState(() {
                        pwdShow = !pwdShow;
                      });
                    },
                  ),
                ),
                obscureText: !pwdShow,
                validator: (v) {
                  return v == null || v.trim().isNotEmpty ? null : '用户名必填';
                },
              ),
              Padding(
                padding: const EdgeInsets.only(top: 25),
                child: ConstrainedBox(
                  constraints: BoxConstraints.expand(height: 55),
                  child: ElevatedButton(
                    onPressed: _onLogin,
                    child: Text(gm.login),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _onLogin() async {
    if ((_formKey.currentState as FormState).validate()) {
      // showLoading(context);
      User? user;
      try {
        user = await Git(context)
            .login(_usernameController.text, _pwdController.text);
        print(user.toJson());
        Provider.of<UserModel>(context, listen: false).user = user;
      } on DioError catch (e) {
        print(e);
        if (e.response?.statusCode == 401) {

        }
      }
      if (user != null) {
        Navigator.of(context).pop();
      }
    }
  }
}
