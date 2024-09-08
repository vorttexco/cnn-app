import 'package:cnn_brasil_app/core/index.dart';
import 'package:flutter/material.dart';

class MenuHorizontal extends StatelessWidget {
  final List<CnnMenuModel> items;
  final Color? backgroundColor;
  final Color? textColor;
  final Function(CnnMenuModel menu)? onSelectedMenu;
  final bool showBottomLine;
  final CnnMenuModel? selectedMenu;
  final ScrollController? scrollController;
  const MenuHorizontal({
    super.key,
    required this.items,
    this.onSelectedMenu,
    this.backgroundColor,
    this.textColor,
    this.showBottomLine = true,
    this.selectedMenu,
    this.scrollController,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: backgroundColor,
        border: Border(
          bottom: BorderSide(
            width: 1,
            color:
                showBottomLine ? const Color(0xFFDCDCDC) : Colors.transparent,
          ),
        ),
      ),
      height: 50,
      child: ListView.separated(
        controller: scrollController,
        padding: const EdgeInsets.only(
            left: AppConstants.KPADDING_16, right: AppConstants.KPADDING_16),
        scrollDirection: Axis.horizontal,
        itemCount: items.length,
        itemBuilder: (context, index) {
          final menu = items[index];
          return Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              InkWell(
                onTap: () => onSelectedMenu?.call(menu),
                child: Container(
                  decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(
                    width: 3,
                    color: selectedMenu?.id == menu.id
                        ? HexColor.fromHex(menu.color?.hex ?? 'CC0000')
                        : Colors.transparent,
                  ))),
                  child: Padding(
                    padding:
                        const EdgeInsets.only(bottom: 12, left: 1, right: 1),
                    child: CustomText(
                      menu.title ?? '',
                      fontWeight: FontWeight.w700,
                      textColor: textColor,
                    ),
                  ),
                ),
              ),

              //     : const SizedBox.shrink()
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
