import 'package:flutter/material.dart';
import 'package:swag_marine_products/constants/gaps.dart';
import 'package:swag_marine_products/features/user/order/user_order_screen.dart';

enum DeliveryStatus {
  confirmation,
  prepared,
  shipping,
  completed,
}

enum OrderStatus {
  available,
  postponed,
  unable,
}

class StoreOrderScreen extends StatefulWidget {
  const StoreOrderScreen({super.key});

  @override
  State<StoreOrderScreen> createState() => _StoreOrderScreenState();
}

class _StoreOrderScreenState extends State<StoreOrderScreen> {
  DeliveryStatus _deliveryStatus = DeliveryStatus.confirmation;
  OrderStatus _orderStatus = OrderStatus.available;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: SegmentedButton(
                        showSelectedIcon: false,
                        segments: const [
                          ButtonSegment(
                            value: OrderStatus.available,
                            label: Text('배송가능'),
                          ),
                          ButtonSegment(
                            value: OrderStatus.postponed,
                            label: Text('배송연기'),
                          ),
                          ButtonSegment(
                            value: OrderStatus.unable,
                            label: Text('배송불가능'),
                          ),
                        ],
                        selected: <OrderStatus>{_orderStatus},
                        onSelectionChanged: (Set<OrderStatus> newSelection) {
                          setState(() {
                            _orderStatus = newSelection.first;
                          });
                        },
                      ),
                    ),
                    Gaps.v4,
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: SegmentedButton(
                        showSelectedIcon: false,
                        segments: const [
                          ButtonSegment(
                            value: DeliveryStatus.confirmation,
                            label: Text('확인중'),
                          ),
                          ButtonSegment(
                            value: DeliveryStatus.prepared,
                            label: Text('준비중'),
                          ),
                          ButtonSegment(
                            value: DeliveryStatus.shipping,
                            label: Text('배달중'),
                          ),
                          ButtonSegment(
                            value: DeliveryStatus.completed,
                            label: Text('완료됨'),
                          ),
                        ],
                        selected: <DeliveryStatus>{_deliveryStatus},
                        onSelectionChanged: (Set<DeliveryStatus> newSelection) {
                          setState(() {
                            _deliveryStatus = newSelection.first;
                          });
                        },
                      ),
                    ),
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
