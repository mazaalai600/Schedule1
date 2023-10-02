import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:schedule/screens/chat_screen.dart';
import 'package:schedule/screens/homescreen.dart';

import '../methods/auth_state.dart';
import '../helper/helper_constant.dart';

import 'custom_navbar.dart';

class BottomNavBar extends StatefulWidget {
  final int screenIndex;
  static const route = '/bottomBar';
  const BottomNavBar({Key? key, required this.screenIndex}) : super(key: key);

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  late int currentIndex = 1;
  late BottomNavigationDotBar navBar;
  @override
  void initState() {
    currentIndex = widget.screenIndex;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      //Todo: Shalgah heseg
    });
    navBar = BottomNavigationDotBar(
      color: Colors.grey,
      activeColor: gradientYellowColor,
      items: <BottomNavigationDotBarItem>[
        // BottomNavigationDotBarItem(
        //   icon: NavbarIcon.home,
        //   onTap: () {
        //     setState(() {
        //       currentIndex = 0;
        //     });
        //   },
        // ),
        BottomNavigationDotBarItem(
            icon: const ImageIcon(
              AssetImage('assets/Home.png'),
              color: gradientYellowColor,
            ),
            onTap: () {
              setState(() {
                currentIndex = 1;
              });
            }),
        BottomNavigationDotBarItem(
            icon: const ImageIcon(
              AssetImage('assets/person.png'),
              color: gradientYellowColor,
            ),
            // icon: Image.asset('assets/person.png'),
            // icon: (Icons.feed),
            onTap: () {
              setState(() {
                currentIndex = 2;
              });
            }),
        BottomNavigationDotBarItem(
            icon: const ImageIcon(
              AssetImage('assets/plus_icon.png'),
              color: gradientYellowColor,
              // size: 150,
            ),
            onTap: () {
              setState(() {
                currentIndex = 3;
              });
            }),
      ],
      key: UniqueKey(),
    );
    super.initState();
  }

  Widget callPage(int current) {
    var authState = Provider.of<AuthState>(context, listen: false);
    switch (current) {
      // case 0:
      //   return new ChatList();
      //   break;
      case 1:
        return HomeScreen();
      case 2:
        if (authState.userModel.role == 'Admin') {
          return const ChatPage();
        } else {
          return const ChatPage();
        }
      //return const MyFeedBack();
      case 3:
        if (authState.userModel.role == 'Admin') {
          return const ChatPage();
        } else {
          return const ChatPage();
        }
      case 4:
        if (authState.userModel.role == 'Admin') {
          return const ChatPage();
        } else {
          return const ChatPage();
        }
      default:
        return HomeScreen();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: secondBaseColor,
      body: callPage(currentIndex),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      // floatingActionButton: FloatingActionButton(
      //   child: Icon(Icons.add),
      //   backgroundColor: Colors.orange,
      //   onPressed: () {
      //     setState(() {
      //       currentIndex = 3;
      //     });
      //   },
      // ),
      bottomNavigationBar: navBar,
    );
  }
}
