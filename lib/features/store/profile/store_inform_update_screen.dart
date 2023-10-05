import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:kpostal/kpostal.dart';
import 'package:swag_marine_products/constants/gaps.dart';
import 'package:swag_marine_products/features/sign_in_up/widgets/bottom_button.dart';
import 'package:swag_marine_products/widget_tools/swag_platform_dialog.dart';

enum UpdateType {
  storeName,
  storeAddress,
  storePhoneNumber,
}

class StoreInformUpdateScreenArgs {
  const StoreInformUpdateScreenArgs({required this.updateType});

  final UpdateType updateType;
}

class StoreInformUpdateScreen extends StatefulWidget {
  static const routeName = "store_inform_update";
  static const routeURL = "store_inform_update";
  const StoreInformUpdateScreen({
    super.key,
    required this.updateType,
  });

  final UpdateType updateType;

  @override
  State<StoreInformUpdateScreen> createState() =>
      _StoreInformUpdateScreenState();
}

class _StoreInformUpdateScreenState extends State<StoreInformUpdateScreen> {
  bool _isSubmitted = false;
  bool _isBarrier = false;

  // 비밀번호 정규식
  final RegExp _passwordRegExp =
      RegExp(r'^(?=.*[A-Z])(?=.*\d)(?=.*[\W_])[A-Za-z\d\W_]{8,}$');

  // 전화번호 정규식
  final RegExp _phoneNumberRegExp = RegExp(
      r'^(02|0[3-9][0-9]{1,2})-[0-9]{3,4}-[0-9]{4}$|^(02|0[3-9][0-9]{1,2})[0-9]{7,8}$|^01[0-9]{9}$|^070-[0-9]{4}-[0-9]{4}$|^070[0-9]{8}$');

  void _onCheckSubmitted() {
    if (widget.updateType == UpdateType.storeName) {
      setState(() {
        _isSubmitted = (_storeBusinessNameController.text.trim().isNotEmpty &&
                _storeBusinessNameErrorText == null) &&
            (_storePasswordController.text.trim().isNotEmpty &&
                _storePasswordErrorText == null);
      });
    } else if (widget.updateType == UpdateType.storeAddress) {
      setState(() {
        _isSubmitted = _storeAddressController.text.trim().isNotEmpty &&
            (_storePasswordController.text.trim().isNotEmpty &&
                _storePasswordErrorText == null);
      });
    } else if (widget.updateType == UpdateType.storePhoneNumber) {
      setState(() {
        _isSubmitted =
            (_storeBusinessPhoneNumberController.text.trim().isNotEmpty &&
                    _storeBusinessPhoneNumberErrorText == null) &&
                (_storePasswordController.text.trim().isNotEmpty &&
                    _storePasswordErrorText == null);
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

  void _onSubmitted() {
    if (widget.updateType == UpdateType.storeName) {
      print("변경 가게 이름 : ${_storeBusinessNameController.text}");
    } else if (widget.updateType == UpdateType.storeAddress) {
      print(
          "변경 가게 주소 : ${_storeAddressController.text}, ${_storeAddressDetailController.text}");
    } else if (widget.updateType == UpdateType.storePhoneNumber) {
      print("변경 가게 전화번호 : ${_storeBusinessPhoneNumberController.text}");
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

  // ----------------------- 공통 -----------------------
  final TextEditingController _storePasswordController =
      TextEditingController(); // pw

  String? _storePasswordErrorText;

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

  // ----------------------- 가게 이름 수정 -----------------------
  final TextEditingController _storeBusinessNameController =
      TextEditingController(); // 가게 이름

  String? _storeBusinessNameErrorText;

  void _validateStoreBusinessName(String value) {
    if (value.isEmpty) {
      setState(() {
        _storeBusinessNameErrorText = '가게명을 입력하세요.';
      });
    } else {
      setState(() {
        _storeBusinessNameErrorText = null;
      });
      _onCheckSubmitted();
    }
  }

  // ----------------------- 가게 주소 수정 -----------------------
  final TextEditingController _storeAddressController =
      TextEditingController(); // 가게 주소
  final TextEditingController _storeAddressDetailController =
      TextEditingController(); // 가게 상세 주소

  void _onSearchStoreAddress() async {
    Kpostal? result = await Navigator.push(
        context, MaterialPageRoute(builder: (_) => KpostalView()));
    if (result != null) {
      print(result.address);
      setState(() {
        _storeAddressController.text = result.address;
      });
      _onCheckSubmitted();
    }
  }

  // ----------------------- 가게 전화번호 수정 -----------------------
  final TextEditingController _storeBusinessPhoneNumberController =
      TextEditingController(); // 가게 전화번호

  String? _storeBusinessPhoneNumberErrorText;

  void _validateStoreBusinessPhoneNumber(String value) {
    if (value.isEmpty) {
      setState(() {
        _storeBusinessPhoneNumberErrorText = '전화번호를 입력하세요.';
      });
    } else if (!_phoneNumberRegExp.hasMatch(value)) {
      setState(() {
        _storeBusinessPhoneNumberErrorText = "전화번호 규칙에 맞게 입력하세요.";
      });
    } else {
      setState(() {
        _storeBusinessPhoneNumberErrorText = null;
      });
      _onCheckSubmitted();
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: _updateInfo(),
    );
  }

  Widget _updateInfo() {
    if (widget.updateType == UpdateType.storeName) {
      return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text("가게 이름 수정"),
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
                  controller: _storeBusinessNameController,
                  keyboardType: TextInputType.name,
                  decoration: InputDecoration(
                    labelText: '가게 이름',
                    errorText: _storeBusinessNameErrorText,
                    prefixIcon: Icon(
                      Icons.store,
                      color: Colors.grey.shade600,
                    ),
                  ),
                  onTap: onChangeBarrier,
                  onChanged: _validateStoreBusinessName,
                  onFieldSubmitted: _onFieldSubmitted,
                ),
                Gaps.v10,
                TextFormField(
                  controller: _storePasswordController,
                  decoration: InputDecoration(
                    labelText: '현재 비밀번호',
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
    } else if (widget.updateType == UpdateType.storeAddress) {
      return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text("가게 주소 수정"),
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
                        controller: _storeAddressController,
                        readOnly: true,
                        decoration: InputDecoration(
                          labelText: '가게 주소',
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
                    labelText: '가게 주소 상세 정보',
                    prefixIcon: Icon(
                      Icons.add_home_work_outlined,
                      color: Colors.grey.shade600,
                    ),
                  ),
                  onTap: onChangeBarrier,
                  onFieldSubmitted: _onFieldSubmitted,
                ),
                Gaps.v10,
                TextFormField(
                  controller: _storePasswordController,
                  decoration: InputDecoration(
                    labelText: '현재 비밀번호',
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
    } else if (widget.updateType == UpdateType.storePhoneNumber) {
      return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text("가게 전화번호 수정"),
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
                        controller: _storeBusinessPhoneNumberController,
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(
                          labelText: '가게 전화번호',
                          errorText: _storeBusinessPhoneNumberErrorText,
                          prefixIcon: Icon(
                            Icons.local_phone_outlined,
                            color: Colors.grey.shade600,
                          ),
                        ),
                        onTap: onChangeBarrier,
                        onChanged: _validateStoreBusinessPhoneNumber,
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
                Gaps.v10,
                TextFormField(
                  controller: _storePasswordController,
                  decoration: InputDecoration(
                    labelText: '현재 비밀번호',
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
