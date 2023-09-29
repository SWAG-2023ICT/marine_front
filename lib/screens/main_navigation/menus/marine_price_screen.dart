import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:swag_marine_products/constants/gaps.dart';
import 'package:swag_marine_products/constants/http_ip.dart';
import 'package:swag_marine_products/constants/sizes.dart';
import 'package:swag_marine_products/models/marine_product.dart';

import 'package:http/http.dart' as http;
import 'package:swag_marine_products/screens/main_navigation/menus/widgets/marine_product_card.dart';
import 'package:swag_marine_products/screens/main_navigation/menus/widgets/radioactivity_banner.dart';

class MarinePriceScreen extends StatefulWidget {
  const MarinePriceScreen({Key? key}) : super(key: key);

  @override
  State<MarinePriceScreen> createState() => _MarinePriceScreenState();
}

class _MarinePriceScreenState extends State<MarinePriceScreen> {
  List<MarineProduct>? _productsList;

  final bool _isFirstLoadRunning = true;
  final bool _isLoadMoreRunning = false;

  Future<void> dispatchProductsList() async {
    final url = Uri.parse("${HttpIp.httpIp}/together/login");
    final headers = {'Content-Type': 'application/json'};
    // final data = {"userEmail": loginData};

    final response = await http.get(url, headers: headers);

    if (!mounted) return;
    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body) as List<dynamic>;

      setState(() {
        _productsList =
            jsonResponse.map((data) => MarineProduct.fromJson(data)).toList();
      });
    } else {
      HttpIp.errorPrint(
        context: context,
        title: "수산물 호출 요류",
        message: "수산물 가격 목록을 불러오는데 실패했습니다!",
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            // 배경 하늘 이미지
            // Opacity(
            //   opacity: 0.6,
            //   child: Image.asset(
            //     "assets/images/sky.png",
            //     fit: BoxFit.cover,
            //     width: MediaQuery.of(context).size.width,
            //     height: 300,
            //   ),
            // ),
            // 배경 바다 이미지
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
                SliverToBoxAdapter(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: Sizes.size10,
                      horizontal: Sizes.size14,
                    ),
                    child: const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        RadioactivityBanner(),
                        // Container(
                        //   child: const Column(
                        //     children: [
                        //       Text(
                        //         "오늘의 최저 가격! Top5!",
                        //         style: TextStyle(
                        //           fontSize: 16,
                        //           fontWeight: FontWeight.bold,
                        //         ),
                        //       ),
                        //     ],
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                ),
              ],
              body: ListView.separated(
                padding: const EdgeInsets.symmetric(
                  vertical: Sizes.size10,
                  horizontal: Sizes.size20,
                ),
                itemBuilder: (context, index) => MarineProductCard(
                    marineProduct: MarineProduct(
                      dates: "경매일",
                      mClassName: "품목",
                      sClassName: "품종",
                      gradeName: "등급",
                      avgPrice: 15000,
                      maxPrice: 20000,
                      minPrice: 10000,
                      sumAmt: 20,
                      marketName: "도매시장",
                      coName: "도매법인",
                    ),
                    index: index),
                separatorBuilder: (context, index) => Gaps.v10,
                itemCount: 20,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
