import 'dart:io';

import 'package:flutter/material.dart';
import 'package:swag_marine_products/constants/gaps.dart';
import 'package:swag_marine_products/features/user/home/widgets/radioactivity_banner.dart';

class UserStoreScreen extends StatefulWidget {
  const UserStoreScreen({super.key});

  @override
  State<UserStoreScreen> createState() => _UserStoreScreenState();
}

class _UserStoreScreenState extends State<UserStoreScreen> {
  final TextEditingController _searchController = TextEditingController();

  bool _isBarriered = false;
  bool _isFirstLoading = false;

  @override
  void initState() {
    super.initState();

    _initStoreList();
  }

  Future<void> _initStoreList() async {
    setState(() {
      _isFirstLoading = true;
    });

    sleep(const Duration(milliseconds: 100));

    setState(() {
      _isFirstLoading = false;
    });
  }

  Future<void> _onSearch() async {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      // appBar: AppBar(
      //   centerTitle: true,
      //   title: const Text("Mariner"),
      // ),
      body: Stack(
        children: [
          NestedScrollView(
            headerSliverBuilder: (context, innerBoxIsScrolled) => [
              const SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: RadioactivityBanner(),
                ),
              ),
              SliverPadding(
                padding: const EdgeInsets.symmetric(
                  vertical: 6,
                  horizontal: 10,
                ),
                sliver: SliverAppBar(
                  pinned: true,
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
                ),
              )
            ],
            body: _isFirstLoading
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : ListView.builder(
                    itemCount: 20,
                    itemBuilder: (context, index) => Container(
                      margin: const EdgeInsets.all(10),
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: const BorderRadius.all(
                          Radius.circular(0),
                        ),
                        boxShadow: [
                          BoxShadow(
                            offset: const Offset(1, 1),
                            color: Colors.grey.shade400,
                            blurRadius: 1,
                          ),
                        ],
                      ),
                      // child: ListTile(
                      //   contentPadding: EdgeInsets.zero,
                      //   leading: Image.asset(
                      //     "assets/images/fishShop.png",
                      //   ),
                      //   title: Row(
                      //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //     children: [
                      //       const Text(
                      //         "[가게 이름]",
                      //         style: TextStyle(
                      //           fontSize: 16,
                      //         ),
                      //       ),
                      //       IconButton(
                      //         onPressed: () {},
                      //         icon: const Icon(Icons.favorite_outline),
                      //       ),
                      //     ],
                      //   ),
                      //   subtitle: const Column(
                      //     crossAxisAlignment: CrossAxisAlignment.start,
                      //     children: [
                      //       Divider(),
                      //       Text("가게 주소 : ${"진주시 가좌동"}"),
                      //       Text("가게 번호 : ${"010-0000-0000"}"),
                      //     ],
                      //   ),
                      // ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset(
                            "assets/images/fishShop.png",
                            width: 100,
                            height: 100,
                          ),
                          Gaps.h6,
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Expanded(
                                      child: Text(
                                        "[가게 이름]",
                                        maxLines: 1,
                                        style: TextStyle(
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(right: 10),
                                      child: InkWell(
                                        onTap: () {},
                                        child:
                                            const Icon(Icons.favorite_outline),
                                      ),
                                    ),

                                    // IconButton(
                                    //   onPressed: () {},
                                    //   icon: const Icon(Icons.favorite_outline),
                                    // ),
                                  ],
                                ),
                                const Divider(),
                                const Text("가게 주소 : ${"진주시 가좌동"}"),
                                const Text("가게 번호 : ${"010-0000-0000"}"),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
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
    );
  }
}
