import 'package:flutter/material.dart';

String appFont = 'HelveticaNeuea';

class AppIcon {
  static const int fabTweet = 0xf029;
  static const int messageEmpty = 0xf187;
  static const int messageFill = 0xf554;
  static const int search = 0xf058;
  static const int searchFill = 0xf558;
  static const int notification = 0xf055;
  static const int notificationFill = 0xf019;
  static const int messageFab = 0xf053;
  static const int home = 0xf053;
  static const int homeFill = 0xF553;
  static const int heartEmpty = 0xf148;
  static const int heartFill = 0xf015;
  static const int settings = 0xf059;
  static const int adTheRate = 0xf064;
  static const int reply = 0xf151;
  static const int retweet = 0xf152;
  static const int image = 0xf109;
  static const int camera = 0xf110;
  static const int arrowDown = 0xf196;
  static const int blueTick = 0xf099;

  static const int link = 0xf098;
  static const int unFollow = 0xf097;
  static const int mute = 0xf101;
  static const int viewHidden = 0xf156;
  static const int block = 0xe609;
  static const int report = 0xf038;
  static const int pin = 0xf088;
  static const int delete = 0xf154;

  static const int profile = 0xf056;
  static const int lists = 0xf094;
  static const int bookmark = 0xf155;
  static const int moments = 0xf160;
  static const int twitterAds = 0xf504;
  static const int bulb = 0xf567;
  static const int newMessage = 0xf035;

  static const int sadFace = 0xf430;
  static const int bulbOn = 0xf066;
  static const int bulbOff = 0xf567;
  static const int follow = 0xf175;
  static const int thumbpinFill = 0xf003;
  static const int calender = 0xf203;
  static const int locationPin = 0xf031;
  static const int edit = 0xf112;
}

const kTextColor = Color(0xFFffc300);
const kTextLightColor = Color(0xFFffd60a);
const baseColor = Color.fromRGBO(255, 255, 255, 1);
const secondBaseColor = Color.fromRGBO(25, 18, 37, 1);
const thirdBaseColor = Color.fromRGBO(253, 129, 46, 1);
const fourthBaseColor = Color.fromRGBO(255, 255, 255, 1);
const gradientYellowColor = Color.fromRGBO(247, 99, 0, 1);
const gradientOrangeColor = Color.fromRGBO(255, 253, 46, 1);
const navbarBaseColor = Color.fromRGBO(46, 101, 176, 1);
const kDefaultPaddin = 20.0;

/// Firestore collections
/// Store `User` Model in db
const String usersCollection = "users";

/// Store `Contacts` Model in db
const String constCollection = "const";

/// Store `FeedModel` Model in db
const String postsCollection = "posts";

/// Store `FeedModel` Model in db
const String risksCollection = "risks";

/// Store `CommentModel` Model in db
const String commentsCollection = "comments";

/// Store `NotificationModel` Model in db
const String notificationsCollection = "notifications";
