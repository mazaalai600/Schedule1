import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:schedule/methods/components.dart' as customComponents;
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';

import '../../methods/auth_state.dart';
import '../../methods/firebase_auth.dart';
import '../../methods/select_auth_methods.dart';

class RegisterScreen extends StatefulWidget {
  static const route = '/register';
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  late FirebaseAuthentication auth;
  bool loggedIn = false;
  // bool _isSignUp = true;

  late String userId;
  late String name;
  String selectedValue = '';

  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();

  final _phoneNumberController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isObscure = true;
  var options = [
    'Student',
    'teacher',
  ];
  var _currentItemSelected = "Student";
  var role = "Student";

  void initState() {
    Firebase.initializeApp().whenComplete(() {
      auth = FirebaseAuthentication();
      setState(() {});
    });
    super.initState();
  }

  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
            onPressed: () {
              Navigator.pushNamed(context, "/login");
            },
            icon: Icon(
              Icons.arrow_back,
              color: Colors.black,
            )),
      ),
      body: Stack(children: [
        ListView(
          shrinkWrap: true,
          children: [
            Form(
              key: _formKey,
              // child: Padding(
              //   padding: const EdgeInsets.only(top: 31, left: 17, right: 17),
              //   child: Container(
              //     width: double.infinity,
              //     decoration: BoxDecoration(
              //       borderRadius: customComponents.customCircularRadius(22),
              //       gradient: customComponents.customGradient(),
              //     ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(top: 14),
                      child: Text(
                        'Бүртгүүлэх хэсэг',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                          fontFamily: 'Poppins',
                          fontSize: 20,
                        ),
                      ),
                    ),
                    customComponents.buildInput(
                      textEditingController: _lastNameController,
                      text: 'Овог',
                      prefixIcon: const Icon(Icons.person_outline),
                      topPadding: 15,
                      leftPadding: 30,
                      rigthPadding: 30,
                      validator: (val) {
                        if (val!.isEmpty) {
                          return "Талбар хоосон байна.";
                        } else if (val.length > 20) {
                          return "Нэр урт байна.";
                        }
                        return null;
                      },
                    ),
                    customComponents.buildInput(
                      textEditingController: _firstNameController,
                      text: 'Нэр',
                      prefixIcon: const Icon(Icons.person_outline),
                      topPadding: 15,
                      leftPadding: 30,
                      rigthPadding: 30,
                      validator: (val) {
                        if (val!.isEmpty) {
                          return "Талбар хоосон байна.";
                        } else if (val.length > 20) {
                          return "Нэр урт байна.";
                        }
                        return null;
                      },
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
                      textEditingController: _phoneNumberController,
                      text: 'Phone',
                      prefixIcon: const Icon(Icons.phone),
                      topPadding: 15,
                      leftPadding: 30,
                      rigthPadding: 30,
                      keyboardType: TextInputType.emailAddress,
                      validator: (val) {
                        if (val!.isEmpty) {
                          return "Талбар хоосон байна.";
                        } else if (!RegExp(r'^(?=.*?[0-9]).{8,}$')
                            .hasMatch(val)) {
                          return "8 тоо байх";
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Role : ",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        DropdownButton<String>(
                          dropdownColor: Color.fromRGBO(0, 172, 237, 1.0),
                          isDense: true,
                          isExpanded: false,
                          iconEnabledColor: Colors.black,
                          focusColor: Colors.black,
                          items: options.map((String dropDownStringItem) {
                            return DropdownMenuItem<String>(
                              value: dropDownStringItem,
                              child: Text(
                                dropDownStringItem,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                              ),
                            );
                          }).toList(),
                          onChanged: (newValueSelected) {
                            setState(() {
                              _currentItemSelected = newValueSelected!;
                              role = newValueSelected;
                            });
                          },
                          value: _currentItemSelected,
                        ),
                      ],
                    ),
                    customComponents.buildCustomButton(
                      backgroundColor: Color.fromARGB(175, 106, 75, 199),
                      textColor: Colors.white,
                      border_radius: 99,
                      text: 'Бүртгүүлэх',
                      topPadding: 28,
                      leftPadding: 30,
                      rigthPadding: 35,
                      bottomPadding: 25,
                      OnPressed: () async {
                        final FormState? form = _formKey.currentState;
                        if (form!.validate()) {
                          EasyLoading.show(status: 'Та түр хүлээнэ үү...');
                          var authState =
                              Provider.of<AuthState>(context, listen: false);
                          authState
                              .signUp(
                            email: _emailController.text,
                            password: _passwordController.text,
                            phone: _phoneNumberController.text,
                            fname: _firstNameController.text,
                            lname: _lastNameController.text,
                            role: _currentItemSelected,
                          )
                              .then((err) async {
                            if (err == 'signedUp') {
                              await Future.delayed(const Duration(seconds: 1));

                              if (!mounted) return;
                              EasyLoading.dismiss();
                              Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => const SelectAuthMethod()),
                                (route) => false,
                              );
                            } else {
                              EasyLoading.dismiss();
                              showDialog(
                                context: context,
                                builder: (BuildContext context) => AlertDialog(
                                  title: const Text("Алдаа"),
                                  content: Text(err),
                                  actions: [
                                    TextButton(
                                      child: const Text("OK"),
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                    ),
                                  ],
                                ),
                              );
                            }
                          });
                        }
                      },
                    )
                  ],
                  // ),
                  // ),
                ),
              ),
            ),
          ],
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
