import 'package:flutter/material.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:register_user/Pages/registration_page.dart';
import 'package:register_user/Pages/user_page.dart';
import 'package:register_user/controller.dart';
import 'package:register_user/Pages/reset_password_page.dart';

class Login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Login/Logout',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      );  }
}

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final controllerUsername = TextEditingController();
  final controllerPassword = TextEditingController();
  bool isLoggedIn = false;
  var controller = LoginController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Login/Logout'),
          centerTitle: true,
        ),
        body: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Center(
                  child: const Text('Flutter on Back4App',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                ),
                SizedBox(
                  height: 16,
                ),
                Center(
                  child: const Text('Login/Logout',
                      style: TextStyle(fontSize: 16)),
                ),
                SizedBox(
                  height: 16,
                ),
                TextField(
                  controller: controllerUsername,
                  enabled: !isLoggedIn,
                  keyboardType: TextInputType.text,
                  textCapitalization: TextCapitalization.none,
                  autocorrect: false,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black)),
                      labelText: 'Username'),
                ),
                SizedBox(
                  height: 8,
                ),
                TextField(
                  controller: controllerPassword,
                  enabled: !isLoggedIn,
                  obscureText: true,
                  keyboardType: TextInputType.text,
                  textCapitalization: TextCapitalization.none,
                  autocorrect: false,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black)),
                      labelText: 'Password'),
                ),
                SizedBox(
                  height: 16,
                ),
                Container(
                  color: Colors.blue,
                  height: 50,
                  child: ElevatedButton(
                      child: const Text('Entrar',
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.w400),),
                      onPressed: () async {
                        bool isSuccess = await controller.doUserLogin(
                            controllerUsername.text.trim(),
                            controllerPassword.text.trim());
                        if (isSuccess) {
                          setState(() {
                            isLoggedIn = true;
                          });
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => UserPage()));
                        } else {
                          showError("Não Foi Possivel fazer Seu Login!", context);
                        }
                      }),
                ),
                SizedBox(
                  height: 16,
                ),
                Container(
                  color: Colors.blue,
                  height: 50,
                  child: ElevatedButton(
                    child: const Text('Cadastrar',
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.w400),),
                    onPressed: () => navigateToSignUp(),
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                Container(
                  color: Colors.blue,
                  height: 50,
                  child: ElevatedButton(
                    child: const Text('Reset PassWord',
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.w400),),
                    onPressed: () => navigateToResetPassword(),
                  ),
                ),
                ],
            ),
          ),
        ));
  }
  void doUserLogin() async {
    final username = controllerUsername.text.trim();
    final password = controllerPassword.text.trim();

    final user = ParseUser(username, password, null);

    var response = await user.login();

    if (response.success) {
      navigateToUser();
    } else {
      Message.showError(context: context, message: response.error.message);
    }
  }

  void navigateToUser() {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => UserPage()),
      (Route<dynamic> route) => false,
    );
  }

  void navigateToSignUp() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SignUp()),
    );
  }

  void navigateToResetPassword() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ResetPasswordPage()),
    );
  }
}

  showError(String errorMessage, BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Error!"),
          content: Text(errorMessage),
          actions: <Widget>[
            new TextButton(
              child: const Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }