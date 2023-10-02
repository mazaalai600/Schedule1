import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class NoInternetCon extends StatefulWidget {
  const NoInternetCon({Key? key}) : super(key: key);

  @override
  State<NoInternetCon> createState() => _NoInternetConState();
}

class _NoInternetConState extends State<NoInternetCon> {
  @override
  Widget build(BuildContext context) {
    if (kDebugMode) {
      print('No Internet Screen');
    }
    return const MaterialApp(
        home: Scaffold(
      body: Center(
        child: Text('Уучлаарай та интернетээ шалгана уу.'),
      ),
    ));
  }
}
