import 'package:flutter/material.dart';
import 'package:swag_marine_products/constants/gaps.dart';
import 'package:swag_marine_products/features/sign_in_up/widgets/centered_divider.dart';
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
  final DeliveryStatus _deliveryStatus = DeliveryStatus.confirmation;
  OrderStatus _orderStatus = OrderStatus.available;

  // ---------------- 송장 번호 ----------------
  final TextEditingController _invoiceNumberController =
      TextEditingController();
  String? _invoiceNumberErrorText;

  // 송장번호 정규식
  RegExp invoiceNumberRegex = RegExp(r"^[A-Za-z0-9]+$");

  void _validateInvoiceNumber(String value) {
    if (value.isEmpty) {
      setState(() {
        _invoiceNumberErrorText = '송장번호를 입력하세요.';
      });
    } else if (!invoiceNumberRegex.hasMatch(value)) {
      setState(() {
        _invoiceNumberErrorText = '잘못된 형식의 송장 번호입니다.';
      });
    } else {
      setState(() {
        _invoiceNumberErrorText = null;
      });
    }
  }

  // ---------------- 송장 번호 ----------------
  final TextEditingController _impossibleReasonController =
      TextEditingController();
  String? _impossibleReasonErrorText;

  void _validateImpossibleReason(String value) {
    if (value.isEmpty) {
      setState(() {
        _impossibleReasonErrorText = '배송 불가능 사유를 입력하세요.';
      });
    } else {
      setState(() {
        _impossibleReasonErrorText = null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
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
                      if (!(_orderStatus == OrderStatus.unable))
                        Column(
                          children: [
                            TextFormField(
                              controller: _invoiceNumberController,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                labelText: '택배 송장번호',
                                errorText: _invoiceNumberErrorText,
                                prefixIcon: Icon(
                                  Icons.confirmation_num_outlined,
                                  color: Colors.grey.shade600,
                                ),
                              ),
                              onChanged: _validateInvoiceNumber,
                            ),
                            Gaps.v4,
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 50),
                                textStyle: const TextStyle(fontSize: 16),
                              ),
                              onPressed: () {},
                              child: const Text("전송"),
                            ),
                          ],
                        ),
                      if (!(_orderStatus != OrderStatus.unable))
                        Column(
                          children: [
                            TextFormField(
                              controller: _impossibleReasonController,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                labelText: '배송 불가능 사유',
                                errorText: _impossibleReasonErrorText,
                                prefixIcon: Icon(
                                  Icons.draw_outlined,
                                  color: Colors.grey.shade600,
                                ),
                              ),
                              onChanged: _validateImpossibleReason,
                            ),
                            Gaps.v4,
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 50),
                                textStyle: const TextStyle(fontSize: 16),
                              ),
                              onPressed: () {},
                              child: const Text("전송"),
                            ),
                          ],
                        ),
                      Gaps.v4,
                      const CenteredDivider(text: "진행 상황"),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: SegmentedButton(
                          showSelectedIcon: false,
                          segments: [
                            ButtonSegment(
                              enabled: _deliveryStatus ==
                                  DeliveryStatus.confirmation,
                              value: DeliveryStatus.confirmation,
                              label: const Text('확인중'),
                            ),
                            ButtonSegment(
                              enabled:
                                  _deliveryStatus == DeliveryStatus.prepared,
                              value: DeliveryStatus.prepared,
                              label: const Text('준비중'),
                            ),
                            ButtonSegment(
                              enabled:
                                  _deliveryStatus == DeliveryStatus.shipping,
                              value: DeliveryStatus.shipping,
                              label: const Text('배달중'),
                            ),
                            ButtonSegment(
                              enabled:
                                  _deliveryStatus == DeliveryStatus.completed,
                              value: DeliveryStatus.completed,
                              label: const Text('완료됨'),
                            ),
                          ],
                          selected: <DeliveryStatus>{_deliveryStatus},
                          onSelectionChanged: (p0) {},
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
