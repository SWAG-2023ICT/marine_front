import 'package:flutter/material.dart';

class UserBookMarkScreen extends StatefulWidget {
  static const routeName = "bookmark";
  static const routeURL = "bookmark";
  const UserBookMarkScreen({super.key});

  @override
  State<UserBookMarkScreen> createState() => _UserBookMarkScreenState();
}

class _UserBookMarkScreenState extends State<UserBookMarkScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("즐겨찾기"),
      ),
      body: ListView(),
    );
  }
}
