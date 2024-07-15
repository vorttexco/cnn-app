import 'package:cnn_brasil_app/features/live_stream/models/menu_model.dart';
import 'package:flutter/material.dart';

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
    this.backgroundColor = Colors.white,
    this.textColor = Colors.black,
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

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Color(0xFF282828),
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
                      ? Colors.white
                      : Colors.transparent,
                  border: Border.all(width: 1, color: const Color(0xFF515151))),
              child: Center(
                child: CustomText(
                  menu.title,
                  textColor: widget.selectedIndex == index
                      ? Colors.black
                      : Colors.white,
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
