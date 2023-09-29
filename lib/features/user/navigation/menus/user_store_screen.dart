import 'package:flutter/material.dart';

class UserStoreScreen extends StatefulWidget {
  const UserStoreScreen({super.key});

  @override
  State<UserStoreScreen> createState() => _UserStoreScreenState();
}

class _UserStoreScreenState extends State<UserStoreScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Mariner"),
      ),
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          SliverToBoxAdapter(
            child: Container(),
          ),
        ],
        body: ListView(),
      ),
    );
  }
}
