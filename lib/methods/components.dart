// ignore_for_file: non_constant_identifier_names

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

//Color
const kBackgroundColor = Color(0xff191720);

Widget buildInput({
  required TextEditingController textEditingController,
  String? text,
  String? iconName,
  double? topPadding,
  double? leftPadding,
  double? rigthPadding,
  double? bottomPadding,
  TextInputType? keyboardType,
  String? Function(String?)? validator,
  bool? isPassword = false,
  bool enabled = true,
  Widget? prefixIcon,
  Widget? suffixIcon,
}) {
  return Padding(
    padding: EdgeInsets.only(
        top: topPadding ?? 0,
        left: leftPadding ?? 0,
        right: rigthPadding ?? 0,
        bottom: bottomPadding ?? 0),
    child: Container(
      decoration: BoxDecoration(
        color: Color.fromARGB(176, 123, 75, 199),
        borderRadius: BorderRadius.circular(14),
      ),
      child: TextFormField(
        controller: textEditingController,
        keyboardType: keyboardType ?? TextInputType.text,
        decoration: InputDecoration(
          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon,
          border: InputBorder.none,
          hintText: text,
          hintStyle: const TextStyle(
            color: Colors.white,
            fontSize: 17,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w400,
          ),
        ),
        validator: validator,
        obscureText: isPassword!,
        enableSuggestions: !isPassword,
        autocorrect: !isPassword,
        enabled: enabled,
      ),
    ),
  );
}

Widget buildLoginButton(
    {String? text, IconData? icon, void Function()? OnPressed}) {
  return Padding(
    padding: const EdgeInsets.only(top: 26, left: 50, right: 49),
    child: Container(
      height: 60,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(
          Radius.circular(99),
        ),
        gradient: customGradient(),
      ),
      child: InkWell(
        onTap: OnPressed ?? () {},
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                color: Colors.white,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 22),
                child: Text(
                  text ?? '',
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w700),
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

LinearGradient customGradient() {
  return const LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: [
      Color.fromRGBO(160, 104, 225, 1),
      Color.fromRGBO(90, 26, 108, 1),
    ],
  );
}

BorderRadius customCircularRadius(double radius) {
  return const BorderRadius.all(Radius.circular(18));
}

Widget buildCustomButton({
  double? buttonHeight,
  double? buttonWidth,
  Color? backgroundColor,
  Color? textColor,
  double? border_radius,
  String? text,
  double? topPadding,
  double? leftPadding,
  double? rigthPadding,
  double? bottomPadding,
  TextStyle? textStyle,
  void Function()? OnPressed,
}) {
  return Padding(
    padding: EdgeInsets.only(
        top: topPadding ?? 0,
        left: leftPadding ?? 0,
        right: rigthPadding ?? 0,
        bottom: bottomPadding ?? 0),
    child: Container(
      width: buttonWidth ?? double.infinity,
      height: buttonHeight ?? 60,
      decoration: BoxDecoration(
        color: backgroundColor ?? Color.fromARGB(176, 123, 75, 199),
        borderRadius: customCircularRadius(border_radius ?? 0),
      ),
      child: InkWell(
        onTap: OnPressed ?? () {},
        child: Center(
            child: Text(
          text ?? '',
          style: textStyle ??
              TextStyle(
                  color: textColor ?? Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  fontFamily: 'Poppins'),
        )),
      ),
    ),
  );
}

Widget buildTopBackButton(BuildContext context) {
  return Container(
    width: double.infinity,
    height: 41,
    decoration: const BoxDecoration(
      color: Colors.white,
      boxShadow: [
        BoxShadow(
          offset: Offset(0.0, 0.75),
          color: Colors.black,
          blurRadius: 4,
          spreadRadius: 2,
        ),
      ],
      borderRadius: BorderRadius.all(
        Radius.circular(23),
      ),
    ),
    child: InkWell(
      onTap: () {
        Navigator.pushNamed(context, "/login");
      },
      child: const Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 35, right: 44),
              child: Icon(
                Icons.arrow_back_ios_new_rounded,
                size: 20,
              ),
            ),
            Text(
              'Өмнөх цэс рүү буцах',
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  fontFamily: 'Poppins'),
            )
          ],
        ),
      ),
    ),
  );
}

Flexible space({int? flexSize}) {
  return Flexible(
    flex: flexSize ?? 1,
    child: Container(),
  );
}

void buildAlert({
  required String title,
  required String message,
  String? imageName,
  required BuildContext context,
}) {
  final platform = Theme.of(context).platform;
  imageName = imageName ?? "assets/error_modal.png";
  if (platform == TargetPlatform.iOS) {
    showCupertinoDialog(
        context: context,
        builder: (context) {
          return _IOSAlertDialog(title, message, imageName!, context);
        });
  } else {
    showDialog(
      context: context,
      builder: (context) {
        return _androidAlertDialog(title, message, imageName!, context);
      },
    );
  }
}

AlertDialog _androidAlertDialog(
    String title, String message, String imageName, BuildContext context) {
  return AlertDialog(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(18),
        ),
      ),
      contentPadding: const EdgeInsets.all(0),
      content: alertDialogContent(title, message, imageName, context));
}

CupertinoAlertDialog _IOSAlertDialog(
    String title, String message, String imageName, BuildContext context) {
  return CupertinoAlertDialog(
      content: alertDialogContent(title, message, imageName, context));
}

Widget alertDialogContent(
    String title, String message, String imageName, BuildContext context) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisSize: MainAxisSize.min,
    children: [
      IconButton(
        iconSize: 30,
        onPressed: () => Navigator.of(context).pop(),
        icon: const Icon(
          Icons.close,
          color: Colors.black,
        ),
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          space(),
          Flexible(
            flex: 48,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Image.asset(
                    imageName,
                    width: 222,
                    height: 221,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 15),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      space(flexSize: 3),
                      Flexible(
                        flex: 14,
                        child: Text(
                          title,
                          style: const TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              fontFamily: 'Montserrat'),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      space(flexSize: 3),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 34),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      space(),
                      Flexible(
                        flex: 18,
                        child: Text(
                          message,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            fontFamily: 'Poppins',
                          ),
                        ),
                      ),
                      space(),
                    ],
                  ),
                ),
                buildCustomButton(
                  backgroundColor: const Color.fromRGBO(184, 68, 68, 1),
                  buttonHeight: 67,
                  OnPressed: () {
                    Navigator.of(context).pop();
                  },
                  text: 'Дахин оролдох',
                  textStyle: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.w500,
                  ),
                  topPadding: 34,
                  leftPadding: 25.76,
                  rigthPadding: 25.4,
                  bottomPadding: 66.71,
                  border_radius: 19,
                ),
              ],
            ),
          ),
          space(),
        ],
      ),
    ],
  );
}
