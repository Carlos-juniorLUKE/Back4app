import 'package:flutter/material.dart';
import 'package:register_user/Pages/registration.dart';
import 'package:register_user/Pages/welcome_page.dart';
import 'package:register_user/controller.dart';

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
      home: LoginPage(),
    );
  }
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
                  height: 50,
                  child: TextButton(
                      child: const Text('Entrar'),
                      onPressed: () async {
                        bool isSuccess = await controller.doUserLogin(
                            controllerUsername.text.trim(),
                            controllerPassword.text.trim());
                        if (isSuccess) {
                          showSuccess("Usuario Entrou Com Sucesso!");
                          setState(() {
                            isLoggedIn = true;
                          });
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => WelcomePage()));
                        } else {
                          showError("Não Foi Possivel fazer Seu Login!");
                        }
                      }),
                ),
                SizedBox(
                  height: 16,
                ),
                Container(
                  height: 50,
                  child: TextButton(
                    child: const Text('Sair'),
                    onPressed: !isLoggedIn
                        ? null
                        : () async {
                            bool isSuccess = await controller.doUserLogout();
                            if (isSuccess) {
                              showSuccess("Usuario Saiu Com Sucesso!");
                              setState(() {
                                isLoggedIn = false;
                              });
                            } else {
                              showError("Tente Novamente!");
                            }
                          },
                  ),
                ),
                Container(
                  height: 50,
                  child: TextButton(
                      child: const Text('Não Possui Usuario? | Cadastre-se!'),
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => SingUp()));
                      }),
                ),
              ],
            ),
          ),
        ));
  }

  void showSuccess(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Sucesso!"),
          content: Text(message),
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

  void showError(String errorMessage) {
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
}