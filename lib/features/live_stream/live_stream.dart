import 'package:flutter/material.dart';
import './live_stream_view.dart';

class LiveStream extends StatefulWidget {
  static const route = '/LiveStream/';
  const LiveStream({super.key});

  @override
  LiveStreamView createState() => LiveStreamView();
}
