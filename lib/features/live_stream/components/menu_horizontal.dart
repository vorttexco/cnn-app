import 'package:cnn_brasil_app/core/providers/theme_provider.dart';
import 'package:cnn_brasil_app/features/live_stream/models/menu_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/index.dart';

class LiveMenuHorizontal extends StatefulWidget {
  final List<MenuModel> items;
  final Color? backgroundColor;
  final Color? textColor;
  final int selectedIndex;
  final Function(MenuModel menu, int index)? onSelectedMenu;
  final bool showBottomLine;
  const LiveMenuHorizontal({
    super.key,
    required this.items,
    required this.selectedIndex,
    this.onSelectedMenu,
    this.backgroundColor,
    this.textColor,
    this.showBottomLine = true,
  });

  @override
  State<LiveMenuHorizontal> createState() => _LiveMenuHorizontalState();
}

class _LiveMenuHorizontalState extends State<LiveMenuHorizontal> {
  // int selectedIndex = 0;

  onSelectedItem(MenuModel item, int index) {
    widget.onSelectedMenu?.call(item, index);
  }

  bool get _isDark =>
      Provider.of<ThemeProvider>(context).themeMode == ThemeMode.dark ||
      (Provider.of<ThemeProvider>(context).themeMode == ThemeMode.system &&
          MediaQuery.of(context).platformBrightness == Brightness.dark);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.secondaryContainer,
      ),
      height: 35,
      child: ListView.separated(
        padding: const EdgeInsets.only(
            left: AppConstants.KPADDING_16, right: AppConstants.KPADDING_16),
        scrollDirection: Axis.horizontal,
        itemCount: widget.items.length,
        itemBuilder: (context, index) {
          final menu = widget.items[index];
          return InkWell(
            onTap: () => onSelectedItem(menu, index),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                color: widget.selectedIndex == index
                    ? (_isDark
                        ? Theme.of(context).colorScheme.primary
                        : Theme.of(context).primaryColor)
                    : Colors.transparent,
                border: widget.selectedIndex == index
                    ? null
                    : Border.all(
                        width: 1,
                        color: Theme.of(context).colorScheme.primary,
                      ),
              ),
              child: Center(
                child: CustomText(
                  menu.title,
                  textColor: widget.selectedIndex == index
                      ? Theme.of(context).colorScheme.secondaryContainer
                      : Theme.of(context).colorScheme.tertiary,
                  fontWeight: FontWeight.w700,
                  fontSize: AppConstants.KFONTSIZE_12,
                ),
              ),
            ),
          );
        },
        separatorBuilder: (BuildContext context, int index) => const SizedBox(
          width: 14,
        ),
      ),
    );
  }
}
