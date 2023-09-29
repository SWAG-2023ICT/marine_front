import 'package:flutter/material.dart';

class MarineSettingScreen extends StatefulWidget {
  const MarineSettingScreen({super.key});

  @override
  State<MarineSettingScreen> createState() => _MarineSettingScreenState();
}

class _MarineSettingScreenState extends State<MarineSettingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("프로필"),
      ),
    );
  }
}
