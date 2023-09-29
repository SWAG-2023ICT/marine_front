import 'package:flutter/material.dart';

class UserGraphScreen extends StatefulWidget {
  const UserGraphScreen({Key? key}) : super(key: key);

  @override
  State<UserGraphScreen> createState() => _UserGraphScreenState();
}

class _UserGraphScreenState extends State<UserGraphScreen> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text("통계 그래프"),
    );
  }
}
