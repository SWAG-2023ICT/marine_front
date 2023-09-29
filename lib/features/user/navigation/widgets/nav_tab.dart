import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:swag_marine_products/constants/gaps.dart';

class NavTab extends StatelessWidget {
  const NavTab({
    Key? key,
    required this.text,
    required this.isSelected,
    required this.unSelectedIcon,
    required this.selectedIcon,
    required this.onTap,
    required this.selectedIndex,
  }) : super(key: key);

  final String text;
  final bool isSelected;
  final IconData unSelectedIcon;
  final IconData selectedIcon;
  final Function onTap;
  final int selectedIndex;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: () => onTap(),
        behavior: HitTestBehavior.opaque,
        child: AnimatedOpacity(
          duration: const Duration(milliseconds: 300),
          opacity: isSelected ? 1 : 0.4,
          // Column은 세로축으로 최대한 확장 하려고 한다.
          child: Column(
            // 사이즈 조절
            mainAxisSize: MainAxisSize.min,
            children: [
              FaIcon(
                isSelected ? selectedIcon : unSelectedIcon,
                size: 28,
              ),
              Gaps.v5,
              Text(
                text,
                style: const TextStyle(
                  fontSize: 13,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
