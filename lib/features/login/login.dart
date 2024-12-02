import 'package:flutter/material.dart';
import 'login_view.dart';

class Login extends StatefulWidget {
  static const route = '/Login/';
  final Function()? onClose;
  const Login({super.key, this.onClose});

  @override
  LoginView createState() => LoginView();
}
