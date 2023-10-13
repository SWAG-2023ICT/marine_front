import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:swag_marine_products/features/user/address/user_address_list.dart';
import 'package:swag_marine_products/features/user/navigation/menus/widgets/profile_button.dart';
import 'package:swag_marine_products/features/user/order/user_order_check_screen.dart';
import 'package:swag_marine_products/features/user/profile/user_inform_screen.dart';
import 'package:swag_marine_products/features/user/navigation/menus/widgets/user_profile_card.dart';

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({super.key});

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        surfaceTintColor: Colors.white,
        title: const Text("내정보"),
        actions: [
          IconButton(
            onPressed: () {
              context.pushNamed(UserInformScreen.routeName);
            },
            icon: const Icon(
              Icons.settings,
              size: 30,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const UserProfileCard(),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 30,
                vertical: 10,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ProfileButton(
                    onPressed: () {
                      context.pushNamed(UserOrderCheckScreen.routeName);
                    },
                    icon: Icons.playlist_play_rounded,
                    text: "주문 내역",
                    color: Colors.grey,
                  ),
                  // ProfileButton(
                  //   icon: Icons.description_outlined,
                  //   text: "주문 내역",
                  //   color: Colors.grey,
                  // ),
                  // ProfileButton(
                  //   icon: Icons.data_exploration_outlined,
                  //   text: "가격 통계",
                  //   color: Colors.grey,
                  // ),
                ],
              ),
            ),
            const UserAddressList(),
          ],
        ),
      ),
    );
  }
}
