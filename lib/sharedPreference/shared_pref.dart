import 'package:shared_preferences/shared_preferences.dart';

class SharedPref {
  static const String isLoggedIn = 'is-LoggedIn';

  loggIn() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setBool(isLoggedIn, true);
  }

  loggOut() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setBool(isLoggedIn, false);
  }

  Future<bool> getloggInStatus() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    bool? status = pref.getBool(isLoggedIn);
    if (status == null) {
      return false;
    } else {
      return status;
    }
  }
}
