import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
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
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
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
        body: Column(
          children: [
            const UserProfileCard(),
            GridView(
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: 1 / 1,
                crossAxisSpacing: 6,
                mainAxisSpacing: 6,
              ),
              children: [
                Container(
                  child: const Text("주문 내역"),
                ),
                Container(
                  child: const Text("주문 목록"),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
