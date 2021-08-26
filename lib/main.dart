import 'package:flutter/material.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:register_user/Pages/myapp_page.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final keyApplicationId = 'Vqw2ceDx6vXA8zUzkuuPQtIB3zN6Gb0P84PiSIzv';
  final keyClientKey = 'no3WkRjwATbwQ4PBY6oJqshX695kzBS3mQ6rlT83';
  final keyParseServerUrl = 'https://parseapi.back4app.com/';

  await Parse().initialize(keyApplicationId, keyParseServerUrl,
      clientKey: keyClientKey, debug: true);

  runApp(MyApp());
}
