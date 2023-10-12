import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:swag_marine_products/constants/gaps.dart';
import 'package:swag_marine_products/constants/http_ip.dart';
import 'package:swag_marine_products/models/database/order_model.dart';
import 'package:swag_marine_products/models/store_order_model.dart';
import 'package:swag_marine_products/providers/store_provider.dart';
import 'package:swag_marine_products/widget_tools/swag_platform_dialog.dart';

import 'package:http/http.dart' as http;

class StoreApplicationScreen extends StatefulWidget {
  const StoreApplicationScreen({super.key});

  @override
  State<StoreApplicationScreen> createState() => _StoreApplicationScreenState();
}

class _StoreApplicationScreenState extends State<StoreApplicationScreen> {
  bool _isFirstLoading = false;
  List<OrderModel>? _applicationList;

  @override
  void initState() {
    super.initState();

    _initDispatch();
  }

  Future<void> _initDispatch() async {
    setState(() {
      _isFirstLoading = true;
    });

    final url = Uri.parse(
        "${HttpIp.httpIp}/marine/orders/stores/${context.read<StoreProvider>().storeId}");
    final headers = {'Content-Type': 'application/json'};
    final response = await http.get(url, headers: headers);

    if (response.statusCode >= 200 && response.statusCode < 300) {
      print("신청 목록 호출 : 성공");
      print(response.body);
      final jsonResponse = jsonDecode(response.body) as List<dynamic>;

      final ordersList =
          jsonResponse.map((data) => OrderModel.fromJson(data)).toList();

      setState(() {
        _applicationList = ordersList
            .where((element) =>
                element.deliveryStatus == 1 && element.orderStatus != 3)
            .toList();
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

  Future<void> _refreshDispatch() async {
    _initDispatch();
  }

  Future<void> _onRequestAccept(int orderId) async {
    final url = Uri.parse("${HttpIp.httpIp}/marine/orders/cancel");
    final headers = {'Content-Type': 'application/json'};
    final data = {
      'ordersId': orderId,
      'orderStatus': 1,
    };
    final response =
        await http.post(url, headers: headers, body: jsonEncode(data));

    if (response.statusCode >= 200 && response.statusCode < 300) {
      print("주문 신청 수락 : 성공");

      _initDispatch();
    } else {
      if (!mounted) return;
      HttpIp.errorPrint(
        context: context,
        title: "통신 오류",
        message: response.body,
      );
    }
  }

  Future<void> _onRequestRefusal(int orderId) async {
    final url = Uri.parse("${HttpIp.httpIp}/marine/orders/cancel");
    final headers = {'Content-Type': 'application/json'};
    final data = {
      'ordersId': orderId,
      'orderStatus': 3,
    };
    final response =
        await http.post(url, headers: headers, body: jsonEncode(data));

    if (response.statusCode >= 200 && response.statusCode < 300) {
      print("주문 신청 거부 : 성공");

      _initDispatch();
    } else {
      if (!mounted) return;
      HttpIp.errorPrint(
        context: context,
        title: "통신 오류",
        message: response.body,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.blue.shade50,
        title: const Text("신청"),
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
          _isFirstLoading
              ? const Center(
                  child: CircularProgressIndicator.adaptive(),
                )
              : _applicationList == null
                  ? Center(
                      child: IconButton(
                        iconSize: MediaQuery.of(context).size.width / 3,
                        color: Colors.grey.shade400,
                        icon: const Icon(Icons.refresh_outlined),
                        onPressed: _refreshDispatch,
                      ),
                    )
                  : RefreshIndicator.adaptive(
                      onRefresh: _refreshDispatch,
                      child: ListView.builder(
                        itemCount: _applicationList!.length,
                        itemBuilder: (context, index) {
                          final item = _applicationList![index];
                          return Container(
                            margin: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 8,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(
                                width: 0.5,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  offset: const Offset(2, 2),
                                  blurRadius: 1,
                                  color: Colors.grey.shade400,
                                ),
                              ],
                            ),
                            child: ExpansionTile(
                              expandedCrossAxisAlignment:
                                  CrossAxisAlignment.start,
                              childrenPadding: const EdgeInsets.all(10),
                              title: Text(
                                "[주문] ${item.products[0].productName} ${item.products[0].prices[0].unit}",
                                style: const TextStyle(fontSize: 18),
                              ),
                              children: [
                                Text(
                                  "[주소] ${item.destination.destinationAddress}",
                                  style: const TextStyle(fontSize: 16),
                                ),
                                Gaps.v4,
                                Text(
                                  "[가격] ${item.products[0].prices[0].priceByUnit}원",
                                  style: const TextStyle(fontSize: 16),
                                ),
                                Gaps.v4,
                                Text(
                                  "[이름] ${item.deliveryTargetName}",
                                  style: const TextStyle(fontSize: 16),
                                ),
                                Gaps.v4,
                                Text(
                                  "[연락처] ${item.deliveryPhoneNumber}",
                                  style: const TextStyle(fontSize: 16),
                                ),
                                Gaps.v4,
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    ElevatedButton(
                                      onPressed: () =>
                                          _onRequestRefusal(item.ordersId),
                                      child: const Text("거부"),
                                    ),
                                    Gaps.h10,
                                    ElevatedButton(
                                      onPressed: () =>
                                          _onRequestAccept(item.ordersId),
                                      child: const Text("수락"),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          );
                        },
                      ),
                    ),
        ],
      ),
    );
  }
}
