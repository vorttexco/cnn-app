import 'package:flutter/material.dart';
import './storie_detail_view.dart';

class StorieDetail extends StatefulWidget {
  static const route = '/StorieDetail/';
  final String url;
  const StorieDetail({super.key, required this.url});

  @override
  StorieDetailView createState() => StorieDetailView();
}
