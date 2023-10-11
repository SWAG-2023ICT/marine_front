import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:swag_marine_products/constants/gaps.dart';
import 'package:swag_marine_products/constants/http_ip.dart';
import 'package:swag_marine_products/features/user/home/widgets/radioactivity_banner.dart';
import 'package:swag_marine_products/features/user/navigation/menus/widgets/store_card.dart';
import 'package:swag_marine_products/features/user/order/user_order_screen.dart';

import 'package:http/http.dart' as http;

class UserStoreScreen extends StatefulWidget {
  const UserStoreScreen({super.key});

  @override
  State<UserStoreScreen> createState() => _UserStoreScreenState();
}

class _UserStoreScreenState extends State<UserStoreScreen> {
  final TextEditingController _searchController = TextEditingController();

  bool _isBarriered = false;
  bool _isFirstLoading = false;

  @override
  void initState() {
    super.initState();

    _initStoreList();
  }

  Future<void> _initStoreList() async {
    setState(() {
      _isFirstLoading = true;
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
      _isFirstLoading = false;
    });
  }

  Future<void> _onRefresh() async {
    _initStoreList();
  }

  Future<void> _onSearch() async {
    setState(() {
      _isFirstLoading = true;
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
      _isFirstLoading = false;
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      // appBar: AppBar(
      //   centerTitle: true,
      //   title: const Text("Mariner"),
      // ),
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
          NestedScrollView(
            headerSliverBuilder: (context, innerBoxIsScrolled) => [
              const SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: RadioactivityBanner(),
                ),
              ),
              SliverPadding(
                padding: const EdgeInsets.symmetric(
                  vertical: 6,
                ),
                sliver: SliverAppBar(
                  pinned: true,
                  backgroundColor: Colors.blue.shade50,
                  title: TextFormField(
                    controller: _searchController,
                    onTap: () {
                      setState(() {
                        _isBarriered = true;
                      });
                    },
                    decoration: const InputDecoration(
                      fillColor: Colors.white,
                      prefixIcon: Icon(Icons.search),
                    ),
                  ),
                  actions: [
                    ElevatedButton(
                      onPressed: _onSearch,
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.all(18),
                        textStyle: const TextStyle(fontSize: 14),
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                        ),
                      ),
                      child: const Text("검색"),
                    ),
                  ],
                ),
              )
            ],
            body: _isFirstLoading
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : RefreshIndicator.adaptive(
                    onRefresh: _onRefresh,
                    child: ListView.builder(
                      itemCount: 20,
                      itemBuilder: (context, index) => const StoreCard(),
                    ),
                  ),
          ),
          if (_isBarriered)
            ModalBarrier(
              // color: _barrierAnimation,
              color: Colors.transparent,
              // 자신을 클릭하면 onDismiss를 실행하는지에 대한 여부
              dismissible: true,
              // 자신을 클릭하면 실행되는 함수
              onDismiss: () {
                setState(() {
                  _isBarriered = false;
                  FocusScope.of(context).unfocus();
                });
              },
            ),
        ],
      ),
    );
  }
}
