import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:schedule/methods/components.dart' as customComponents;
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';

import '../../methods/auth_state.dart';
import '../../methods/firebase_auth.dart';
import '../../methods/select_auth_methods.dart';

class LoginScreen extends StatefulWidget {
  static const route = '/login';
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late FirebaseAuthentication auth;
  bool loggedIn = false;
  // bool _isSignUp = true;

  // late String name;
  String selectedValue = '';
  bool _isLogin = true;

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isObscure = true;
  bool busy = false;

  void initState() {
    Firebase.initializeApp().whenComplete(() {
      auth = FirebaseAuthentication();
      busy = false;
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        Center(
          child: ListView(
            shrinkWrap: true,
            children: [
              Form(
                key: _formKey,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(top: 14),
                        child: Text(
                          'Нэвтрэх хэсэг',
                          style: TextStyle(
                            color: Color.fromARGB(255, 121, 43, 180),
                            fontWeight: FontWeight.w700,
                            fontFamily: 'Poppins',
                            fontSize: 20,
                          ),
                        ),
                      ),
                      customComponents.buildInput(
                        textEditingController: _emailController,
                        text: 'Email',
                        prefixIcon: const Icon(Icons.email_outlined),
                        topPadding: 15,
                        leftPadding: 30,
                        rigthPadding: 30,
                        keyboardType: TextInputType.emailAddress,
                        validator: (val) {
                          if (val!.isEmpty) {
                            return "Талбар хоосон байна.";
                          } else if (!RegExp(
                                  r'^(([^<>()\[\]\\.,;:\s@"]+(\.[^<>()\[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
                              .hasMatch(val)) {
                            return "Зөв имэйл оруулна уу.";
                          }
                          return null;
                        },
                      ),
                      customComponents.buildInput(
                        textEditingController: _passwordController,
                        text: 'Password',
                        prefixIcon: const Icon(Icons.password),
                        topPadding: 15,
                        leftPadding: 30,
                        rigthPadding: 30,
                        keyboardType: TextInputType.emailAddress,
                        validator: (val) {
                          if (val!.isEmpty) {
                            return "Талбар хоосон байна.";
                          } else if (!RegExp(r'^(?=.*?[a-z]).{8,}$')
                              .hasMatch(val)) {
                            return "8 тэмдэгт";
                          }
                          return null;
                        },
                      ),
                      customComponents.buildLoginButton(
                        text: 'Нэвтрэх',
                        icon: Icons.login,
                        OnPressed: () async {
                          final FormState? form = _formKey.currentState;
                          if (form!.validate()) {
                            EasyLoading.show(status: 'Та түр хүлээнэ үү...');
                            if (_isLogin) {
                              if (!busy) {
                                var authState = Provider.of<AuthState>(context,
                                    listen: false);
                                var result = await authState.signIn(
                                    email: _emailController.text.trim(),
                                    password: _passwordController.text.trim());

                                if (result == 'signed') {
                                  if (!mounted) return;
                                  EasyLoading.dismiss();

                                  Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                        builder: (_) =>
                                            const SelectAuthMethod()),
                                    (route) => false,
                                  );

                                  busy = false;
                                }
                              }
                            }
                          }
                        },
                      ),
                      customComponents.buildLoginButton(
                          text: 'Бүртгүүлэх',
                          icon: Icons.supervisor_account,
                          OnPressed: () {
                            Navigator.of(context).pushNamed('/register');
                          }),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ]),
    );
  }

  Widget buildPass({
    required TextEditingController textEditingController,
    String? text,
    double? topPadding,
    double? leftPadding,
    double? rigthPadding,
    double? bottomPadding,
    TextInputType? keyboardType,
    String? Function(String?)? validator,
    bool enabled = true,
  }) {
    return Padding(
      padding: EdgeInsets.only(
          top: topPadding ?? 0,
          left: leftPadding ?? 0,
          right: rigthPadding ?? 0,
          bottom: bottomPadding ?? 0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
        ),
        child: TextFormField(
          controller: textEditingController,
          keyboardType: keyboardType ?? TextInputType.text,
          decoration: InputDecoration(
            suffixIcon: IconButton(
              onPressed: (() {
                setState(() {
                  _isObscure = !_isObscure;
                });
              }),
              icon: Icon(_isObscure ? Icons.visibility : Icons.visibility_off),
            ),
            prefixIcon: const Icon(Icons.lock_outline_rounded),
            border: InputBorder.none,
            hintText: text,
            hintStyle: const TextStyle(
              color: Color.fromRGBO(173, 164, 165, 1),
              fontSize: 12,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w400,
            ),
          ),
          validator: validator,
          obscureText: _isObscure,
          enabled: enabled,
        ),
      ),
    );
  }
}
