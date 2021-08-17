import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

class LoginController {
  Future<bool> doUserLogin(String username, String password) async {
    final user = ParseUser(username, password, null);

    var response = await user.login();
    return response.success;
  }

  Future<bool> doUserLogout() async {
    final user = await ParseUser.currentUser() as ParseUser;
    // ignore: unused_local_variable
    var response = await user.logout();
    return response.success;
  }
  Future<bool>doUserRegistration(String username, String email, String password) async {
  
    final user = ParseUser.createUser(username, password, email);

    var response = await user.signUp();
    return response.success;
  }
}
