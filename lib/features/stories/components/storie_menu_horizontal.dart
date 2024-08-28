import 'package:cnn_brasil_app/core/models/wrapper_stories.dart';
import 'package:flutter/material.dart';

import '../../../core/index.dart';

class StorieMenuHorizontal extends StatefulWidget {
  final List<StorieViewModel> items;
  final Color? backgroundColor;
  final Color? textColor;
  final Function(StorieViewModel menu)? onSelectedMenu;
  final bool showBottomLine;
  const StorieMenuHorizontal({
    super.key,
    required this.items,
    this.onSelectedMenu,
    this.backgroundColor = Colors.white,
    this.textColor = Colors.black,
    this.showBottomLine = true,
  });

  @override
  State<StorieMenuHorizontal> createState() => _StorieMenuHorizontalState();
}

class _StorieMenuHorizontalState extends State<StorieMenuHorizontal> {
  int selectedIIndex = 0;

  onSelectedItem(StorieViewModel item, int index) {
    setState(() {
      selectedIIndex = index;
    });
    widget.onSelectedMenu?.call(item);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: widget.backgroundColor,
        border: Border(
          bottom: BorderSide(
            width: 1,
            color: widget.showBottomLine
                ? const Color(0xFFDCDCDC)
                : Colors.transparent,
          ),
        ),
      ),
      height: 50,
      child: ListView.separated(
        padding: const EdgeInsets.only(
            left: AppConstants.KPADDING_16, right: AppConstants.KPADDING_16),
        scrollDirection: Axis.horizontal,
        itemCount: widget.items.length,
        itemBuilder: (context, index) {
          final menu = widget.items[index];
          return Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              InkWell(
                onTap: () => onSelectedItem(menu, index),
                child: Container(
                  decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(
                    width: 3,
                    color: selectedIIndex == index
                        ? menu.color
                        : Colors.transparent,
                  ))),
                  child: Padding(
                    padding:
                        const EdgeInsets.only(bottom: 12, left: 1, right: 1),
                    child: CustomText(
                      menu.category,
                      fontWeight: FontWeight.w700,
                      textColor: widget.textColor,
                    ),
                  ),
                ),
              ),
            ],
          );
        },
        separatorBuilder: (BuildContext context, int index) => const SizedBox(
          width: 28,
        ),
      ),
    );
  }
}
