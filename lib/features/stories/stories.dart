import 'package:flutter/material.dart';
import './stories_view.dart';

class Stories extends StatefulWidget {
  static const route = '/Stories/';
  const Stories({super.key});

  @override
  StoriesView createState() => StoriesView();
}
