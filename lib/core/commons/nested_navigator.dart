import 'package:flutter/material.dart';

import '../../features/index.dart';
import '../index.dart';

final nestedNavigatorKey = GlobalKey<NavigatorState>();

class NestedNavigator extends StatelessWidget {
  const NestedNavigator({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: nestedNavigatorKey,
      onGenerateRoute: BottomSheetRoutes.generateRoute,
      onGenerateInitialRoutes: (navigator, initialRoute) => [
        MaterialPageRoute(builder: (context) => child),
      ],
    );
  }
}

class BottomSheetRoutes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case SectionViewDetail.route:
        return MaterialPageRoute(
            builder: (_) => SectionViewDetail(
                  model: settings.arguments as CnnMenuModel,
                ));
      case HomeMenu.route:
        return MaterialPageRoute(builder: (_) => const HomeMenu());
      case Submenu.route:
        return MaterialPageRoute(
            builder: (_) => Submenu(
                  model: settings.arguments as CnnMenuModel,
                ));

      case CustomWebView.route:
        return MaterialPageRoute(
          builder: (_) => CustomWebView(
            navigatorModel: settings.arguments as WebviewNavigatorModel,
          ),
        );
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
