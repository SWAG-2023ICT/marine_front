import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:swag_marine_products/constants/http_ip.dart';
import 'package:swag_marine_products/features/user/order/widgets/user_order_card.dart';
import 'package:swag_marine_products/models/database/order_model.dart';
import 'package:swag_marine_products/providers/user_provider.dart';

import 'package:http/http.dart' as http;

class UserOrderCheckScreen extends StatefulWidget {
  static const routeName = "user_order_check";
  static const routeURL = "user_order_check";
  const UserOrderCheckScreen({super.key});

  @override
  State<UserOrderCheckScreen> createState() => _UserOrderCheckScreenState();
}

class _UserOrderCheckScreenState extends State<UserOrderCheckScreen> {
  bool _isFirstLoading = false;
  List<dynamic>? _orderList;

  @override
  void initState() {
    super.initState();

    _initOrderList();
  }

  Future<void> _initOrderList() async {
    setState(() {
      _isFirstLoading = true;
    });

    final url = Uri.parse(
        "${HttpIp.httpIp}/marine/orders/users/${context.read<UserProvider>().userData!.userId}");
    final headers = {'Content-Type': 'application/json'};
    final response = await http.get(url, headers: headers);

    if (response.statusCode >= 200 && response.statusCode < 300) {
      print("신청 목록 호출 : 성공");

      final jsonResponse = jsonDecode(response.body) as List<dynamic>;

      final ordersList =
          jsonResponse.map((data) => OrderModel.fromJson(data)).toList();

      setState(() {
        _orderList = ordersList;
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
    _initOrderList();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.blue.shade50,
          title: const Text("주문 내역"),
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
                          onPressed: _onRefresh,
                        ),
                      )
                    : RefreshIndicator.adaptive(
                        onRefresh: _onRefresh,
                        child: ListView.builder(
                          itemCount: _orderList!.length,
                          itemBuilder: (context, index) {
                            return UserOrderCard(
                              orderData: _orderList![index],
                              initDispatch: _initOrderList,
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
