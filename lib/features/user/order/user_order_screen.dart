import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:swag_marine_products/constants/gaps.dart';
import 'package:swag_marine_products/features/user/order/user_order_sheet.dart';
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
        message: "상품 리스트를 받아오지 못했습니다 ${response.statusCode} : ${response.body}",
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
      _isFirstLoading = false;
    });
  }

  void _onProductTap() async {
    showModalBottomSheet(
      context: context,
      builder: (context) => const UserOrderSheet(),
      useSafeArea: true,
      isScrollControlled: true,
    );
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
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                    child: const Column(
                      children: [
                        Text(
                          "가게 이름",
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "전화번호 : 010-0000-0000",
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          "주소 : 진주시 가좌동",
                          textAlign: TextAlign.start,
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
                  : ListView.separated(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
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
                        return GestureDetector(
                          onTap: _onProductTap,
                          child: Container(
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              // border: Border(
                              //   top: BorderSide(
                              //     width: 0.5,
                              //   ),
                              //   bottom: BorderSide(
                              //     width: 0.5,
                              //   ),
                              // ),
                            ),
                            child: Row(
                              children: [
                                const Expanded(
                                  child: Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 10),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "OOO물고기",
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Gaps.v6,
                                        Text(
                                          "최저 가격 : ",
                                          style: TextStyle(fontSize: 16),
                                        ),
                                        Text(
                                          "원산지 : ",
                                          style: TextStyle(fontSize: 16),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                Image.asset(
                                  image,
                                  width: 100,
                                  height: 100,
                                  fit: BoxFit.fill,
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
