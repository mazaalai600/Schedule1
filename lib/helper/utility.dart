List<String> getHashTags(String text) {
  RegExp reg = RegExp(
      r"([#])\w+|(https?|ftp|file|#)://[-A-Za-z0-9+&@#/%?=~_|!:,.;]+[-A-Za-z0-9+&@#/%=~_|]*");
  Iterable<Match> matches = reg.allMatches(text);
  List<String> resultMatches = <String>[];
  for (Match match in matches) {
    if (match.group(0)!.isNotEmpty) {
      var tag = match.group(0);
      resultMatches.add(tag!);
    }
  }
  return resultMatches;
}

String getUserName({required String name, required String id}) {
  String userName = '';
  name = name.split(' ')[0];
  id = id.substring(0, 4);
  userName = '@$name$id'; //
  // return userName;
  return userName.toLowerCase();
}

bool validateEmal(String email) {
  String p =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

  RegExp regExp = RegExp(p);

  var status = regExp.hasMatch(email);
  return status;
}
