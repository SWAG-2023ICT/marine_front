// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:swag_marine_products/features/sign_in_up/widgets/sign_up_first.dart';
import 'package:swag_marine_products/features/sign_in_up/widgets/sign_up_second.dart';

class SignUpScreenArgs {
  const SignUpScreenArgs({
    required this.isStored,
  });

  final bool isStored;
}

class SignUpScreen extends StatefulWidget {
  static const routeName = "signUp";
  static const routeURL = "/signUp";
  const SignUpScreen({
    super.key,
    this.isStored = false,
  });

  final bool isStored;

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool _isStored = false;
  int selectedIndex = 0;

  void _onTap(int index) {
    if (selectedIndex == index) return;
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    _isStored = widget.isStored;
  }

  @override
  Widget build(BuildContext context) {
    FocusScope.of(context).requestFocus(FocusNode());
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          centerTitle: true,
          automaticallyImplyLeading: false,
          title: const Text("회원가입"),
        ),
        body: Stack(
          children: [
            // 실제로 그 화면을 보고 있지 않더라도 랜더링 시켜주는 위젯
            Offstage(
              offstage: selectedIndex != 0,
              child: SignUpFirst(
                isStored: _isStored,
                onChangeUser: () {
                  setState(() {
                    _isStored = false;
                  });
                },
                onChangeStore: () {
                  setState(() {
                    _isStored = true;
                  });
                },
                onNextPage: () {
                  setState(() {
                    _onTap(1);
                  });
                },
              ),
            ),
            Offstage(
              offstage: selectedIndex != 1,
              //child: const SearchVolScreen(),
              child: SignUpSecond(
                onBeforePage: () {
                  setState(() {
                    _onTap(0);
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
