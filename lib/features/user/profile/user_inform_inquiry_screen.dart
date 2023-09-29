import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:swag_marine_products/constants/gaps.dart';
import 'package:swag_marine_products/constants/sizes.dart';
import 'package:swag_marine_products/features/sign_in_up/widgets/centered_divider.dart';
import 'package:swag_marine_products/features/user/profile/user_inform_update_screen.dart';

class UserInformInquiryScreen extends StatefulWidget {
  static const routeName = "user_inquiry_screen";
  static const routeURL = "user_inquiry_screen";

  const UserInformInquiryScreen({
    super.key,
  });

  @override
  State<UserInformInquiryScreen> createState() =>
      _UserInformInquiryScreenState();
}

class _UserInformInquiryScreenState extends State<UserInformInquiryScreen> {
  String _address = "주소 1";

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
              Gaps.v10,
              const CenteredDivider(text: "주소 리스트"),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.all(10),
                      textStyle: const TextStyle(fontSize: 14),
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                    ),
                    child: const Text("추가"),
                  ),
                  Gaps.h10,
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.all(10),
                      textStyle: const TextStyle(fontSize: 14),
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                    ),
                    child: const Text("적용"),
                  ),
                ],
              ),
              ListView.separated(
                padding: const EdgeInsets.symmetric(vertical: 10),
                physics: const NeverScrollableScrollPhysics(),
                itemCount: 10,
                shrinkWrap: true,
                separatorBuilder: (context, index) => Gaps.v6,
                itemBuilder: (context, index) {
                  return Container(
                    decoration: BoxDecoration(
                      border: Border.all(width: 1),
                      borderRadius: const BorderRadius.all(
                        Radius.circular(20),
                      ),
                    ),
                    child: RadioListTile(
                      contentPadding: EdgeInsets.zero,
                      value: "주소 ${index + 1}",
                      groupValue: _address,
                      onChanged: (value) {
                        setState(() {
                          _address = value!;
                        });
                      },
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                              child: Text(
                            "주소 별명 ${index + 1}",
                            maxLines: 2,
                          )),
                          IconButton(
                            onPressed: () {},
                            icon: const Icon(Icons.delete),
                            iconSize: 30,
                          ),
                        ],
                      ),
                      subtitle: Text(
                        "주소 ${index + 1}",
                        maxLines: 3,
                      ),
                    ),
                  );
                },
              ),
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
