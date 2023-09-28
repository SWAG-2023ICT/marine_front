// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:kpostal/kpostal.dart';

import 'package:swag_marine_products/constants/gaps.dart';
import 'package:swag_marine_products/screens/sign_in_up/widgets/bottom_button.dart';
import 'package:swag_marine_products/widget_tools/swag_platform_dialog.dart';

class SignUpFirst extends StatefulWidget {
  const SignUpFirst({
    Key? key,
    required this.isStored,
    required this.onChangeUser,
    required this.onChangeStore,
    required this.onNextPage,
  }) : super(key: key);

  final bool isStored;
  final Function onChangeUser;
  final Function onChangeStore;
  final Function onNextPage;

  @override
  State<SignUpFirst> createState() => _SignUpFirstState();
}

class _SignUpFirstState extends State<SignUpFirst> {
  // ------------------ 공통 변수 및 메소드 ------------------
  bool _isSubmitted = true;
  bool _isBarrier = false;

  // 아이디 정규식
  final RegExp _idRegExp = RegExp(r'^[a-zA-Z0-9]+$');

  // 비밀번호 정규식
  final RegExp _passwordRegExp =
      RegExp(r'^(?=.*[A-Z])(?=.*\d)(?=.*[\W_])[A-Za-z\d\W_]{8,}$');

  // 전화번호 정규식
  final RegExp _phoneNumberRegExp = RegExp(
      r'^(02|0[3-9][0-9]{1,2})-[0-9]{3,4}-[0-9]{4}$|^(02|0[3-9][0-9]{1,2})[0-9]{7,8}$|^01[0-9]{9}$|^070-[0-9]{4}-[0-9]{4}$|^070[0-9]{8}$');

