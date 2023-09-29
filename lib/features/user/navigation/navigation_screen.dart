import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:swag_marine_products/constants/sizes.dart';
import 'package:swag_marine_products/features/user/navigation/menus/user_graph_screen.dart';
import 'package:swag_marine_products/features/user/navigation/menus/user_price_screen.dart';
import 'package:swag_marine_products/features/user/navigation/menus/user_profile_screen.dart';
import 'package:swag_marine_products/features/user/navigation/widgets/nav_tab.dart';
import 'package:swag_marine_products/features/user/navigation/menus/user_store_screen.dart';

class NavigationScreenArgs {
  NavigationScreenArgs({required this.selectedIndex});

  final int selectedIndex;
}

class NavigationScreen extends StatefulWidget {
  static const routeName = "navigation";
  static const routeURL = "navigation";
  const NavigationScreen({
    super.key,
    required this.selectedIndex,
  });

  final int selectedIndex;

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
  void initState() {
    super.initState();

    selectedIndex = widget.selectedIndex;
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
            child: const UserStoreScreen(),
          ),
          Offstage(
            offstage: selectedIndex != 1,
            child: const UserPriceScreen(),
          ),
          // Offstage(
          //   offstage: selectedIndex != 2,
          //   //child: const SearchVolScreen(),
          //   child: const UserGraphScreen(),
          // ),
          Offstage(
            offstage: selectedIndex != 3,
            //child: const SearchVolScreen(),
            child: const UserProfileScreen(),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          // color: Colors.grey.shade50,
          color: selectedIndex == 1
              ? const Color.fromARGB(255, 152, 197, 255)
              : null,
          image: selectedIndex == 1
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
                text: "가게",
                isSelected: selectedIndex == 0,
                unSelectedIcon: FontAwesomeIcons.store,
                selectedIcon: FontAwesomeIcons.store,
                onTap: () => _onTap(0),
                selectedIndex: selectedIndex,
              ),
              NavTab(
                text: "도매가격",
                isSelected: selectedIndex == 1,
                unSelectedIcon: FontAwesomeIcons.dollarSign,
                selectedIcon: FontAwesomeIcons.dollarSign,
                onTap: () => _onTap(1),
                selectedIndex: selectedIndex,
              ),
              // NavTab(
              //   text: "통계",
              //   isSelected: selectedIndex == 2,
              //   unSelectedIcon: FontAwesomeIcons.chartLine,
              //   selectedIcon: FontAwesomeIcons.chartLine,
              //   onTap: () => _onTap(2),
              //   selectedIndex: selectedIndex,
              // ),
              NavTab(
                text: "프로필",
                isSelected: selectedIndex == 3,
                unSelectedIcon: FontAwesomeIcons.circleUser,
                selectedIcon: FontAwesomeIcons.solidCircleUser,
                onTap: () => _onTap(3),
                selectedIndex: selectedIndex,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
