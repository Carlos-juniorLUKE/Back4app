import 'package:flutter/material.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:register_user/Pages/user_page.dart';
import 'package:register_user/controller.dart';
import 'package:register_user/Pages/login_page.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  var controller = LoginController();
  final controllerUsername = TextEditingController();
  final controllerPassword = TextEditingController();
  final controllerEmail = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Cadastrar'),
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
                  child: const Text('Cadastrar Usuário',
                      style: TextStyle(fontSize: 16)),
                ),
                SizedBox(
                  height: 16,
                ),
                TextField(
                  controller: controllerUsername,
                  keyboardType: TextInputType.text,
                  textCapitalization: TextCapitalization.none,
                  autocorrect: false,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black)),
                      labelText: 'Usuario'),
                ),
                SizedBox(
                  height: 8,
                ),
                TextField(
                  controller: controllerEmail,
                  keyboardType: TextInputType.emailAddress,
                  textCapitalization: TextCapitalization.none,
                  autocorrect: false,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black)),
                      labelText: 'E-mail'),
                ),
                SizedBox(
                  height: 8,
                ),
                TextField(
                  controller: controllerPassword,
                  obscureText: true,
                  keyboardType: TextInputType.text,
                  textCapitalization: TextCapitalization.none,
                  autocorrect: false,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black)),
                      labelText: 'Senha'),
                ),
                SizedBox(
                  height: 16,
                ),
               Container(
                  height: 50,
                  child: ElevatedButton(
                    child: const Text('Sign Up'),
                    onPressed: () => doUserRegistration(),
                  ),
               ),
                SizedBox(
                  height: 16,
                ),
                Container(
                  color: Colors.blue,
                  height: 50,
                  child: ElevatedButton(
                      child: const Text(
                        'Login',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => LoginPage()));
                      }),
                ),
              ],
            ),
          ),
        ));
  }

  void showSuccess() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Sucesso!"),
          content: const Text("Usuario criado com sucesso!"),
          actions: <Widget>[
            TextButton(
              child: const Text("OK"),
              onPressed: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => Login()));
              },
            ),
          ],
        );
      },
    );
  }

  void showError(String errorMessage) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Error!"),
          content: Text(errorMessage),
          actions: <Widget>[
            // ignore: deprecated_member_use
            FlatButton(
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

  doUserRegistration() async {
    final username = controllerUsername.text.trim();
    final email = controllerEmail.text.trim();
    final password = controllerPassword.text.trim();

    final user = ParseUser.createUser(username, password, email);

    var response = await user.signUp();

    if (response.success) {
      Message.showSuccess(
          context: context,
          message: 'User was successfully created!',
          onPressed: () async {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => UserPage()),
              (Route<dynamic> route) => false,
            );
          });
    } else {
      Message.showError(context: context, message: response.error.message);
    }
  }
}
