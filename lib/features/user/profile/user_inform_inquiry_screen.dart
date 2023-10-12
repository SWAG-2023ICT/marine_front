import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:swag_marine_products/constants/gaps.dart';
import 'package:swag_marine_products/constants/http_ip.dart';
import 'package:swag_marine_products/constants/sizes.dart';
import 'package:swag_marine_products/features/user/profile/user_inform_update_screen.dart';
import 'package:swag_marine_products/models/database/user_model.dart';
import 'package:swag_marine_products/providers/user_provider.dart';

import 'package:http/http.dart' as http;

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
  UserModel? _userData;

  bool _isFirstLoading = false;

  @override
  void initState() {
    super.initState();

    _initUserData();
  }

  Future<void> _initUserData() async {
    setState(() {
      _isFirstLoading = true;
    });

    final url = Uri.parse(
        "${HttpIp.httpIp}/marine/users/${context.read<UserProvider>().userData!.userId}");
    final headers = {'Content-Type': 'application/json'};
    final response = await http.get(url, headers: headers);

    if (response.statusCode >= 200) {
      print("유저 정보 호출 : 성공!");
      print(response.body);
      print(response.headers);

      final jsonResponse = UserModel.fromJson(jsonDecode(response.body));

      setState(() {
        _userData = jsonResponse;
      });
    } else {
      if (!mounted) return;
      HttpIp.errorPrint(
        context: context,
        title: "통신 오류",
        message: response.body,
      );
    }

    setState(() {
      _isFirstLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "회원 정보",
        ),
      ),
      body: _isFirstLoading
          ? const Center(
              child: CircularProgressIndicator.adaptive(),
            )
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: Sizes.size24, vertical: Sizes.size8),
                child: Column(
                  children: [
                    TextFormField(
                      initialValue: _userData!.userId,
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
                        // Expanded(
                        //   child: TextFormField(
                        //     initialValue: _userData!.password,
                        //     readOnly: true,
                        //     obscureText: true,
                        //     decoration: InputDecoration(
                        //       labelText: "비밀번호",
                        //       prefixIcon: Icon(
                        //         Icons.lock_person_outlined,
                        //         color: Colors.grey.shade600,
                        //       ),
                        //     ),
                        //   ),
                        // ),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () async {
                              await context.pushNamed(
                                UserInformUpdateScreen.routeName,
                                extra: const UserInformUpdateScreenArgs(
                                  updateType: UpdateType.pw,
                                ),
                              );

                              _initUserData();
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
                            child: const Text("비밀번호 수정"),
                          ),
                        ),
                      ],
                    ),
                    Gaps.v10,
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: TextFormField(
                            initialValue: _userData!.name,
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
                          onPressed: () async {
                            await context.pushNamed(
                              UserInformUpdateScreen.routeName,
                              extra: const UserInformUpdateScreenArgs(
                                updateType: UpdateType.name,
                              ),
                            );

                            _initUserData();
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
                            initialValue: _userData!.phoneNumber,
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
                          onPressed: () async {
                            await context.pushNamed(
                              UserInformUpdateScreen.routeName,
                              extra: const UserInformUpdateScreenArgs(
                                updateType: UpdateType.phoneNumber,
                              ),
                            );

                            _initUserData();
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
