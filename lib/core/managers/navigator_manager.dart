import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../index.dart';

class NavigatorManager {
  final BuildContext context;

  NavigatorManager(this.context);

  void to(String route,
      {dynamic data,
      Function? onFinished,
      fullscreen = false,
      bool rootNavigator = true}) {
    Navigator.of(context, rootNavigator: rootNavigator)
        .pushNamed(
      route,
      arguments: data,
    )
        .then((value) {
      onFinished?.call();
    });
  }

  void modal(Widget widget,
      {dynamic data, Function? onFinished, fullscreenDialog = false}) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
        fullscreenDialog: fullscreenDialog,
        settings: RouteSettings(arguments: data),
      ),
    ).then((value) {
      onFinished?.call();
    });
  }

  void replacement(String route,
          {dynamic data,
          VoidCallback? onFinished,
          bool rootNavigator = true}) =>
      Navigator.of(context, rootNavigator: rootNavigator)
          .pushReplacementNamed(route, arguments: data)
          .then((value) {
        onFinished?.call();
      });

  Future<void> fullModal(Widget child,
      {Widget? header, VoidCallback? onFinished}) {
    Provider.of<FullscreenProvider>(context, listen: false).setFullScreen(true);
    return showModalBottomSheet<void>(
      context: context,
      enableDrag: false,
      constraints: const BoxConstraints(maxHeight: double.infinity),
      scrollControlDisabledMaxHeightRatio: 1,
      builder: (context) => Material(
        child: Column(
          children: [
            header ??
                Container(
                  width: double.infinity,
                  height: 110,
                  color: Colors.white,
                  child: Align(
                      alignment: Alignment.bottomLeft,
                      child: IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: const Icon(Icons.close),
                      )),
                ),
            Expanded(child: child),
          ],
        ),
      ),
    ).then((_) {
      Provider.of<FullscreenProvider>(context, listen: false)
          .setFullScreen(false);
      onFinished?.call();
    });
  }

  void modalVideo(Widget child) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.black.withOpacity(0.7),
      isScrollControlled: true,
      builder: (context) => Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => Navigator.pop(context),
          child: child,
        ),
      ),
    );
  }

  void back() => Navigator.of(context).pop();
}
