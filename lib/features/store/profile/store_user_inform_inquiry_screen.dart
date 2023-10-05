import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:swag_marine_products/constants/gaps.dart';
import 'package:swag_marine_products/constants/sizes.dart';
import 'package:swag_marine_products/features/user/profile/user_inform_update_screen.dart';

class StoreUserInformInquiryScreen extends StatefulWidget {
  static const routeName = "store_user_inquiry_screen";
  static const routeURL = "store_user_inquiry_screen";

  const StoreUserInformInquiryScreen({
    super.key,
  });

  @override
  State<StoreUserInformInquiryScreen> createState() =>
      _StoreUserInformInquiryScreenState();
}

class _StoreUserInformInquiryScreenState
    extends State<StoreUserInformInquiryScreen> {
  final String _address = "주소 1";

  @override
  Widget build(BuildContext context) {
    DateTime? birthday = DateTime.now();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "회원 정보",
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: Sizes.size24, vertical: Sizes.size8),
          child: Column(
            children: [
              TextFormField(
                initialValue: "dlwogus1027",
                readOnly: true,
                decoration: InputDecoration(
                  labelText: "아이디",
                  prefixIcon: Icon(
                    Icons.person_outline,
                    color: Colors.grey.shade600,
                  ),
                ),
              ),
              Gaps.v10,
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: TextFormField(
                      initialValue: "Wogus@2356",
                      readOnly: true,
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: "비밀번호",
                        prefixIcon: Icon(
                          Icons.lock_person_outlined,
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      context.pushNamed(
                        UserInformUpdateScreen.routeName,
                        extra: const UserInformUpdateScreenArgs(
                          updateType: UpdateType.pw,
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.all(24),
                      textStyle: const TextStyle(fontSize: 14),
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                    ),
                    child: const Text("수정"),
                  ),
                ],
              ),
              Gaps.v10,
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: TextFormField(
                      initialValue: "이재현",
                      readOnly: true,
                      decoration: InputDecoration(
                        labelText: "이름(실명)",
                        prefixIcon: Icon(
                          Icons.badge_outlined,
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      context.pushNamed(
                        UserInformUpdateScreen.routeName,
                        extra: const UserInformUpdateScreenArgs(
                          updateType: UpdateType.name,
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.all(24),
                      textStyle: const TextStyle(fontSize: 14),
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                    ),
                    child: const Text("수정"),
                  ),
                ],
              ),
              Gaps.v10,
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: TextFormField(
                      initialValue: "01049049193",
                      readOnly: true,
                      decoration: InputDecoration(
                        labelText: "전화번호",
                        prefixIcon: Icon(
                          Icons.phone_iphone_rounded,
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      context.pushNamed(
                        UserInformUpdateScreen.routeName,
                        extra: const UserInformUpdateScreenArgs(
                          updateType: UpdateType.phoneNumber,
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.all(24),
                      textStyle: const TextStyle(fontSize: 14),
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                    ),
                    child: const Text("수정"),
                  ),
                ],
              ),
              // Gaps.v10,
              // const UserAddressList(),
            ],
          ),
        ),
      ),
    );
  }
}

class UserDataBox extends StatelessWidget {
  const UserDataBox({
    super.key,
    required this.data,
    required this.name,
    this.hint,
  });

  final String name;
  final String data;
  final String? hint;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: Sizes.size5),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Text(
              name,
              style: Theme.of(context).textTheme.titleSmall,
            ),
          ),
          Gaps.h10,
          Expanded(
            flex: 4,
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 14,
                vertical: 14,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  width: 1,
                  color: const Color(0xFFDBDBDB),
                ),
              ),
              child: Text(
                data.trim().isEmpty ? hint ?? "" : data,
                style: data.trim().isEmpty
                    ? Theme.of(context).textTheme.labelLarge
                    : Theme.of(context).textTheme.bodyMedium,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
