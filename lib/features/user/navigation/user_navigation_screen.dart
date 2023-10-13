import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:swag_marine_products/constants/sizes.dart';
import 'package:swag_marine_products/features/user/navigation/menus/user_bookmark_screen.dart';
import 'package:swag_marine_products/features/user/navigation/menus/user_community_screem.dart';
import 'package:swag_marine_products/features/user/navigation/menus/user_price_screen.dart';
import 'package:swag_marine_products/features/user/navigation/menus/user_profile_screen.dart';
import 'package:swag_marine_products/features/user/navigation/widgets/nav_tab.dart';
import 'package:swag_marine_products/features/user/navigation/menus/user_store_screen.dart';

class UserNavigationScreenArgs {
  UserNavigationScreenArgs({required this.selectedIndex});

  final int selectedIndex;
}

class UserNavigationScreen extends StatefulWidget {
  static const routeName = "navigation";
  static const routeURL = "/navigation";
  const UserNavigationScreen({
    super.key,
    required this.selectedIndex,
  });

  final int selectedIndex;

  @override
  State<UserNavigationScreen> createState() => _UserNavigationScreenState();
}

class _UserNavigationScreenState extends State<UserNavigationScreen> {
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

    // 페이지 진입 시 상태 표시줄 색상 설정
    // SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    //   statusBarColor: Colors.blue, // 원하는 색상으로 변경
    //   statusBarIconBrightness: Brightness.light, // 아이콘 밝기 설정
    //   statusBarBrightness: Brightness.light, // 상태 표시줄 밝기 설정
    // ));

    selectedIndex = widget.selectedIndex;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
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
              child: const UserBookMarkScreen(),
            ),
            Offstage(
              offstage: selectedIndex != 2,
              child: const UserCommunityScreen(),
            ),
            Offstage(
              offstage: selectedIndex != 3,
              //child: const SearchVolScreen(),
              child: const UserProfileScreen(),
            ),
          ],
        ),
        bottomNavigationBar: Container(
          decoration: const BoxDecoration(
            // color: selectedIndex == 1
            //     ? const Color.fromARGB(255, 152, 197, 255)
            //     : null,
            // image: selectedIndex == 1
            //     ? const DecorationImage(
            //         image: AssetImage(
            //           'assets/images/sand3.png',
            //         ), // 모래사장 이미지 경로
            //         fit: BoxFit.fill,
            //         repeat: ImageRepeat.repeat, // 이미지 반복 설정
            //       )
            //     : null,
            image: DecorationImage(
              image: AssetImage(
                'assets/images/sand3.png',
              ), // 모래사장 이미지 경로
              fit: BoxFit.fill,
              repeat: ImageRepeat.repeat, // 이미지 반복 설정
            ),
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
                  text: "찜목록",
                  isSelected: selectedIndex == 1,
                  unSelectedIcon: FontAwesomeIcons.heart,
                  selectedIcon: FontAwesomeIcons.solidHeart,
                  onTap: () => _onTap(1),
                  selectedIndex: selectedIndex,
                ),
                NavTab(
                  text: "커뮤니티",
                  isSelected: selectedIndex == 2,
                  unSelectedIcon: FontAwesomeIcons.comment,
                  selectedIcon: FontAwesomeIcons.solidComment,
                  onTap: () => _onTap(2),
                  selectedIndex: selectedIndex,
                ),
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
      ),
    );
  }
}
