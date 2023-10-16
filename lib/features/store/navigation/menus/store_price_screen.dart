import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:swag_marine_products/constants/gaps.dart';
import 'package:swag_marine_products/constants/http_ip.dart';
import 'package:swag_marine_products/constants/sizes.dart';
import 'package:swag_marine_products/features/store/navigation/menus/widgets/store_price_card.dart';
import 'package:swag_marine_products/models/market_price_model.dart';

import 'package:http/http.dart' as http;

class StorePriceScreen extends StatefulWidget {
  const StorePriceScreen({Key? key}) : super(key: key);

  @override
  State<StorePriceScreen> createState() => _StorePriceScreenState();
}

class _StorePriceScreenState extends State<StorePriceScreen> {
  final TextEditingController _searchController = TextEditingController();

  List<MarketPriceModel>? _marketPriceList;

  DateTime _searchDate = DateTime.now();

  bool _isFirstLoadRunning = true;
  bool _isBarriered = false;

  @override
  void initState() {
    super.initState();

    _dispatchProductsList();
  }

  Future<void> _dispatchProductsList() async {
    setState(() {
      _isFirstLoadRunning = true;
    });

    final url = Uri.parse(
        "http://211.237.50.150:7080/openapi/57db9237529880df58821d82a328cb7ecafae99a36a907422a7eb4d764e2feb1/json/Grid_20220818000000000621_1/1/1000?DATES=${DateFormat('yyyyMMdd').format(_searchDate)}");
    final headers = {'Content-Type': 'application/json'};
    final response = await http.get(url, headers: headers);

    if (response.statusCode >= 200 && response.statusCode < 300) {
      print("도매시장 리스트 호출 : 성공");
      final jsonResponse = jsonDecode(response.body) as Map<String, dynamic>;

      if ((jsonResponse["Grid_20220818000000000621_1"]["row"] as List)
          .isEmpty) {
        setState(() {
          _marketPriceList = [];
        });
      } else {
        setState(() {
          _marketPriceList = (jsonResponse["Grid_20220818000000000621_1"]["row"]
                  as List<dynamic>)
              .map((data) => MarketPriceModel.fromJson(data))
              .toList();
        });
      }
    } else {
      if (!mounted) return;
      HttpIp.errorPrint(
        context: context,
        title: "통신 오류",
        message: response.body,
      );
    }

    setState(() {
      _isFirstLoadRunning = false;
    });
  }

  Future<void> _onSearch() async {
    setState(() {
      _isFirstLoadRunning = true;
    });

    final url = Uri.parse(
        "http://211.237.50.150:7080/openapi/57db9237529880df58821d82a328cb7ecafae99a36a907422a7eb4d764e2feb1/json/Grid_20220818000000000621_1/1/1000?DATES=${DateFormat('yyyyMMdd').format(_searchDate)}&MCLASSNAME=${_searchController.text.trim()}");
    final headers = {'Content-Type': 'application/json'};
    final response = await http.get(url, headers: headers);

    if (response.statusCode >= 200 && response.statusCode < 300) {
      print("도매시장 리스트 검색 : 성공");
      final jsonResponse = jsonDecode(response.body) as Map<String, dynamic>;

      if ((jsonResponse["Grid_20220818000000000621_1"]["row"] as List)
          .isEmpty) {
        setState(() {
          _marketPriceList = [];
        });
      } else {
        setState(() {
          _marketPriceList = (jsonResponse["Grid_20220818000000000621_1"]["row"]
                  as List<dynamic>)
              .map((data) => MarketPriceModel.fromJson(data))
              .toList();
        });
      }
    } else {
      if (!mounted) return;
      HttpIp.errorPrint(
        context: context,
        title: "통신 오류",
        message: response.body,
      );
    }

    setState(() {
      _isFirstLoadRunning = false;
    });
  }

  Future<void> _onRefresh() async {
    _dispatchProductsList();
  }

  @override
  void dispose() {
    _searchController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Stack(
          children: [
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
                SliverAppBar(
                  automaticallyImplyLeading: false,
                  centerTitle: true,
                  pinned: true,
                  // floating: true,
                  // snap: true,
                  surfaceTintColor: Colors.transparent,
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
                      hintText: "찾으려는 품목명을 입력해주세요.",
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
                  bottom: PreferredSize(
                    preferredSize: const Size.fromHeight(48),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(DateFormat('yyyy-MM-dd').format(_searchDate)),
                        ElevatedButton(
                          onPressed: () async {
                            final date = await showDatePicker(
                              context: context,
                              initialDate: _searchDate,
                              firstDate: DateTime.now()
                                  .subtract(const Duration(days: 365)),
                              lastDate: DateTime.now(),
                            );

                            if (date != null) {
                              setState(() {
                                _searchDate = date;
                              });
                              await _dispatchProductsList();
                            }
                          },
                          child: const Text("날짜 변경"),
                        )
                      ],
                    ),
                  ),
                )
              ],
              body: Stack(
                children: [
                  _isFirstLoadRunning
                      ? const Center(
                          child: CircularProgressIndicator.adaptive(),
                        )
                      : _marketPriceList == null
                          ? Center(
                              child: IconButton(
                                iconSize: MediaQuery.of(context).size.width / 3,
                                color: Colors.grey.shade400,
                                icon: const Icon(Icons.refresh_outlined),
                                onPressed: _onRefresh,
                              ),
                            )
                          : _marketPriceList!.isEmpty
                              ? Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      IconButton(
                                        iconSize:
                                            MediaQuery.of(context).size.width /
                                                3,
                                        color: Colors.grey.shade400,
                                        icon:
                                            const Icon(Icons.refresh_outlined),
                                        onPressed: _onRefresh,
                                      ),
                                      const Text(
                                        "해당 날짜에 진행된 도매가 존재하지 않습니다.",
                                        style: TextStyle(fontSize: 16),
                                      ),
                                    ],
                                  ),
                                )
                              : RefreshIndicator.adaptive(
                                  onRefresh: _onRefresh,
                                  child: ListView.separated(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: Sizes.size10,
                                      horizontal: Sizes.size20,
                                    ),
                                    itemBuilder: (context, index) {
                                      final item = _marketPriceList![index];
                                      return StorePriceCard(
                                        marineProduct: item,
                                        index: index,
                                      );
                                    },
                                    separatorBuilder: (context, index) =>
                                        Gaps.v10,
                                    itemCount: _marketPriceList!.length,
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
            ),
          ],
        ),
      ),
    );
  }
}
