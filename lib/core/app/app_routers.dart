import 'package:cnn_brasil_app/core/index.dart';
import 'package:cnn_brasil_app/features/section_view_detail/section_view_detail.dart';
import 'package:cnn_brasil_app/features/submenu/submenu.dart';
import 'package:flutter/material.dart';

import '../../../features/blogs/blogs.dart';
import '../../../features/custom_webview/custom_webview.dart';
import '../../../features/home/home.dart';
import '../../../features/live_stream/live_stream.dart';
import '../../../features/search/search.dart';
import '../../../features/splash/splash.dart';
import '../../../features/stories/stories.dart';
import '../../../features/tab_navigator/tab_navigator.dart';

class AppRouters {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => const Splash());
      case TabNavigator.route:
        return MaterialPageRoute(builder: (_) => const TabNavigator());
      case Home.route:
        return MaterialPageRoute(builder: (_) => const Home());
      case LiveStream.route:
        return MaterialPageRoute(builder: (_) => const LiveStream());
      case Blogs.route:
        return MaterialPageRoute(builder: (_) => const Blogs());
      case Stories.route:
        return MaterialPageRoute(builder: (_) => const Stories());
      case Search.route:
        return MaterialPageRoute(builder: (_) => const Search());
      case SectionViewDetail.route:
        return MaterialPageRoute(
            builder: (_) => SectionViewDetail(
                  model: settings.arguments as CnnMenuModel,
                ));
      case Submenu.route:
        return MaterialPageRoute(
            builder: (_) => Submenu(
                  model: settings.arguments as CnnMenuModel,
                ));

      case CustomWebView.route:
        return MaterialPageRoute(
            builder: (_) => CustomWebView(
                  navigatorModel: settings.arguments as WebviewNavigatorModel,
                ));
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }
}
