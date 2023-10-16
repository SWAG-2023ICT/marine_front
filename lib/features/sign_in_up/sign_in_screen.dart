import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:swag_marine_products/constants/gaps.dart';
import 'package:swag_marine_products/constants/http_ip.dart';
import 'package:swag_marine_products/features/sign_in_up/sign_up_screen.dart';
import 'package:swag_marine_products/features/store/navigation/store_navigation_screen.dart';
import 'package:swag_marine_products/features/user/navigation/user_navigation_screen.dart';
import 'package:swag_marine_products/models/database/store_model.dart';
import 'package:swag_marine_products/models/database/user_model.dart';
import 'package:swag_marine_products/providers/store_provider.dart';
import 'package:swag_marine_products/providers/user_provider.dart';
import 'package:swag_marine_products/storages/login_storage.dart';

import 'package:http/http.dart' as http;
import 'package:swag_marine_products/widget_tools/swag_platform_dialog.dart';

class SignInScreen extends StatefulWidget {
  static const routeName = "signIn";
  static const routeURL = "/";
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final TextEditingController _idController = TextEditingController();
  final FocusNode _idFocusNode = FocusNode();
  final TextEditingController _passwordController = TextEditingController();
  final FocusNode _pwFocusNode = FocusNode();

  bool _rememberMe = false;
  final bool _isStored = false;
  bool _isSubmitted = true;
  final List<bool> _isSelected = [false, true];

  final RegExp _idRegExp = RegExp(r'^[a-zA-Z0-9]+$'); // 아이디 정규식
  final int _minPasswordLength = 6; // 최소 비밀번호 길이

  String? _idErrorText; // 아이디 오류 메시지
  String? _passwordErrorText; // 비밀번호 오류 메시지

  void _validateId(String value) {
    if (value.isEmpty) {
      setState(() {
        _idErrorText = '아이디를 입력하세요.';
      });
    } else if (!_idRegExp.hasMatch(value)) {
      setState(() {
        _idErrorText = '영문과 숫자만 입력하세요.';
      });
    } else {
      setState(() {
        _idErrorText = null; // 오류가 없을 경우 null로 설정
      });
      _checkSubmitted();
    }
  }

  // 비밀번호 정규식
  final RegExp _passwordRegExp =
      RegExp(r'^(?=.*[A-Z])(?=.*\d)(?=.*[\W_])[A-Za-z\d\W_]{8,}$');

  void _validatePassword(String value) {
    if (value.isEmpty) {
      setState(() {
        _passwordErrorText = '비밀번호를 입력하세요.';
      });
    } else if (!_passwordRegExp.hasMatch(value)) {
      setState(() {
        _passwordErrorText = '영문자와 숫자, 특수기호를 포함한 8자 이상 입력하세요.';
      });
    } else {
      setState(() {
        _passwordErrorText = null; // 오류가 없을 경우 null로 설정
      });
      _checkSubmitted();
    }
  }

  void _checkSubmitted() {
    setState(() {
      _isSubmitted = _idErrorText == null && _passwordErrorText == null;
    });
  }

  void _handleLogin() async {
    final url = Uri.parse("${HttpIp.httpIp}/marine/users/auth");
    final headers = {'Content-Type': 'application/json'};
    final data = {
      'userId': _idController.text.trim(),
      'password': _passwordController.text.trim(),
    };
    final response =
        await http.post(url, headers: headers, body: jsonEncode(data));

    if (response.statusCode >= 200 && response.statusCode < 300) {
      final jsonResponse = jsonDecode(response.body) as Map<String, dynamic>;

      if (_rememberMe) {
        await LoginStorage.saveLoginData(
          id: _idController.text,
          pw: _passwordController.text,
          isStored: _isStored,
        );
      }

      if (jsonResponse["userType"] == "user") {
        print("로그인 - 유저 : 성공!");
        final userData = UserModel.fromJson(jsonResponse["data"]);

        final destinationId = userData.destinations
            .firstWhere(
              (destination) => destination.defaultStatus,
            )
            .destinationId;

        if (!mounted) return;
        await context.read<UserProvider>().login(userData, destinationId);

        if (!mounted) return;
        context.replaceNamed(UserNavigationScreen.routeName);
      } else {
        print("로그인 - 가게 : 성공!");
        print(jsonResponse["data"]);

        final storeData = StoreModel.fromJson(jsonResponse["data"]);

        if (!mounted) return;
        await context
            .read<StoreProvider>()
            .login(_idController.text.trim(), storeData.storeId);

        if (!mounted) return;
        context.replaceNamed(
          StoreNavigationScreen.routeName,
          extra: StoreNavigationScreenArgs(
            selectedIndex: 0,
            storedata: storeData,
          ),
        );
      }
    } else {
      if (!mounted) return;
      HttpIp.errorPrint(
        context: context,
        title: "통신 오류",
        message: response.body,
      );
    }
    // context.replaceNamed(UserNavigationScreen.routeName);
  }

