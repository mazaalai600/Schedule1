import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'auth_state.dart';
import '../errors/no_internet.dart';
import '../navbar/navbarcallpage.dart';
import '../screens/login_screns/login_screen.dart';

class SelectAuthMethod extends StatefulWidget {
  static const route = '/select_auth';
  const SelectAuthMethod({Key? key}) : super(key: key);

  @override
  State<SelectAuthMethod> createState() => _SelectAuthMethodState();
}

class _SelectAuthMethodState extends State<SelectAuthMethod> {
  @override
  Widget build(BuildContext context) {
    var authState = Provider.of<AuthState>(context);
    return FutureBuilder(
      future: authState.getCurrentUser(context: context),
      builder: (context, snapshot) {
        // Check for errors
        if (snapshot.hasError) {
          return const NoInternetCon();
        }
        if (authState.authStatus == AuthStatus.notDetermined ||
            authState.authStatus == AuthStatus.notLoggedIn) {
          return const LoginScreen();
        } else {
          return const BottomNavBar(
            screenIndex: 1,
          );
        }
      },
    );
  }
}
