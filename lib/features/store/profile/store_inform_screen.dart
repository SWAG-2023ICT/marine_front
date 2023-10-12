import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:swag_marine_products/constants/sizes.dart';
import 'package:swag_marine_products/features/store/profile/store_user_inform_inquiry_screen.dart';
import 'package:swag_marine_products/features/user/home/user_home_screen.dart';
import 'package:swag_marine_products/features/sign_in_up/sign_in_screen.dart';
import 'package:swag_marine_products/features/user/profile/user_inform_inquiry_screen.dart';
import 'package:swag_marine_products/providers/store_provider.dart';
import 'package:swag_marine_products/storages/login_storage.dart';

class StoreInformScreen extends StatelessWidget {
  static const routeName = "store_inform";
  static const routeURL = "store_inform";
  const StoreInformScreen({super.key});

  // 로그아웃
  void onLogoutTap(BuildContext context) async {
    LoginStorage.resetLoginData();
    context.pop();
    context.replaceNamed(SignInScreen.routeName);
    await context.read<StoreProvider>().logout();
  }

  // 계정 삭제
  void _onDeleteTap(BuildContext context) async {
    LoginStorage.resetLoginData();
    context.pop();
    context.replaceNamed(SignInScreen.routeName);
    await context.read<StoreProvider>().logout();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("설정"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 26),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _title(title: "회원 정보"),
            Card(
              elevation: 0,
              child: ListTile(
                onTap: () {
                  // _userInquiryTap;
                  context.pushNamed(
                    StoreUserInformInquiryScreen.routeName,
                  );
                },
                title: const Text(
                  "회원 정보 조회",
                  style: TextStyle(
                    fontWeight: FontWeight.normal,
                    fontSize: 15.0,
                  ),
                ),
                trailing: const Icon(
                  Icons.chevron_right_rounded,
                  size: Sizes.size24,
                ),
              ),
            ),
            _title(title: "서비스"),
            Card(
              elevation: 0,
              child: ListTile(
                onTap: () => Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => const LicensePage(),
                  ),
                ),
                title: const Text(
                  "앱 정보(라이센스)",
                  style: TextStyle(
                    fontWeight: FontWeight.normal,
                    fontSize: 15.0,
                  ),
                ),
                trailing: const Icon(
                  Icons.chevron_right_rounded,
                  size: Sizes.size24,
                ),
              ),
            ),
            const Card(
              elevation: 0,
              child: ListTile(
                title: Text(
                  "이용 약관",
                  style: TextStyle(
                    fontWeight: FontWeight.normal,
                    fontSize: 15.0,
                  ),
                ),
                trailing: Icon(
                  Icons.chevron_right_rounded,
                  size: Sizes.size24,
                ),
              ),
            ),
            Card(
              elevation: 0,
              child: ListTile(
                onTap: () {
                  // context.pushNamed(
                  //   NoticeScreen.routeName,
                  // );
                },
                title: const Text(
                  "공지사항",
                  style: TextStyle(
                    fontWeight: FontWeight.normal,
                    fontSize: 15.0,
                  ),
                ),
                trailing: const Icon(
                  Icons.chevron_right_rounded,
                  size: Sizes.size24,
                ),
              ),
            ),
            _title(title: "계정 관리"),
            Card(
              elevation: 0,
              child: ListTile(
                onTap: () => onLogoutTap(context),
                title: const Text(
                  "로그아웃",
                  style: TextStyle(
                    fontWeight: FontWeight.normal,
                    fontSize: 15.0,
                  ),
                ),
                trailing: const Icon(
                  Icons.chevron_right_rounded,
                  size: Sizes.size24,
                ),
              ),
            ),
            Card(
              elevation: 0,
              child: ListTile(
                onTap: () => _onDeleteTap(context),
                title: const Text(
                  "회원 탈퇴",
                  style: TextStyle(
                    fontWeight: FontWeight.normal,
                    fontSize: 15.0,
                  ),
                ),
                trailing: const Icon(
                  Icons.chevron_right_rounded,
                  size: Sizes.size24,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _title({required String title}) {
    return Text(
      title,
      style: const TextStyle(
        color: Color.fromARGB(255, 152, 152, 152),
        fontSize: 15,
        fontWeight: FontWeight.w700,
        height: 3,
      ),
    );
  }
}
