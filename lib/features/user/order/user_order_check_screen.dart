import 'package:flutter/material.dart';

class UserOrderCheckScreen extends StatefulWidget {
  const UserOrderCheckScreen({super.key});

  @override
  State<UserOrderCheckScreen> createState() => _UserOrderCheckScreenState();
}

class _UserOrderCheckScreenState extends State<UserOrderCheckScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("주문 내역"),
      ),
    );
  }
}
