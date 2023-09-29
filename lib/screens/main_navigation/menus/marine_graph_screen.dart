import 'package:flutter/material.dart';

class MarineGraphScreen extends StatefulWidget {
  const MarineGraphScreen({Key? key}) : super(key: key);

  @override
  State<MarineGraphScreen> createState() => _MarineGraphScreenState();
}

class _MarineGraphScreenState extends State<MarineGraphScreen> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text("통계 그래프"),
    );
  }
}