  Future<void> _onTapSignUp() async {
    await context.pushNamed(SignUpScreen.routeName);
  }

  @override
  void dispose() {
    _idController.dispose();
    _passwordController.dispose();
    _idFocusNode.dispose();
    _pwFocusNode.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _idFocusNode.unfocus();
        _pwFocusNode.unfocus();
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        bottomNavigationBar: Container(
          color: Colors.blue.shade200,
          padding: const EdgeInsets.symmetric(vertical: 30),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "계정이 없으신가요? ",
                style: TextStyle(fontSize: 16),
              ),
              GestureDetector(
                onTap: _onTapSignUp,
                child: const Text(
                  " 회원가입",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.purple,
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          ),
        ),
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                // Colors.blue.shade200,
                Colors.white,
                Colors.blue.shade200,
              ], // 시작과 끝 색상 지정
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Expanded(
                  flex: 2,
                  child: Center(
                    child: Text(
                      "Mariner!",
                      style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                // Padding(
                //   padding: const EdgeInsets.only(
                //     bottom: 30,
                //     right: 20,
                //     left: 20,
                //   ),
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.center,
                //     children: [
                //       Expanded(
                //         child: OutlinedButton(
                //           style: OutlinedButton.styleFrom(
                //             // padding: const EdgeInsets.symmetric(horizontal: 50),
                //             textStyle: const TextStyle(
                //               color: Colors.black,
                //             ),
                //             backgroundColor: _isStored
                //                 ? Colors.white.withOpacity(0.6)
                //                 : Colors.lightBlue.shade100,
                //             shape: const RoundedRectangleBorder(
                //               borderRadius: BorderRadius.only(
                //                 topLeft: Radius.circular(10),
                //                 bottomLeft: Radius.circular(10),
                //               ),
                //             ),
                //           ),
                //           onPressed: () => setState(() {
                //             _isStored = false;
                //           }),
                //           child: const Text("유저"),
                //         ),
                //       ),
                //       Expanded(
                //         child: OutlinedButton(
                //           style: OutlinedButton.styleFrom(
                //             // padding: const EdgeInsets.symmetric(horizontal: 50),
                //             textStyle: const TextStyle(
                //               color: Colors.black,
                //             ),
                //             backgroundColor: _isStored
                //                 ? Colors.lightBlue.shade100
                //                 : Colors.white.withOpacity(0.6),
                //             shape: const RoundedRectangleBorder(
                //               borderRadius: BorderRadius.only(
                //                 topRight: Radius.circular(10),
                //                 bottomRight: Radius.circular(10),
                //               ),
                //             ),
                //           ),
                //           onPressed: () => setState(() {
                //             _isStored = true;
                //           }),
                //           child: const Text("가게"),
                //         ),
                //       ),
                //     ],
                //   ),
                // ),
                Expanded(
                  flex: 3,
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 20,
                        ),
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(
                            Radius.circular(20),
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            TextFormField(
                              controller: _idController,
                              focusNode: _idFocusNode,
                              autofocus: false,
                              decoration: InputDecoration(
                                prefixIcon: Icon(
                                  Icons.person_outline,
                                  color: Colors.grey.shade600,
                                ),
                                labelText: '아이디',
                                errorText: _idErrorText, // 아이디 오류 메시지 표시
                              ),
                              onChanged: _validateId, // 입력 값이 변경될 때마다 검증
                            ),
                            Gaps.v10,
                            TextFormField(
                              controller: _passwordController,
                              focusNode: _pwFocusNode,
                              obscureText: true,
                              autofocus: false,
                              decoration: InputDecoration(
                                prefixIcon: Icon(
                                  Icons.lock_outline,
                                  color: Colors.grey.shade600,
                                ),
                                labelText: '비밀번호',
                                errorText: _passwordErrorText, // 비밀번호 오류 메시지 표시
                              ),
                              onChanged: _validatePassword, // 입력 값이 변경될 때마다 검증
                            ),
                            Gaps.v10,
                            Row(
                              children: [
                                Checkbox(
                                  value: _rememberMe,
                                  onChanged: (value) {
                                    setState(() {
                                      _rememberMe = value!;
                                    });
                                  },
                                ),
                                const Text('로그인 정보 저장'),
                              ],
                            ),
                            Gaps.v10,
                            ElevatedButton(
                              style: const ButtonStyle(),
                              onPressed:
                                  _isSubmitted ? () => _handleLogin() : null,
                              child: const Text('로그인'),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
