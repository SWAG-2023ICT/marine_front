import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:swag_marine_products/constants/gaps.dart';
import 'package:swag_marine_products/constants/http_ip.dart';
import 'package:swag_marine_products/features/user/order/user_order_sheet.dart';
import 'package:swag_marine_products/features/user/order/widgets/menu_card.dart';
import 'package:swag_marine_products/models/database/product_model.dart';
import 'package:swag_marine_products/models/database/store_model.dart';
import 'package:swag_marine_products/providers/user_provider.dart';
import 'package:swag_marine_products/widget_tools/swag_platform_dialog.dart';

import 'package:http/http.dart' as http;

class UserOrderScreenArgs {
  UserOrderScreenArgs({
    required this.storeId,
  });

  final String storeId;
}

class UserOrderScreen extends StatefulWidget {
  static const routeName = "user_order";
  static const routeURL = "user_order";
  const UserOrderScreen({
    super.key,
    required this.storeId,
  });

  final String storeId;

  @override
  State<UserOrderScreen> createState() => _UserOrderScreenState();
}

class _UserOrderScreenState extends State<UserOrderScreen> {
  StoreModel? _storeData;
  int? _wishId;
  bool _isFavorited = false;
  bool _isFirstLoading = false;

  @override
  void initState() {
    super.initState();

    _initStoreData();
  }

  void _initStoreData() async {
    setState(() {
      _isFirstLoading = true;
    });

    // --------------- 가게 정보 호출 ---------------
    final url1 = Uri.parse("${HttpIp.httpIp}/marine/stores/${widget.storeId}");
    final headers = {'Content-Type': 'application/json'};
    final response1 = await http.get(url1, headers: headers);

    if (response1.statusCode >= 200 && response1.statusCode < 300) {
      print("가게 정보 조회 : 성공");
      print(response1.body);
      final jsonResponse = jsonDecode(response1.body) as Map<String, dynamic>;

      setState(() {
        _storeData = StoreModel.fromJson(jsonResponse);
      });
    } else {
      if (!mounted) return;
      HttpIp.errorPrint(
        context: context,
        title: "통신 오류",
        message: response1.body,
      );
    }

    // --------------- 즐겨찾기 여부 호출 ---------------
    final url2 = Uri.parse(
        "${HttpIp.httpIp}/marine/users/wish/check?storeId=${widget.storeId}&userId=${context.read<UserProvider>().userData!.userId}");
    final response2 = await http.get(url2, headers: headers);

    if (response2.statusCode >= 200 && response2.statusCode < 300) {
      print("좋아요 여부 조회 : 성공");

      final jsonResponse = jsonDecode(response2.body) as int;
      if (jsonResponse != 0) {
        _wishId = jsonResponse;
      }

      setState(() {
        _isFavorited = _wishId != null ? true : false;
      });
    } else {
      if (!mounted) return;
      HttpIp.errorPrint(
        context: context,
        title: "통신 오류",
        message: response2.body,
      );
    }

    setState(() {
      _isFirstLoading = false;
    });
  }

  Future<void> _onRefresh() async {
    _initStoreData();
  }

  void _onClickFavorite() async {
    if (_isFavorited) {
      final url = Uri.parse("${HttpIp.httpIp}/marine/users/wish");
      final headers = {'Content-Type': 'application/json'};
      final data = [_wishId];
      final response =
          await http.delete(url, headers: headers, body: jsonEncode(data));

      if (response.statusCode >= 200 && response.statusCode < 300) {
        print("좋아요 취소 : 성공");

        setState(() {
          _wishId == null;
          _isFavorited = false;
        });
      } else {
        if (!mounted) return;
        HttpIp.errorPrint(
          context: context,
          title: "통신 오류",
          message: response.body,
        );
      }
    } else {
      final url = Uri.parse("${HttpIp.httpIp}/marine/users/wish");
      final headers = {'Content-Type': 'application/json'};
      final data = {
        'storeId': widget.storeId,
        'userId': context.read<UserProvider>().userData!.userId,
      };
      final response =
          await http.post(url, headers: headers, body: jsonEncode(data));

      if (response.statusCode >= 200 && response.statusCode < 300) {
        print("좋아요 적용 : 성공");
        print(response.body);

        final jsonResponse = jsonDecode(response.body) as int;
        if (jsonResponse != 0) {
          _wishId = jsonResponse;
        }

        setState(() {
          _isFavorited = true;
        });
      } else {
        if (!mounted) return;
        HttpIp.errorPrint(
          context: context,
          title: "통신 오류",
          message: response.body,
        );
      }
    }
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
            _isFirstLoading
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : NestedScrollView(
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
                                title: Text(
                                  _storeData!.storeName,
                                  style: const TextStyle(
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
                            child: _storeData!.products!.isEmpty
                                ? Column(
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
                                      const Text("상품이 비어있습니다!"),
                                    ],
                                  )
                                : RefreshIndicator.adaptive(
                                    onRefresh: _onRefresh,
                                    child: ListView.separated(
                                      // padding: const EdgeInsets.symmetric(horizontal: 10),
                                      itemCount: _storeData!.products!.length,
                                      separatorBuilder: (context, index) =>
                                          const Divider(
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
                                        return MenuCard(
                                          image: image,
                                          storeId: widget.storeId,
                                          productData:
                                              _storeData!.products![index],
                                        );
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
