import 'package:flutter/material.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:register_user/controller.dart';
import 'package:register_user/Pages/login_page.dart';

// ignore: must_be_immutable
class UserPage extends StatelessWidget {
  ParseUser currentUser;
  
   Future<ParseUser> getUser() async {
    currentUser = await ParseUser.currentUser() as ParseUser;
    return currentUser;
  }

  @override
  Widget build(BuildContext context) {
    void doUserLogout() async {
      var response = await currentUser.logout();
      if (response.success) {
        Message.showSuccess(
            context: context,
            message: 'Usuario Saiu Com Sucesso!',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => LoginPage())
              );
            });
      } else {
        Message.showError(context: context, message: response.error.message);
      }
    }

    return Scaffold(
        appBar: AppBar(
          title: Text('User logged in - Current User'),
        ),
        body: FutureBuilder<ParseUser>(
            future: getUser(),
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.none:
                case ConnectionState.waiting:
                  return Center(
                    child: Container(
                        width: 100,
                        height: 100,
                        child: CircularProgressIndicator()),
                  );
                default:
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Center(
                            child: Text('Hello, ${snapshot.data.username}')),
                        SizedBox(
                          height: 16,
                        ),
                        Container(
                          height: 50,
                          child: ElevatedButton(
                            child: const Text('Logout'),
                            onPressed: () => doUserLogout(),
                          ),
                        ),
                      ],
                    ),
                  );
              }
            }));
  }
}