import 'package:flutter/material.dart';

class UserOrderSheet extends StatefulWidget {
  const UserOrderSheet({super.key});

  @override
  State<UserOrderSheet> createState() => _UserOrderSheetState();
}

class _UserOrderSheetState extends State<UserOrderSheet> {
  String _radioValue = "";

  void _onChangePrice(String? changeValue) {
    if (changeValue == null) return;
    setState(() {
      _radioValue = changeValue;
    });
  }

  void _onOrderTap() {}

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SizedBox(
      height: size.height * 0.8,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("주문"),
        ),
        bottomNavigationBar: Container(
          margin: const EdgeInsets.symmetric(vertical: 10),
          child: ElevatedButton(
            onPressed: _onOrderTap,
            child: const Text("주문하기"),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Image.asset(
                  "assets/images/fish.png",
                  width: size.width,
                  height: 250,
                ),
              ),
              SliverList.builder(
                itemCount: 5,
                itemBuilder: (context, index) => RadioListTile.adaptive(
                  value: "가격 ${index + 1}",
                  groupValue: _radioValue,
                  onChanged: _onChangePrice,
                  title: Text("가격 ${index + 1}"),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
