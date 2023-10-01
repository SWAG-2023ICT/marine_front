import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:swag_marine_products/constants/sizes.dart';
import 'package:swag_marine_products/features/user/bookmark/user_bookmark_screen.dart';
import 'package:swag_marine_products/features/user/home/widgets/home_menu_button.dart';
import 'package:swag_marine_products/features/user/navigation/menus/widgets/radioactivity_banner.dart';
import 'package:swag_marine_products/features/user/navigation/navigation_screen.dart';
import 'package:swag_marine_products/features/user/profile/user_inform_screen.dart';
import 'package:swag_marine_products/storages/address_storage.dart';

class UserHomeScreen extends StatefulWidget {
  static const routeName = "home";
  static const routeURL = "/home";
  const UserHomeScreen({super.key});

  @override
  State<UserHomeScreen> createState() => _UserHomeScreenState();
}

class _UserHomeScreenState extends State<UserHomeScreen> {
  @override
  void initState() {
    super.initState();

    // AddressStorage.resetAddressList();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          body: Stack(
            children: [
              Column(
                children: [
                  Expanded(
                    flex: 9,
                    child: Opacity(
                      opacity: 0.6,
                      child: Image.asset(
                        "assets/images/sea4.png",
                        fit: BoxFit.cover,
                        width: MediaQuery.of(context).size.width,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Opacity(
                      opacity: 0.6,
                      child: Image.asset(
                        'assets/images/sand3.png', // 모래사장 이미지 경로
                        fit: BoxFit.fill,
                        repeat: ImageRepeat.repeat, // 이미지 반복 설정
                        width: MediaQuery.of(context).size.width,
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 4,
                        vertical: Sizes.size10,
                      ),
                      child: const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          RadioactivityBanner(),
                          // Container(
                          //   child: const Column(
                          //     children: [
                          //       Text(
                          //         "오늘의 최저 가격! Top5!",
                          //         style: TextStyle(
                          //           fontSize: 16,
                          //           fontWeight: FontWeight.bold,
                          //         ),
                          //       ),
                          //     ],
                          //   ),
                          // ),
                        ],
                      ),
                    ),
                    GridView(
                      shrinkWrap: true,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        // 한 줄당 몇개를 넣을건지 지정
                        crossAxisCount: 2,
                        // 좌우 간격
                        crossAxisSpacing: Sizes.size10,
                        // 위아래 간격
                        mainAxisSpacing: Sizes.size10,
                        // 한 블럭당 비율 지정 (가로 / 세로)
                        childAspectRatio: 1 / 1,
                      ),
                      children: [
                        HomeMenuButton(
                          icon: Icons.store_mall_directory_outlined,
                          color: Colors.blue,
                          backgroundColor: Colors.blue.shade50,
                          text: "가게",
                          onClick: () {
                            context.pushNamed(
                              NavigationScreen.routeName,
                              extra: NavigationScreenArgs(selectedIndex: 0),
                            );
                          },
                        ),
                        HomeMenuButton(
                          icon: Icons.price_check_outlined,
                          color: Colors.green,
                          backgroundColor: Colors.green.shade50,
                          text: "도매시장",
                          onClick: () {
                            context.pushNamed(
                              NavigationScreen.routeName,
                              extra: NavigationScreenArgs(selectedIndex: 1),
                            );
                          },
                        ),
                        // HomeMenuButton(
                        //   icon: Icons.bar_chart_outlined,
                        //   color: Colors.purple,
                        //   backgroundColor: Colors.purple.shade50,
                        //   text: "통계",
                        //   onClick: () {
                        //     context.pushNamed(
                        //       NavigationScreen.routeName,
                        //       extra: NavigationScreenArgs(selectedIndex: 2),
                        //     );
                        //   },
                        // ),
                        HomeMenuButton(
                          icon: Icons.account_circle_outlined,
                          color: Colors.brown,
                          backgroundColor: Colors.brown.shade50,
                          text: "내정보",
                          onClick: () {
                            context.pushNamed(
                              NavigationScreen.routeName,
                              extra: NavigationScreenArgs(selectedIndex: 3),
                            );
                          },
                        ),
                        // HomeMenuButton(
                        //   icon: Icons.bookmark,
                        //   color: Colors.yellow.shade800,
                        //   backgroundColor: Colors.yellow.shade50,
                        //   text: "즐겨찾기",
                        //   onClick: () {
                        //     context.pushNamed(
                        //       UserBookMarkScreen.routeName,
                        //     );
                        //   },
                        // ),
                        HomeMenuButton(
                          icon: Icons.settings_applications_outlined,
                          color: Colors.grey,
                          backgroundColor: Colors.grey.shade50,
                          text: "설정",
                          onClick: () {
                            context.pushNamed(UserInformScreen.routeName);
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
