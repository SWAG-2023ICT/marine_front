import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:swag_marine_products/constants/gaps.dart';
import 'package:swag_marine_products/constants/http_ip.dart';
import 'package:swag_marine_products/features/store/menu/store_menu_edit_screen.dart';
import 'package:swag_marine_products/features/store/navigation/menus/widgets/store_menu_card.dart';
import 'package:swag_marine_products/features/user/order/user_order_screen.dart';
import 'package:swag_marine_products/features/user/order/widgets/menu_card.dart';
import 'package:swag_marine_products/models/database/product_model.dart';

import 'package:http/http.dart' as http;
import 'package:swag_marine_products/models/database/store_model.dart';
import 'package:swag_marine_products/providers/store_provider.dart';
import 'package:swag_marine_products/widget_tools/swag_platform_dialog.dart';

class StoreMenuScreen extends StatefulWidget {
  const StoreMenuScreen({
    super.key,
    required this.storeData,
  });

  final StoreModel storeData;

  @override
  State<StoreMenuScreen> createState() => _StoreMenuScreenState();
}

class _StoreMenuScreenState extends State<StoreMenuScreen> {
  StoreModel? _storeData;
  bool _isFirstLoading = false;

  @override
  void initState() {
    super.initState();

    // _storeData = widget.storeData;
    // print(_storeData);

    _initStoreData();
  }

  void _initStoreData() async {
    setState(() {
      _isFirstLoading = true;
    });

    // --------------- 가게 정보 호출 ---------------
    final url = Uri.parse(
        "${HttpIp.httpIp}/marine/stores/${context.read<StoreProvider>().storeId}");
    final headers = {'Content-Type': 'application/json'};
    final response = await http.get(url, headers: headers);

    if (response.statusCode >= 200 && response.statusCode < 300) {
      print("가게 정보 조회 : 성공");

      final jsonResponse = jsonDecode(response.body) as Map<String, dynamic>;

      setState(() {
        _storeData = StoreModel.fromJson(jsonResponse);
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
      _isFirstLoading = false;
    });
  }

  Future<void> _onRefresh() async {
    _initStoreData();
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
          _isFirstLoading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : NestedScrollView(
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
                          onPressed: () async {
                            await context.pushNamed(
                              StoreMenuEditScreen.routeName,
                              extra: const StoreMenuEditScreenArgs(
                                editType: EditType.add,
                              ),
                            );

                            _initStoreData();
                          },
                          icon: const Icon(
                            Icons.add_rounded,
                            size: 40,
                          ),
                        ),
                      ],
                    ),
                    SliverToBoxAdapter(
                      child: Image.memory(
                        widget.storeData.storeImage!,
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
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ListTile(
                              contentPadding: const EdgeInsets.only(left: 10),
                              title: Text(
                                _storeData!.storeName,
                                style: const TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Text(
                              "전화번호 : ${_storeData!.storePhoneNumber}",
                              style: const TextStyle(
                                fontSize: 16,
                              ),
                            ),
                            Text(
                              "주소 : ${_storeData!.storeAddress}",
                              style: const TextStyle(
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                  body: RefreshIndicator.adaptive(
                    onRefresh: _onRefresh,
                    child: ListView.separated(
                      // padding: const EdgeInsets.symmetric(horizontal: 10),
                      itemCount: _storeData!.products!.length,
                      separatorBuilder: (context, index) => Gaps.v6,
                      itemBuilder: (context, index) {
                        return StoreMenuCard(
                          productData: _storeData!.products![index],
                          initStoreData: _initStoreData,
                        );
                      },
                    ),
                  ),
                ),
        ],
      ),
    );
  }
}
