import 'package:flutter/material.dart';
import './profile_view.dart';

class Profile extends StatefulWidget {
  static const route = '/Profile/';
  final Function()? onClose;
  const Profile({super.key, this.onClose});

  @override
  ProfileView createState() => ProfileView();
}
