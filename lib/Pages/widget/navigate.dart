import 'package:flutter/material.dart';
import 'package:register_user/Pages/user_page.dart';

navigate(context) {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => UserPage()),
      (Route<dynamic> route) => false,
    );
  }