import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:swag_marine_products/constants/gaps.dart';
import 'package:swag_marine_products/features/store/menu/store_menu_edit_screen.dart';
import 'package:swag_marine_products/features/store/navigation/menus/widgets/store_menu_card.dart';
import 'package:swag_marine_products/features/user/order/user_order_screen.dart';
import 'package:swag_marine_products/features/user/order/widgets/menu_card.dart';
import 'package:swag_marine_products/models/product_model.dart';

import 'package:http/http.dart' as http;
import 'package:swag_marine_products/widget_tools/swag_platform_dialog.dart';

class StoreMenuScreen extends StatefulWidget {
  const StoreMenuScreen({super.key});

  @override
  State<StoreMenuScreen> createState() => _StoreMenuScreenState();
}

class _StoreMenuScreenState extends State<StoreMenuScreen> {
  List<ProductModel>? _productList;

  final bool _isFavorited = false;
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              SliverAppBar(
                centerTitle: true,
                floating: true,
                snap: true,
                backgroundColor: Colors.blue.shade50,
                surfaceTintColor: Colors.transparent,
                title: const Text("메뉴"),
                actions: [
                  IconButton(
                    onPressed: () {
                      context.pushNamed(
                        StoreMenuEditScreen.routeName,
                        extra: const StoreMenuEditScreenArgs(
                          editType: EditType.add,
                        ),
                      );
                    },
                    icon: const Icon(
                      Icons.add_rounded,
                      size: 40,
                    ),
                  ),
                ],
              ),
              SliverToBoxAdapter(
                child: Image.asset(
                  "assets/images/fishShop.png",
                  width: MediaQuery.of(context).size.width,
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
                  child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ListTile(
                        contentPadding: EdgeInsets.only(left: 10),
                        title: Text(
                          "가게 이름",
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Text(
                        "전화번호 : 010-0000-0000",
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                      Text(
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
                : ListView.separated(
                    // padding: const EdgeInsets.symmetric(horizontal: 10),
                    itemCount: 10,
                    separatorBuilder: (context, index) => Gaps.v6,
                    itemBuilder: (context, index) {
                      String image;
                      if (index % 3 == 0) {
                        image = "assets/images/fish3.png";
                      } else if (index % 2 == 0) {
                        image = "assets/images/fish2.png";
                      } else {
                        image = "assets/images/fish.png";
                      }
                      return StoreMenuCard(image: image);
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
