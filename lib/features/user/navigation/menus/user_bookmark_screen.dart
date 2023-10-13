import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:swag_marine_products/constants/gaps.dart';
import 'package:swag_marine_products/constants/http_ip.dart';
import 'package:swag_marine_products/features/user/navigation/menus/widgets/store_card.dart';
import 'package:swag_marine_products/models/database/product_model.dart';

import 'package:http/http.dart' as http;
import 'package:swag_marine_products/models/database/store_model.dart';
import 'package:swag_marine_products/providers/user_provider.dart';
import 'package:swag_marine_products/widget_tools/swag_platform_dialog.dart';

class UserBookMarkScreen extends StatefulWidget {
  static const routeName = "bookmark";
  static const routeURL = "bookmark";
  const UserBookMarkScreen({super.key});

  @override
  State<UserBookMarkScreen> createState() => _UserBookMarkScreenState();
}

class _UserBookMarkScreenState extends State<UserBookMarkScreen> {
  List<StoreModel>? _storeList;

  bool _isFirtstLoading = false;

  @override
  void initState() {
    super.initState();

    _initBookmarkList();
  }

  Future<void> _initBookmarkList() async {
    setState(() {
      _isFirtstLoading = true;
    });

    final url = Uri.parse(
        "${HttpIp.httpIp}/marine/users/wish/${context.read<UserProvider>().userData!.userId}");
    final headers = {'Content-Type': 'application/json'};
    final response = await http.get(url, headers: headers);

    if (response.statusCode >= 200 && response.statusCode < 300) {
      print("북마크 리스트 호출 : 성공");
      final jsonResponse = jsonDecode(response.body) as List<dynamic>;

      setState(() {
        _storeList =
            jsonResponse.map((data) => StoreModel.fromJson(data)).toList();
      });
    } else {
      if (!mounted) return;
      HttpIp.errorPrint(
        context: context,
        title: "통신 오류",
        message: response.body,
      );
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
              : _storeList == null || _storeList!.isEmpty
                  ? Center(
                      child: IconButton(
                        iconSize: MediaQuery.of(context).size.width / 3,
                        color: Colors.grey.shade400,
                        icon: const Icon(Icons.refresh_outlined),
                        onPressed: _onRefresh,
                      ),
                    )
                  : RefreshIndicator.adaptive(
                      onRefresh: _onRefresh,
                      child: ListView.builder(
                        itemCount: _storeList!.length,
                        itemBuilder: (context, index) {
                          return StoreCard(
                            storeData: _storeList![index],
                          );
                        },
                      ),
                    ),
        ],
      ),
    );
  }
}
