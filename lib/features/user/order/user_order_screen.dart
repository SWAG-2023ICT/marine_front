import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:swag_marine_products/constants/gaps.dart';
import 'package:swag_marine_products/constants/http_ip.dart';
import 'package:swag_marine_products/features/user/order/user_order_sheet.dart';
import 'package:swag_marine_products/features/user/order/widgets/menu_card.dart';
import 'package:swag_marine_products/models/product_model.dart';
import 'package:swag_marine_products/widget_tools/swag_platform_dialog.dart';

import 'package:http/http.dart' as http;

class UserOrderScreen extends StatefulWidget {
  static const routeName = "user_order";
  static const routeURL = "user_order";
  const UserOrderScreen({super.key});

  @override
  State<UserOrderScreen> createState() => _UserOrderScreenState();
}

class _UserOrderScreenState extends State<UserOrderScreen> {
  List<ProductModel>? _productList;

  bool _isFavorited = false;
  bool _isFirstLoading = false;

  @override
  void initState() {
    super.initState();

    // _initBannerData();
  }

  void _initBannerData() async {
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
    _initBannerData();
  }

  void _onClickFavorite() {
    setState(() {
      _isFavorited = !_isFavorited;
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Opacity(
              opacity: 0.6,
              child: Image.asset(
                "assets/images/sea4.png",
                fit: BoxFit.cover,
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
              ),
            ),
            NestedScrollView(
              headerSliverBuilder: (context, innerBoxIsScrolled) => [
                const SliverAppBar(
                  pinned: true,
                  backgroundColor: Colors.transparent,
                  surfaceTintColor: Colors.transparent,
                ),
                SliverToBoxAdapter(
                  child: Image.asset(
                    "assets/images/fishShop.png",
                    width: size.width,
                    height: 250,
                    fit: BoxFit.fitHeight,
                  ),
                ),
                SliverToBoxAdapter(
                  child: Container(
                    margin: const EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 50,
                    ),
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: const BorderRadius.all(
                        Radius.circular(10),
                      ),
                      boxShadow: [
                        BoxShadow(
                          offset: const Offset(1.5, 1.5),
                          blurRadius: 1,
                          color: Colors.grey.shade400,
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ListTile(
                          contentPadding: const EdgeInsets.only(left: 10),
                          title: const Text(
                            "가게 이름",
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          trailing: IconButton(
                            onPressed: _onClickFavorite,
                            icon: _isFavorited
                                ? const Icon(
                                    Icons.favorite,
                                    size: 30,
                                    color: Colors.red,
                                  )
                                : const Icon(
                                    Icons.favorite_outline,
                                    size: 30,
                                  ),
                          ),
                        ),
                        const Text(
                          "전화번호 : 010-0000-0000",
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                        const Text(
                          "주소 : 진주시 가좌동",
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
              body: _isFirstLoading
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : Container(
                      decoration: const BoxDecoration(
                        border: Border(
                          top: BorderSide(
                            color: Colors.black54,
                          ),
                        ),
                      ),
                      child: RefreshIndicator.adaptive(
                        onRefresh: _onRefresh,
                        child: ListView.separated(
                          // padding: const EdgeInsets.symmetric(horizontal: 10),
                          itemCount: 20,
                          separatorBuilder: (context, index) => const Divider(
                            height: 0,
                            color: Colors.black54,
                          ),
                          itemBuilder: (context, index) {
                            String image;
                            if (index % 3 == 0) {
                              image = "assets/images/fish3.png";
                            } else if (index % 2 == 0) {
                              image = "assets/images/fish2.png";
                            } else {
                              image = "assets/images/fish.png";
                            }
                            return MenuCard(image: image);
                          },
                        ),
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
