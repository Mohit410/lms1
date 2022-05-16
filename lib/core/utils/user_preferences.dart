import 'package:lms1/injection_container.dart';
import 'package:shared_preferences/shared_preferences.dart';

const USER_NAME_KEY = 'USER_NAME_KEY';
const USER_EMAIL_KEY = 'USER_EMAIL_KEY';
const USER_ROLE_KEY = 'USER_ROLE_KEY';
const USER_TOKEN_KEY = 'USER_TOKEN_KEY';

class UserPreferences {
  static SharedPreferences? _preferences;

  static Future init() async => _preferences = sl<SharedPreferences>();

  static Future setUserName(String name) async =>
      await _preferences?.setString(USER_NAME_KEY, name);

  static Future setUserRole(String role) async =>
      await _preferences?.setString(USER_ROLE_KEY, role);

  static Future setUserEmail(String email) async =>
      await _preferences?.setString(USER_EMAIL_KEY, email);

  static Future setUserToken(String token) async =>
      await _preferences?.setString(USER_TOKEN_KEY, token);

  static String? getUserName() => _preferences?.getString(USER_NAME_KEY);

  static String? getUserEmail() => _preferences?.getString(USER_EMAIL_KEY);

  static String? getUserToken() => _preferences?.getString(USER_TOKEN_KEY);

  static String? getUserRole() => _preferences?.getString(USER_ROLE_KEY);

  static Future clearPreferences() async => await _preferences?.clear();

  static bool isAdmin() => UserPreferences.getUserRole() == 'admin';
}
