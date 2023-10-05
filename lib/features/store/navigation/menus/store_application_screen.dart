import 'package:flutter/material.dart';
import 'package:swag_marine_products/constants/gaps.dart';

class StoreApplicationScreen extends StatefulWidget {
  const StoreApplicationScreen({super.key});

  @override
  State<StoreApplicationScreen> createState() => _StoreApplicationScreenState();
}

class _StoreApplicationScreenState extends State<StoreApplicationScreen> {
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
          ListView.builder(
            itemCount: 5,
            itemBuilder: (context, index) {
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
                  expandedCrossAxisAlignment: CrossAxisAlignment.start,
                  childrenPadding: const EdgeInsets.all(10),
                  title: const Text(
                    "[주소] 진주시 가좌동 어쩌구저쩌구 000동 000호",
                    style: TextStyle(fontSize: 18),
                  ),
                  children: [
                    const Text(
                      "[주문] OOO물고기",
                      style: TextStyle(fontSize: 16),
                    ),
                    Gaps.v4,
                    const Text(
                      "[개수] 100g 2개",
                      style: TextStyle(fontSize: 16),
                    ),
                    Gaps.v4,
                    const Text(
                      "[이름] OOO",
                      style: TextStyle(fontSize: 16),
                    ),
                    Gaps.v4,
                    const Text(
                      "[연락처] 01012345678",
                      style: TextStyle(fontSize: 16),
                    ),
                    Gaps.v4,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        ElevatedButton(
                          onPressed: () {},
                          child: const Text("거부"),
                        ),
                        Gaps.h10,
                        ElevatedButton(
                          onPressed: () {},
                          child: const Text("수락"),
                        ),
                      ],
                    )
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
