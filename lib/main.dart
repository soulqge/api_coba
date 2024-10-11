
import 'package:flutter/material.dart';
import 'package:login_logout_tutor/pages/login.dart';
import 'package:login_logout_tutor/pages/register.dart';

void main() => runApp(MaterialApp(
  debugShowCheckedModeBanner: false,
  initialRoute: '/login',
  routes: {
    '/login': (context) => LoginPage(),
    '/register': (context) => RegisterPage(),
  },
));




