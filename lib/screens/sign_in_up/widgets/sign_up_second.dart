import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:swag_marine_products/constants/gaps.dart';
import 'package:swag_marine_products/screens/sign_in_up/widgets/bottom_button.dart';

class SignUpSecond extends StatefulWidget {
  const SignUpSecond({
    Key? key,
    required this.onBeforePage,
  }) : super(key: key);

  final Function onBeforePage;

  @override
  State<SignUpSecond> createState() => _SignUpSecondState();
}

class _SignUpSecondState extends State<SignUpSecond> {
  bool rule1 = false;
  bool rule2 = false;

  Future<void> _handleRegistration() async {
    // 여기에서 서버로 회원가입 정보를 전송하고 결과를 처리하는 로직을 구현합니다.
    // 이 부분은 실제 서버와 통신하여 데이터베이스에 정보를 저장하거나 중복 확인 등을 수행하는 곳입니다.
    // 서버 측에서 결과를 반환하면 클라이언트에서 해당 결과를 처리할 수 있습니다.
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            // 약관 내용을 표시하는 부분을 추가하세요.
            // const ListTile(
            //   title: Text("악관1"),
            // ),
            Expanded(
              child: Container(
                width: size.width,
                decoration: BoxDecoration(
                  border: Border.all(width: 1),
                ),
                child: const Text(
                  '약관 내용을 여기에 표시하세요.',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
            Gaps.v20,
            CheckboxListTile(
              title: const Text('약관에 동의합니다.'),
              value: rule1, // 사용자가 체크하면 true로 변경
              onChanged: (value) {
                setState(() {
                  rule1 = !rule1;
                });
              },
            ),
            const Divider(),
            Gaps.v10,
            // const ListTile(
            //   title: Text("악관2"),
            // ),
            // 약관 내용을 표시하는 부분을 추가하세요.
            Expanded(
              child: Container(
                width: size.width,
                decoration: BoxDecoration(
                  border: Border.all(width: 1),
                ),
                child: const Text(
                  '약관 내용을 여기에 표시하세요.',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
            Gaps.v20,
            CheckboxListTile(
              title: const Text('약관에 동의합니다.'),
              value: rule2, // 사용자가 체크하면 true로 변경
              onChanged: (value) {
                setState(() {
                  rule2 = !rule2;
                });
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(
          vertical: 16,
          horizontal: 10,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            BottomButton(
              onPressed: () => widget.onBeforePage(),
              text: "이전",
            ),
            Gaps.h10,
            BottomButton(
              onPressed: rule1 && rule2
                  ? () async {
                      await _handleRegistration();
                      if (!mounted) return;
                      context.pop();
                    }
                  : null,
              text: "회원가입",
            ),
          ],
        ),
      ),
    );
  }
}
