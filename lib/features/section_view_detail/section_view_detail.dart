import 'package:flutter/material.dart';
import '../../core/index.dart';
import './section_view_detail_view.dart';

class SectionViewDetail extends StatefulWidget {
  static const route = '/SectionViewDetail/';
  final CnnMenuModel model;
  const SectionViewDetail({super.key, required this.model});

  @override
  SectionViewDetailView createState() => SectionViewDetailView();
}
