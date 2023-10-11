import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:kpostal/kpostal.dart';
import 'package:swag_marine_products/constants/gaps.dart';
import 'package:swag_marine_products/constants/http_ip.dart';
import 'package:swag_marine_products/features/sign_in_up/widgets/bottom_button.dart';
import 'package:swag_marine_products/widget_tools/swag_platform_dialog.dart';

import 'package:http/http.dart' as http;

enum UpdateType {
  pw,
  name,
  phoneNumber,
}

class StoreUserInformUpdateScreenArgs {
  const StoreUserInformUpdateScreenArgs({required this.updateType});

  final UpdateType updateType;
}

class StoreUserInformUpdateScreen extends StatefulWidget {
  static const routeName = "store_user_inform_update";
  static const routeURL = "store_user_inform_update";
  const StoreUserInformUpdateScreen({
    super.key,
    required this.updateType,
  });

  final UpdateType updateType;

  @override
  State<StoreUserInformUpdateScreen> createState() =>
      _StoreUserInformUpdateScreenState();
}

class _StoreUserInformUpdateScreenState
    extends State<StoreUserInformUpdateScreen> {
  bool _isSubmitted = false;
  bool _isBarrier = false;

  // 비밀번호 정규식
  final RegExp _passwordRegExp =
      RegExp(r'^(?=.*[A-Z])(?=.*\d)(?=.*[\W_])[A-Za-z\d\W_]{8,}$');

  // 전화번호 정규식
  final RegExp _phoneNumberRegExp = RegExp(
      r'^(02|0[3-9][0-9]{1,2})-[0-9]{3,4}-[0-9]{4}$|^(02|0[3-9][0-9]{1,2})[0-9]{7,8}$|^01[0-9]{9}$|^070-[0-9]{4}-[0-9]{4}$|^070[0-9]{8}$');

  void _onCheckUserData() {
    if (widget.updateType == UpdateType.pw) {
      setState(() {
        _isSubmitted = (_userPasswordBeforeErrorText == null &&
                _userPasswordBeforeController.text.trim().isNotEmpty) &&
            (_userPasswordErrorText == null &&
                _userPasswordController.text.trim().isNotEmpty) &&
            (_userPasswordConfirmationErrorText == null &&
                _userPasswordConfirmationController.text.trim().isNotEmpty);
      });
    } else if (widget.updateType == UpdateType.name) {
      setState(() {
        _isSubmitted = (_userNameErrorText == null &&
                _userNameController.text.trim().isNotEmpty) &&
            (_userPasswordErrorText == null &&
                _userPasswordController.text.trim().isNotEmpty);
      });
    } else if (widget.updateType == UpdateType.phoneNumber) {
      setState(() {
        _isSubmitted = (_userPhoneNumberErrorText == null &&
                _userPhoneNumberController.text.trim().isNotEmpty) &&
            (_userPasswordErrorText == null &&
                _userPasswordController.text.trim().isNotEmpty);
      });
    } else {
      swagPlatformDialog(
        context: context,
        title: "수정 오류!",
        message: "비정상적인 접근입니다!",
        actions: [
          TextButton(
            onPressed: () => context.pop(),
            child: const Text("알겠습니다"),
          ),
        ],
      );
    }
  }

  void _onSubmitted() async {
    if (widget.updateType == UpdateType.pw) {
      print("이전 비밀번호 : ${_userPasswordBeforeController.text}");
      print("변경 비밀번호 : ${_userPasswordController.text}");

      if (false) {
        final url = Uri.parse("${HttpIp.httpIp}/");
        final headers = {'Content-Type': 'application/json'};
        final data = {};
        final response =
            await http.post(url, headers: headers, body: jsonEncode(data));

        if (response.statusCode >= 200 && response.statusCode < 300) {
        } else {
          if (!mounted) return;
          HttpIp.errorPrint(
            context: context,
            title: "통신 오류",
            message: response.body,
          );
        }
      }
    } else if (widget.updateType == UpdateType.name) {
      print("변경 이름 : ${_userNameController.text}");

      if (false) {
        final url = Uri.parse("${HttpIp.httpIp}/");
        final headers = {'Content-Type': 'application/json'};
        final data = {};
        final response =
            await http.post(url, headers: headers, body: jsonEncode(data));

        if (response.statusCode >= 200 && response.statusCode < 300) {
        } else {
          if (!mounted) return;
          HttpIp.errorPrint(
            context: context,
            title: "통신 오류",
            message: response.body,
          );
        }
      }
    } else if (widget.updateType == UpdateType.phoneNumber) {
      print("변경 전화번호 : ${_userPhoneNumberController.text}");

      if (false) {
        final url = Uri.parse("${HttpIp.httpIp}/");
        final headers = {'Content-Type': 'application/json'};
        final data = {};
        final response =
            await http.post(url, headers: headers, body: jsonEncode(data));

        if (response.statusCode >= 200 && response.statusCode < 300) {
        } else {
          if (!mounted) return;
          HttpIp.errorPrint(
            context: context,
            title: "통신 오류",
            message: response.body,
          );
        }
      }
    } else {
      swagPlatformDialog(
        context: context,
        title: "수정 오류!",
        message: "비정상적인 접근입니다!",
        actions: [
          TextButton(
            onPressed: () => context.pop(),
            child: const Text("알겠습니다"),
          ),
        ],
      );
    }
  }

  void _onFieldSubmitted(String value) {
    setState(() {
      _isBarrier = false;
    });
  }

  void onChangeBarrier() {
    setState(() {
      _isBarrier = true;
    });
  }

  final TextEditingController _userPasswordController = TextEditingController();
  final TextEditingController _userPasswordConfirmationController =
      TextEditingController();
  final TextEditingController _userAddressController = TextEditingController();
  final TextEditingController _userAddressDetailController =
      TextEditingController();
  final TextEditingController _userPhoneNumberController =
      TextEditingController();
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _userPhoneNumberAuthController =
      TextEditingController();
  final TextEditingController _userPasswordBeforeController =
      TextEditingController();

  String? _userPasswordErrorText;
  String? _userPasswordConfirmationErrorText;
  String? _userAddressErrorText;
  String? _userPhoneNumberErrorText;
  String? _userNameErrorText;
  String? _userPhoneNumberAuthErrorText;
  String? _userPasswordBeforeErrorText;
  bool _userPhoneNumberAuth = false;

  void _validateUserPassword(String value) {
    if (value.isEmpty) {
      setState(() {
        _userPasswordErrorText = '비밀번호를 입력하세요.';
      });
    } else if (!_passwordRegExp.hasMatch(value)) {
      setState(() {
        _userPasswordErrorText = '영어 대/소문자와 숫자, 특수기호를 포함한 8자 이상 입력하세요.';
      });
    } else if (_userPasswordBeforeController.text == value) {
      setState(() {
        _userPasswordErrorText = '이전 비밀번호와 변경 비밀번호가 같으면 안됩니다!';
      });
    } else {
      setState(() {
        _userPasswordErrorText = null;
      });
      _onCheckUserData();
    }
  }

  void _validateUserPasswordConfirmation(String value) {
    if (value.isEmpty) {
      setState(() {
        _userPasswordConfirmationErrorText = '비밀번호 확인을 입력하세요.';
      });
    } else if (value != _userPasswordController.text) {
      setState(() {
        _userPasswordConfirmationErrorText = '비밀번호가 일치하지 않습니다.';
      });
    } else {
      setState(() {
        _userPasswordConfirmationErrorText = null;
      });
      _onCheckUserData();
    }
  }

  void _validateUserPasswordBefore(String value) {
    if (value.isEmpty) {
      setState(() {
        _userPasswordBeforeErrorText = '비밀번호 확인을 입력하세요.';
      });
    } else if (!_passwordRegExp.hasMatch(value)) {
      setState(() {
        _userPasswordBeforeErrorText = '영어 대/소문자와 숫자, 특수기호를 포함한 8자 이상 입력하세요.';
      });
    } else {
      setState(() {
        _userPasswordBeforeErrorText = null;
      });
      _onCheckUserData();
    }
  }

  void _validateUserName(String value) {
    if (value.isEmpty) {
      setState(() {
        _userNameErrorText = '이름(실명)을 입력하세요.';
      });
    } else {
      setState(() {
        _userNameErrorText = null;
      });
      _onCheckUserData();
    }
  }

  void _validateUserPhoneNumber(String value) {
    if (value.isEmpty) {
      setState(() {
        _userPhoneNumberErrorText = '전화번호를 입력하세요.';
      });
    } else if (!_phoneNumberRegExp.hasMatch(value)) {
      setState(() {
        _userPhoneNumberErrorText = "전화번호 규칙에 맞게 입력하세요.";
      });
    } else {
      setState(() {
        _userPhoneNumberErrorText = null;
      });
      _onCheckUserData();
    }
  }

  void _validateUserPhoneNumberAuth(String value) {
    if (value.isEmpty) {
      setState(() {
        _userPhoneNumberAuthErrorText = '인증코드를 입력하세요.';
      });
    } else {
      setState(() {
        _userPhoneNumberAuthErrorText = null;
      });
      _onCheckUserData();
    }
  }

  void _onSearchUserAddress() async {
    Kpostal result = await Navigator.push(
        context, MaterialPageRoute(builder: (_) => KpostalView()));
    print(result.address);
    setState(() {
      _userAddressController.text = result.address;
    });
    _onCheckUserData();
  }

  void _onCheckAuthUserCode() {
    setState(() {
      _userPhoneNumberAuth = !_userPhoneNumberAuth;
    });
    _onCheckUserData();
  }

  @override
  void dispose() {
    _userPasswordController.dispose();
    _userPasswordConfirmationController.dispose();
    _userNameController.dispose();
    _userPhoneNumberController.dispose();
    _userPhoneNumberAuthController.dispose();
    _userAddressController.dispose();
    _userAddressDetailController.dispose();
    _userPasswordBeforeController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: _updateInfo(),
    );
  }

  Widget _updateInfo() {
    if (widget.updateType == UpdateType.pw) {
      return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text("비밀번호 수정"),
        ),
        bottomNavigationBar: Container(
          padding: const EdgeInsets.symmetric(
            vertical: 20,
            horizontal: 20,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              BottomButton(
                onPressed: _isSubmitted ? _onSubmitted : null,
                text: "수정",
                isClicked: _isSubmitted,
              ),
            ],
          ),
        ),
        body: Stack(
          children: [
            ListView(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              children: [
                TextFormField(
                  controller: _userPasswordBeforeController,
                  decoration: InputDecoration(
                    labelText: '이전 비밀번호',
                    errorText: _userPasswordBeforeErrorText,
                    prefixIcon: Icon(
                      Icons.lock_outline,
                      color: Colors.grey.shade600,
                    ),
                  ),
                  obscureText: true,
                  onTap: onChangeBarrier,
                  onChanged: _validateUserPasswordBefore,
                  onFieldSubmitted: _onFieldSubmitted,
                ),
                Gaps.v10,
                TextFormField(
                  controller: _userPasswordController,
                  decoration: InputDecoration(
                    labelText: '변경 비밀번호',
                    errorText: _userPasswordErrorText,
                    prefixIcon: Icon(
                      Icons.lock_outline,
                      color: Colors.grey.shade600,
                    ),
                  ),
                  obscureText: true,
                  onTap: onChangeBarrier,
                  onChanged: _validateUserPassword,
                  onFieldSubmitted: _onFieldSubmitted,
                ),
                Gaps.v10,
                TextFormField(
                  controller: _userPasswordConfirmationController,
                  decoration: InputDecoration(
                    labelText: '변경 비밀번호 확인',
                    errorText: _userPasswordConfirmationErrorText,
                    prefixIcon: Icon(
                      Icons.lock_person_outlined,
                      color: Colors.grey.shade600,
                    ),
                  ),
                  obscureText: true,
                  onTap: onChangeBarrier,
                  onChanged: _validateUserPasswordConfirmation,
                  onFieldSubmitted: _onFieldSubmitted,
                ),
              ],
            ),
            if (_isBarrier)
              ModalBarrier(
                // color: _barrierAnimation,
                color: Colors.transparent,
                // 자신을 클릭하면 onDismiss를 실행하는지에 대한 여부
                dismissible: true,
                // 자신을 클릭하면 실행되는 함수
                onDismiss: () {
                  setState(() {
                    _isBarrier = false;
                    FocusScope.of(context).unfocus();
                  });
                },
              ),
          ],
        ),
      );
    } else if (widget.updateType == UpdateType.name) {
      return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text("이름(실명) 수정"),
        ),
        bottomNavigationBar: Container(
          padding: const EdgeInsets.symmetric(
            vertical: 20,
            horizontal: 20,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              BottomButton(
                onPressed: _isSubmitted ? () {} : null,
                text: "수정",
                isClicked: _isSubmitted,
              ),
            ],
          ),
        ),
        body: Stack(
          children: [
            ListView(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              children: [
                TextFormField(
                  controller: _userNameController,
                  keyboardType: TextInputType.name,
                  decoration: InputDecoration(
                    labelText: '이름(실명)',
                    errorText: _userNameErrorText,
                    prefixIcon: Icon(
                      Icons.badge_outlined,
                      color: Colors.grey.shade600,
                    ),
                  ),
                  onTap: onChangeBarrier,
                  onChanged: _validateUserName,
                  onFieldSubmitted: _onFieldSubmitted,
                ),
                Gaps.v10,
                TextFormField(
                  controller: _userPasswordController,
                  decoration: InputDecoration(
                    labelText: '현재 비밀번호',
                    errorText: _userPasswordErrorText,
                    prefixIcon: Icon(
                      Icons.lock_outline,
                      color: Colors.grey.shade600,
                    ),
                  ),
                  obscureText: true,
                  onTap: onChangeBarrier,
                  onChanged: _validateUserPassword,
                  onFieldSubmitted: _onFieldSubmitted,
                ),
              ],
            ),
            if (_isBarrier)
              ModalBarrier(
                // color: _barrierAnimation,
                color: Colors.transparent,
                // 자신을 클릭하면 onDismiss를 실행하는지에 대한 여부
                dismissible: true,
                // 자신을 클릭하면 실행되는 함수
                onDismiss: () {
                  setState(() {
                    _isBarrier = false;
                    FocusScope.of(context).unfocus();
                  });
                },
              ),
          ],
        ),
      );
    } else if (widget.updateType == UpdateType.phoneNumber) {
      return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text("전화번호 수정"),
        ),
        bottomNavigationBar: Container(
          padding: const EdgeInsets.symmetric(
            vertical: 20,
            horizontal: 20,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              BottomButton(
                onPressed: _isSubmitted ? () {} : null,
                text: "수정",
                isClicked: _isSubmitted,
              ),
            ],
          ),
        ),
        body: Stack(
          children: [
            ListView(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: _userPhoneNumberController,
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(
                          labelText: '전화번호',
                          errorText: _userPhoneNumberErrorText,
                          prefixIcon: Icon(
                            Icons.phone_iphone_rounded,
                            color: Colors.grey.shade600,
                          ),
                        ),
                        onTap: onChangeBarrier,
                        onChanged: _validateUserPhoneNumber,
                        onFieldSubmitted: _onFieldSubmitted,
                      ),
                    ),
                    if (false)
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.all(24),
                          textStyle: const TextStyle(fontSize: 14),
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(10),
                            ),
                          ),
                        ),
                        child: const Text("인증 요청"),
                      ),
                  ],
                ),
                // Gaps.v10,
                if (false)
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: _userPhoneNumberAuthController,
                          keyboardType: TextInputType.phone,
                          decoration: InputDecoration(
                            labelText: '전화번호 인증',
                            errorText: _userPhoneNumberAuthErrorText,
                            prefixIcon: Icon(
                              Icons.phonelink_lock_outlined,
                              color: Colors.grey.shade600,
                            ),
                          ),
                          onTap: onChangeBarrier,
                          onChanged: _validateUserPhoneNumberAuth,
                          onFieldSubmitted: _onFieldSubmitted,
                        ),
                      ),
                      ElevatedButton(
                        onPressed: _onCheckAuthUserCode,
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.all(24),
                          textStyle: const TextStyle(fontSize: 14),
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(10),
                            ),
                          ),
                        ),
                        child: const Text("인증 확인"),
                      ),
                    ],
                  ),
                if (_userPhoneNumberAuth)
                  const Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 4,
                    ),
                    child: Text(
                      "전화번호 인증 완료!",
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: 16,
                      ),
                    ),
                  ),
                Gaps.v10,
                TextFormField(
                  controller: _userPasswordController,
                  decoration: InputDecoration(
                    labelText: '현재 비밀번호',
                    errorText: _userPasswordErrorText,
                    prefixIcon: Icon(
                      Icons.lock_outline,
                      color: Colors.grey.shade600,
                    ),
                  ),
                  obscureText: true,
                  onTap: onChangeBarrier,
                  onChanged: _validateUserPassword,
                  onFieldSubmitted: _onFieldSubmitted,
                ),
              ],
            ),
            if (_isBarrier)
              ModalBarrier(
                // color: _barrierAnimation,
                color: Colors.transparent,
                // 자신을 클릭하면 onDismiss를 실행하는지에 대한 여부
                dismissible: true,
                // 자신을 클릭하면 실행되는 함수
                onDismiss: () {
                  setState(() {
                    _isBarrier = false;
                    FocusScope.of(context).unfocus();
                  });
                },
              ),
          ],
        ),
      );
    } else {
      return const Center(
        child: Text("비정상적인 접근입니다!"),
      );
    }
  }
}
