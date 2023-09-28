import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:swag_marine_products/constants/sizes.dart';
import 'package:swag_marine_products/screens/menus/marine_graph_screen.dart';
import 'package:swag_marine_products/screens/menus/marine_price_screen.dart';
import 'package:swag_marine_products/screens/main_navigation/widgets/nav_tab.dart';

class NavigationScreen extends StatefulWidget {
  static const routeName = "main";
  static const routeURL = "/main";
  const NavigationScreen({super.key});

  @override
  State<NavigationScreen> createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen> {
  int selectedIndex = 0;

  void _onTap(int index) {
    if (selectedIndex == index) return;
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    print("width : ${size.width}");
    print("height : ${size.height}");
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          // 실제로 그 화면을 보고 있지 않더라도 랜더링 시켜주는 위젯
          Offstage(
            offstage: selectedIndex != 0,
            child: const MarinePriceScreen(),
          ),
          Offstage(
            offstage: selectedIndex != 1,
            //child: const SearchVolScreen(),
            child: const MarineGraphScreen(),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          // color: Colors.grey.shade50,
          color: selectedIndex == 0
              ? const Color.fromARGB(255, 152, 197, 255)
              : null,
          image: selectedIndex == 0
              ? const DecorationImage(
                  image: AssetImage(
                    'assets/images/sand3.png',
                  ), // 모래사장 이미지 경로
                  fit: BoxFit.fill,
                  repeat: ImageRepeat.repeat, // 이미지 반복 설정
                )
              : null,
        ),
        child: Padding(
          padding: const EdgeInsets.all(Sizes.size12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              NavTab(
                text: "가격",
                isSelected: selectedIndex == 0,
                unSelectedIcon: FontAwesomeIcons.bars,
                selectedIcon: FontAwesomeIcons.bars,
                onTap: () => _onTap(0),
                selectedIndex: selectedIndex,
              ),
              NavTab(
                text: "통계",
                isSelected: selectedIndex == 1,
                unSelectedIcon: FontAwesomeIcons.chartLine,
                selectedIcon: FontAwesomeIcons.chartLine,
                onTap: () => _onTap(1),
                selectedIndex: selectedIndex,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
