import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:swag_marine_products/constants/gaps.dart';
import 'package:swag_marine_products/constants/http_ip.dart';
import 'package:swag_marine_products/features/user/navigation/menus/widgets/store_card.dart';
import 'package:swag_marine_products/models/product_model.dart';

import 'package:http/http.dart' as http;
import 'package:swag_marine_products/widget_tools/swag_platform_dialog.dart';

class UserBookMarkScreen extends StatefulWidget {
  static const routeName = "bookmark";
  static const routeURL = "bookmark";
  const UserBookMarkScreen({super.key});

  @override
  State<UserBookMarkScreen> createState() => _UserBookMarkScreenState();
}

class _UserBookMarkScreenState extends State<UserBookMarkScreen> {
  ProductModel? _bookmarkList;

  bool _isFirtstLoading = false;

  @override
  void initState() {
    super.initState();

    // _initBookmarkList();
  }

  Future<void> _initBookmarkList() async {
    setState(() {
      _isFirtstLoading = true;
    });

    if (false) {
      final url = Uri.parse("${HttpIp.httpIp}/");
      final headers = {'Content-Type': 'application/json'};
      final data = {};
      final response =
          await http.post(url, headers: headers, body: jsonEncode(data));

      if (response.statusCode >= 200 && response.statusCode < 300) {
      } else {
        if (!mounted) return;
        HttpIp.errorPrint(
          context: context,
          title: "통신 오류",
          message: response.body,
        );
      }
    }

    setState(() {
      _isFirtstLoading = false;
    });
  }

  Future<void> _onRefresh() async {
    await _initBookmarkList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.blue.shade50,
        title: const Text("즐겨찾기"),
      ),
      body: Stack(
        children: [
          Opacity(
            opacity: 0.5,
            child: Image.asset(
              "assets/images/sea4.png",
              fit: BoxFit.cover,
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
            ),
          ),
          _isFirtstLoading
              ? const Center(
                  child: CircularProgressIndicator.adaptive(),
                )
              : RefreshIndicator.adaptive(
                  onRefresh: _onRefresh,
                  child: ListView.builder(
                    itemCount: 5,
                    itemBuilder: (context, index) {
                      return const StoreCard();
                    },
                  ),
                ),
        ],
      ),
    );
  }
}
