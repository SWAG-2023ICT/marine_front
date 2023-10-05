import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:swag_marine_products/constants/gaps.dart';
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

    final url = Uri.parse("");
    final headers = {
      'Content-Type': 'application/json',
    };
    final data = {
      '': '',
    };

    final response = await http.post(url, body: data);

    if (response.statusCode >= 200 && response.statusCode < 300) {
      setState(() {
        // _productList = jsonResponse;
      });
    } else {
      if (!mounted) return;
      swagPlatformDialog(
        context: context,
        title: "통신 오류",
        message:
            "북마크 리스트를 받아오지 못했습니다 ${response.statusCode} : ${response.body}",
        actions: [
          TextButton(
            onPressed: () => context.pop(),
            child: const Text(
              "알겠습니다",
            ),
          ),
        ],
      );
    }

    setState(() {
      _isFirtstLoading = false;
    });
  }

  Future<void> _onRefresh() async {}

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
