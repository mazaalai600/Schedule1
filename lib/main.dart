import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:schedule/methods/auth_state.dart';
import 'package:schedule/errors/no_internet.dart';
import 'package:schedule/methods/select_auth_methods.dart';
import 'package:schedule/screens/chat_screen.dart';
import 'package:schedule/screens/homescreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:schedule/screens/login_screns/login_screen.dart';
import 'package:schedule/screens/login_screns/register_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const SceduleApp());
}

class SceduleApp extends StatelessWidget {
  const SceduleApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const NoInternetCon();
        }
        return MultiProvider(
          providers: [
            ChangeNotifierProvider<AuthState>(create: (_) => AuthState()),
          ],
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            home: const SelectAuthMethod(),
            builder: EasyLoading.init(),
            routes: {
              HomeScreen.route: (context) => const HomeScreen(),
              SelectAuthMethod.route: (context) => const SelectAuthMethod(),
              ChatPage.route: (context) => const ChatPage(),
              LoginScreen.route: (context) => const LoginScreen(),
              RegisterScreen.route: (context) => const RegisterScreen()
            },
          ),
        );
      },
    );
  }
}
