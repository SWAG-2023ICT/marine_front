import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:swag_marine_products/constants/gaps.dart';
import 'package:swag_marine_products/constants/http_ip.dart';
import 'package:swag_marine_products/constants/sizes.dart';
import 'package:swag_marine_products/models/store_api_model.dart';

import 'package:http/http.dart' as http;
import 'package:swag_marine_products/features/user/navigation/menus/widgets/store_api_card.dart';

class UserPriceScreen extends StatefulWidget {
  const UserPriceScreen({Key? key}) : super(key: key);

  @override
  State<UserPriceScreen> createState() => _UserPriceScreenState();
}

class _UserPriceScreenState extends State<UserPriceScreen> {
  final TextEditingController _searchController = TextEditingController();

  List<StoreAPIModel>? _productsList;

  final bool _isFirstLoadRunning = true;
  final bool _isLoadMoreRunning = false;
  bool _isBarriered = false;

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
            jsonResponse.map((data) => StoreAPIModel.fromJson(data)).toList();
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
  void dispose() {
    _searchController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
              // SliverToBoxAdapter(
              //   child: Container(
              //     padding: const EdgeInsets.symmetric(
              //       vertical: Sizes.size10,
              //       horizontal: Sizes.size14,
              //     ),
              //     child: const Column(
              //       crossAxisAlignment: CrossAxisAlignment.center,
              //       children: [
              //         Text(
              //           "도매시장 가격",
              //           style: TextStyle(
              //             fontSize: 26,
              //           ),
              //         ),
              //         // RadioactivityBanner(),
              //         // Container(
              //         //   child: const Column(
              //         //     children: [
              //         //       Text(
              //         //         "오늘의 최저 가격! Top5!",
              //         //         style: TextStyle(
              //         //           fontSize: 16,
              //         //           fontWeight: FontWeight.bold,
              //         //         ),
              //         //       ),
              //         //     ],
              //         //   ),
              //         // ),
              //       ],
              //     ),
              //   ),
              // ),
              SliverAppBar(
                automaticallyImplyLeading: false,
                centerTitle: true,
                pinned: true,
                // floating: true,
                // snap: true,
                surfaceTintColor: Colors.white,
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
                    onPressed: () {},
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
              )
            ],
            body: Stack(
              children: [
                ListView.separated(
                  padding: const EdgeInsets.symmetric(
                    vertical: Sizes.size10,
                    horizontal: Sizes.size20,
                  ),
                  itemBuilder: (context, index) => StoreAPICard(
                      marineProduct: StoreAPIModel(
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
          ),
        ],
      ),
    );
  }
}