  void _onCheckSubmitted() {
    if (widget.isStored) {
    } else {
      setState(() {
        _isSubmitted = (_userIdErrorText == null &&
                _userIdController.text.trim().isNotEmpty) &&
            (_userPasswordErrorText == null &&
                _userPasswordController.text.trim().isNotEmpty) &&
            (_userPasswordConfirmationErrorText == null &&
                _userPasswordConfirmationController.text.trim().isNotEmpty) &&
            (_userNameErrorText == null &&
                _userNameController.text.trim().isNotEmpty) &&
            (_userAddressErrorText == null &&
                _userAddressController.text.trim().isNotEmpty) &&
            (_userPhoneNumberErrorText == null &&
                _userPhoneNumberAuthController.text.trim().isNotEmpty) &&
            (_userPhoneNumberAuthErrorText == null &&
                _userPhoneNumberAuthController.text.trim().isNotEmpty &&
                _userPhoneNumberAuth);
      });
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

  // ------------------ 유저 정보 변수 및 메소드 ------------------
  final TextEditingController _userIdController = TextEditingController();
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

  String? _userIdErrorText;
  String? _userPasswordErrorText;
  String? _userPasswordConfirmationErrorText;
  String? _userAddressErrorText;
  String? _userPhoneNumberErrorText;
  String? _userNameErrorText;
  String? _userPhoneNumberAuthErrorText;
  bool _userPhoneNumberAuth = false;

  void _validateUserId(String value) {
    if (value.isEmpty) {
      setState(() {
        _userIdErrorText = '아이디를 입력하세요.';
      });
    } else if (!_idRegExp.hasMatch(value)) {
      setState(() {
        _userIdErrorText = '영문자와 숫자만 입력하세요.';
      });
    } else {
      setState(() {
        _userIdErrorText = null;
      });
      _onCheckSubmitted();
    }
  }

  void _validateUserPassword(String value) {
    if (value.isEmpty) {
      setState(() {
        _userPasswordErrorText = '비밀번호를 입력하세요.';
      });
    } else if (!_passwordRegExp.hasMatch(value)) {
      setState(() {
        _userPasswordErrorText = '영문자와 숫자, 특수기호를 포함한 8자 이상 입력하세요.';
      });
    } else {
      setState(() {
        _userPasswordErrorText = null;
      });
      _onCheckSubmitted();
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
      _onCheckSubmitted();
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
      _onCheckSubmitted();
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
      _onCheckSubmitted();
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
      _onCheckSubmitted();
    }
  }

  void _onSearchUserAddress() async {
    Kpostal result = await Navigator.push(
        context, MaterialPageRoute(builder: (_) => KpostalView()));
    print(result.address);
    setState(() {
      _userAddressController.text = result.address;
    });
    _onCheckSubmitted();
  }

  void _onCheckAuthUserCode() {
    setState(() {
      _userPhoneNumberAuth = !_userPhoneNumberAuth;
    });
    _onCheckSubmitted();
  }

  // ------------------ 가게 정보 변수 및 메소드 ------------------
  final TextEditingController _storeIdController =
      TextEditingController(); // id
  final TextEditingController _storePasswordController =
      TextEditingController(); // pw
  final TextEditingController _storePasswordConfirmationController =
      TextEditingController(); // pw 확인
  final TextEditingController _storeAddressController =
      TextEditingController(); // 주소
  final TextEditingController _storeAddressDetailController =
      TextEditingController(); // 상세 주소
  final TextEditingController _storePhoneNumberController =
      TextEditingController(); // 전화번호
  final TextEditingController _storePhoneNumberAuthController =
      TextEditingController(); // 전화번호 인증 코드
  final TextEditingController _storeNameController =
      TextEditingController(); // 이름
  final TextEditingController _storeBusinessNumberController =
      TextEditingController(); // 사업자 번호
  final TextEditingController _storeBusinessNameController =
      TextEditingController(); // 가게 이름
  final TextEditingController _storeBusinessPhoneNumberController =
      TextEditingController(); // 가게 전화번호
  final TextEditingController _storeBusinessPhoneNumberAuthController =
      TextEditingController(); // 가게 전화번호 인증 코드

  String? _storeIdErrorText;
  String? _storePasswordErrorText;
  String? _storePasswordConfirmationErrorText;
  String? _storeAddressErrorText;
  String? _storePhoneNumberErrorText;
  String? _storeNameErrorText;
  String? _storePhoneNumberAuthErrorText;
  bool _storePhoneNumberAuth = false;

  // XXX-XX-XXXXX 또는 XXXXXXXXXXX 형식의 대한민국 사업자 번호 정규식
  final RegExp _businessNumberRegExp = RegExp(r'^\d{3}-\d{2}-\d{5}|\d{10}$');

  void _validateStoreId(String value) {
    if (value.isEmpty) {
      setState(() {
        _storeIdErrorText = '아이디를 입력하세요.';
      });
    } else if (!_idRegExp.hasMatch(value)) {
      setState(() {
        _storeIdErrorText = '영문자와 숫자만 입력하세요.';
      });
    } else {
      setState(() {
        _storeIdErrorText = null;
      });
      _onCheckSubmitted();
    }
  }

  void _validateStorePassword(String value) {
    if (value.isEmpty) {
      setState(() {
        _storePasswordErrorText = '비밀번호를 입력하세요.';
      });
    } else if (!_passwordRegExp.hasMatch(value)) {
      setState(() {
        _storePasswordErrorText = '영문자와 숫자, 특수기호를 포함한 8자 이상 입력하세요.';
      });
    } else {
      setState(() {
        _storePasswordErrorText = null;
      });
      _onCheckSubmitted();
    }
  }

  void _validateStorePasswordConfirmation(String value) {
    if (value.isEmpty) {
      setState(() {
        _storePasswordConfirmationErrorText = '비밀번호 확인을 입력하세요.';
      });
    } else if (value != _storePasswordController.text) {
      setState(() {
        _storePasswordConfirmationErrorText = '비밀번호가 일치하지 않습니다.';
      });
    } else {
      setState(() {
        _storePasswordConfirmationErrorText = null;
      });
      _onCheckSubmitted();
    }
  }

  void _validateStoreName(String value) {
    if (value.isEmpty) {
      setState(() {
        _storeNameErrorText = '이름(실명)을 입력하세요.';
      });
    } else {
      setState(() {
        _storeNameErrorText = null;
      });
      _onCheckSubmitted();
    }
  }

  void _validateStorePhoneNumber(String value) {
    if (value.isEmpty) {
      setState(() {
        _storePhoneNumberErrorText = '전화번호를 입력하세요.';
      });
    } else if (!_phoneNumberRegExp.hasMatch(value)) {
      setState(() {
        _storePhoneNumberErrorText = "전화번호 규칙에 맞게 입력하세요.";
      });
    } else {
      setState(() {
        _storePhoneNumberErrorText = null;
      });
      _onCheckSubmitted();
    }
  }

  void _validateStorePhoneNumberAuth(String value) {
    if (value.isEmpty) {
      setState(() {
        _storePhoneNumberAuthErrorText = '인증코드를 입력하세요.';
      });
    } else {
      setState(() {
        _storePhoneNumberAuthErrorText = null;
      });
      _onCheckSubmitted();
    }
  }

  void _onSearchStoreAddress() async {
    Kpostal result = await Navigator.push(
        context, MaterialPageRoute(builder: (_) => KpostalView()));
    print(result.address);
    setState(() {
      _storeAddressController.text = result.address;
    });
    _onCheckSubmitted();
  }

  void _onCheckAuthStoreCode() {
    setState(() {
      _storePhoneNumberAuth = !_storePhoneNumberAuth;
    });
    _onCheckSubmitted();
  }

  // ------------------ 기본 메소드 ------------------
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    // 유저 정보
    _userAddressController.dispose();
    _userAddressDetailController.dispose();
    _userIdController.dispose();
    _userPasswordConfirmationController.dispose();
    _userPasswordController.dispose();
    _userNameController.dispose();
    _userPhoneNumberAuthController.dispose();
    _userPhoneNumberAuthController.dispose();

    // 가게 정보
    _storeAddressController.dispose();
    _storeAddressDetailController.dispose();
    _storeIdController.dispose();
    _storePasswordConfirmationController.dispose();
    _storePasswordController.dispose();
    _storeNameController.dispose();
    _storePhoneNumberAuthController.dispose();
    _storePhoneNumberAuthController.dispose();
    _storeBusinessNumberController.dispose();
    _storeBusinessNameController.dispose();
    _storeBusinessPhoneNumberController.dispose();
    _storeBusinessPhoneNumberAuthController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      child: Scaffold(
        bottomNavigationBar: Container(
          padding: const EdgeInsets.symmetric(
            vertical: 20,
            horizontal: 20,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              BottomButton(
                onPressed: () {
                  swagPlatformDialog(
                    context: context,
                    title: "회원가입 알림",
                    message: "정말로 회원가입을 취소 하시겠습니까?",
                    actions: [
                      TextButton(
                        onPressed: () {
                          context.pop();
                        },
                        child: const Text(
                          "아니오",
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          context.pop();
                          context.pop();
                        },
                        child: const Text(
                          "예",
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    ],
                  );
                },
                text: "취소",
              ),
              Gaps.h10,
              BottomButton(
                onPressed: _isSubmitted ? () => widget.onNextPage() : null,
                text: "다음",
                isClicked: _isSubmitted,
              ),
            ],
          ),
        ),
        body: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: widget.isStored ? _storeInfo() : _userInfo(),
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
      ),
    );
  }

  Widget _userInfo() {
    return ListView(
      padding: const EdgeInsets.symmetric(vertical: 20),
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    textStyle: const TextStyle(
                      color: Colors.black,
                    ),
                    backgroundColor: widget.isStored
                        ? Colors.white.withOpacity(0.6)
                        : Colors.lightBlue.shade100,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        bottomLeft: Radius.circular(10),
                      ),
                    ),
                  ),
                  onPressed: () => widget.onChangeUser(),
                  child: const Text("유저"),
                ),
              ),
              Expanded(
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    textStyle: const TextStyle(
                      color: Colors.black,
                    ),
                    backgroundColor: widget.isStored
                        ? Colors.lightBlue.shade100
                        : Colors.white.withOpacity(0.6),
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(10),
                        bottomRight: Radius.circular(10),
                      ),
                    ),
                  ),
                  onPressed: () => widget.onChangeStore(),
                  child: const Text("가게"),
                ),
              ),
            ],
          ),
        ),
        Gaps.v10,
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: TextFormField(
                controller: _userIdController,
                decoration: InputDecoration(
                  labelText: '아이디',
                  errorText: _userIdErrorText,
                  prefixIcon: Icon(
                    Icons.person_outline,
                    color: Colors.grey.shade600,
                  ),
                ),
                onTap: onChangeBarrier,
                onChanged: _validateUserId,
                onFieldSubmitted: _onFieldSubmitted,
              ),
            ),
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
              child: const Text("중복 확인"),
            ),
          ],
        ),
        Gaps.v10,
        TextFormField(
          controller: _userPasswordController,
          decoration: InputDecoration(
            labelText: '비밀번호',
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
            labelText: '비밀번호 확인',
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
        Gaps.v10,
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
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: TextFormField(
                controller: _userAddressController,
                readOnly: true,
                decoration: InputDecoration(
                  labelText: '주소',
                  errorText: _userAddressErrorText,
                  prefixIcon: Icon(
                    Icons.home_work_outlined,
                    color: Colors.grey.shade600,
                  ),
                ),
              ),
            ),
            ElevatedButton(
              onPressed: _onSearchUserAddress,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.all(24),
                textStyle: const TextStyle(fontSize: 14),
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
              ),
              child: const Text("주소 검색"),
            ),
          ],
        ),
        Gaps.v10,
        TextFormField(
          controller: _userAddressDetailController,
          keyboardType: TextInputType.text,
          decoration: InputDecoration(
            labelText: '주소 상세 정보',
            prefixIcon: Icon(
              Icons.add_home_work_outlined,
              color: Colors.grey.shade600,
            ),
          ),
          onTap: onChangeBarrier,
          onFieldSubmitted: _onFieldSubmitted,
        ),
        Gaps.v10,
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
        Gaps.v10,
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
      ],
    );
  }

  Widget _storeInfo() {
    return ListView(
      padding: const EdgeInsets.symmetric(vertical: 20),
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    textStyle: const TextStyle(
                      color: Colors.black,
                    ),
                    backgroundColor: widget.isStored
                        ? Colors.white.withOpacity(0.6)
                        : Colors.lightBlue.shade100,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        bottomLeft: Radius.circular(10),
                      ),
                    ),
                  ),
                  onPressed: () => widget.onChangeUser(),
                  child: const Text("유저"),
                ),
              ),
              Expanded(
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    textStyle: const TextStyle(
                      color: Colors.black,
                    ),
                    backgroundColor: widget.isStored
                        ? Colors.lightBlue.shade100
                        : Colors.white.withOpacity(0.6),
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(10),
                        bottomRight: Radius.circular(10),
                      ),
                    ),
                  ),
                  onPressed: () => widget.onChangeStore(),
                  child: const Text("가게"),
                ),
              ),
            ],
          ),
        ),
        Gaps.v10,
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: TextFormField(
                controller: _storeIdController,
                decoration: InputDecoration(
                  labelText: '아이디',
                  errorText: _storeIdErrorText,
                  prefixIcon: Icon(
                    Icons.person_outline,
                    color: Colors.grey.shade600,
                  ),
                ),
                onTap: onChangeBarrier,
                onChanged: _validateStoreId,
                onFieldSubmitted: _onFieldSubmitted,
              ),
            ),
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
              child: const Text("중복 확인"),
            ),
          ],
        ),
        Gaps.v10,
        TextFormField(
          controller: _storePasswordController,
          decoration: InputDecoration(
            labelText: '비밀번호',
            errorText: _storePasswordErrorText,
            prefixIcon: Icon(
              Icons.lock_outline,
              color: Colors.grey.shade600,
            ),
          ),
          obscureText: true,
          onTap: onChangeBarrier,
          onChanged: _validateStorePassword,
          onFieldSubmitted: _onFieldSubmitted,
        ),
        Gaps.v10,
        TextFormField(
          controller: _storePasswordConfirmationController,
          decoration: InputDecoration(
            labelText: '비밀번호 확인',
            errorText: _storePasswordConfirmationErrorText,
            prefixIcon: Icon(
              Icons.lock_person_outlined,
              color: Colors.grey.shade600,
            ),
          ),
          obscureText: true,
          onTap: onChangeBarrier,
          onChanged: _validateStorePasswordConfirmation,
          onFieldSubmitted: _onFieldSubmitted,
        ),
        Gaps.v10,
        TextFormField(
          controller: _storeNameController,
          keyboardType: TextInputType.name,
          decoration: InputDecoration(
            labelText: '이름(실명)',
            errorText: _storeNameErrorText,
            prefixIcon: Icon(
              Icons.badge_outlined,
              color: Colors.grey.shade600,
            ),
          ),
          onTap: onChangeBarrier,
          onChanged: _validateStoreName,
          onFieldSubmitted: _onFieldSubmitted,
        ),
        Gaps.v10,
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: TextFormField(
                controller: _storeAddressController,
                readOnly: true,
                decoration: InputDecoration(
                  labelText: '사용자 주소',
                  errorText: _storeAddressErrorText,
                  prefixIcon: Icon(
                    Icons.home_work_outlined,
                    color: Colors.grey.shade600,
                  ),
                ),
              ),
            ),
            ElevatedButton(
              onPressed: _onSearchStoreAddress,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.all(24),
                textStyle: const TextStyle(fontSize: 14),
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
              ),
              child: const Text("주소 검색"),
            ),
          ],
        ),
        Gaps.v10,
        TextFormField(
          controller: _storeAddressDetailController,
          keyboardType: TextInputType.text,
          decoration: InputDecoration(
            labelText: '주소 상세 정보',
            prefixIcon: Icon(
              Icons.add_home_work_outlined,
              color: Colors.grey.shade600,
            ),
          ),
          onTap: onChangeBarrier,
          onFieldSubmitted: _onFieldSubmitted,
        ),
        Gaps.v10,
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: TextFormField(
                controller: _storePhoneNumberController,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  labelText: '전화번호',
                  errorText: _storePhoneNumberErrorText,
                  prefixIcon: Icon(
                    Icons.phone_iphone_rounded,
                    color: Colors.grey.shade600,
                  ),
                ),
                onTap: onChangeBarrier,
                onChanged: _validateStorePhoneNumber,
                onFieldSubmitted: _onFieldSubmitted,
              ),
            ),
            // if (false)
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
        Gaps.v10,
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: TextFormField(
                controller: _storePhoneNumberController,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  labelText: '가게 전화번호',
                  errorText: _storePhoneNumberErrorText,
                  prefixIcon: Icon(
                    Icons.phone_iphone_rounded,
                    color: Colors.grey.shade600,
                  ),
                ),
                onTap: onChangeBarrier,
                onChanged: _validateStorePhoneNumber,
                onFieldSubmitted: _onFieldSubmitted,
              ),
            ),
            // if (false)
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
        Gaps.v10,
        // if (false)
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: TextFormField(
                controller: _storePhoneNumberAuthController,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  labelText: '인증 코드',
                  errorText: _storePhoneNumberAuthErrorText,
                  prefixIcon: Icon(
                    Icons.phonelink_lock_outlined,
                    color: Colors.grey.shade600,
                  ),
                ),
                onTap: onChangeBarrier,
                onChanged: _validateStorePhoneNumberAuth,
                onFieldSubmitted: _onFieldSubmitted,
              ),
            ),
            ElevatedButton(
              onPressed: _onCheckAuthStoreCode,
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
        if (_storePhoneNumberAuth)
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
      ],
    );
  }
}
