import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:swag_marine_products/constants/gaps.dart';
import 'package:swag_marine_products/constants/http_ip.dart';
import 'package:swag_marine_products/features/sign_in_up/widgets/centered_divider.dart';
import 'package:swag_marine_products/features/store/navigation/menus/widgets/store_order_card.dart';
import 'package:swag_marine_products/features/user/order/user_order_screen.dart';
import 'package:swag_marine_products/models/database/order_model.dart';
import 'package:swag_marine_products/providers/store_provider.dart';
import 'package:swag_marine_products/widget_tools/swag_platform_dialog.dart';

import 'package:http/http.dart' as http;

class StoreOrderScreen extends StatefulWidget {
  const StoreOrderScreen({super.key});

  @override
  State<StoreOrderScreen> createState() => _StoreOrderScreenState();
}

class _StoreOrderScreenState extends State<StoreOrderScreen> {
  bool _isFirstLoading = false;
  List<OrderModel>? _orderList;

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
      final jsonResponse = jsonDecode(response.body) as List<dynamic>;

      final ordersList =
          jsonResponse.map((data) => OrderModel.fromJson(data)).toList();

      setState(() {
        _orderList = ordersList
            .where((element) =>
                (element.deliveryStatus != 1 && element.deliveryStatus != 4) &&
                element.orderStatus != 3)
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

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.blue.shade50,
          title: const Text("주문"),
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
                : _orderList == null
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
                          itemCount: _orderList!.length,
                          itemBuilder: (context, index) {
                            return StoreOrderCard(
                              orderData: _orderList![index],
                              initDispatch: _initDispatch,
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
