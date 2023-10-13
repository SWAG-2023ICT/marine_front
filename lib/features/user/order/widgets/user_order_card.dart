import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:swag_marine_products/constants/gaps.dart';
import 'package:swag_marine_products/features/sign_in_up/widgets/centered_divider.dart';
import 'package:swag_marine_products/models/database/order_model.dart';
import 'package:swag_marine_products/widget_tools/swag_platform_dialog.dart';

enum DeliveryStatus {
  cancelled,
  prepared,
  shipping,
  completed,
}

enum OrderStatus {
  available,
  postponed,
  unable,
}

class UserOrderCard extends StatefulWidget {
  const UserOrderCard({
    super.key,
    requ,
    required this.orderData,
    required this.initDispatch,
  });

  final OrderModel orderData;
  final Function initDispatch;

  @override
  State<UserOrderCard> createState() => _UserOrderCardState();
}

class _UserOrderCardState extends State<UserOrderCard> {
  DeliveryStatus _deliveryStatus = DeliveryStatus.prepared;
  final OrderStatus _orderStatus = OrderStatus.available;
  String? _reasonText;

  @override
  void initState() {
    super.initState();

    if (widget.orderData.orderStatus == 3) {
      _deliveryStatus = DeliveryStatus.cancelled;
      _reasonText = widget.orderData.reason;
    } else if (widget.orderData.orderStatus != 3 &&
        widget.orderData.deliveryStatus == 2) {
      _deliveryStatus = DeliveryStatus.prepared;
    } else if (widget.orderData.orderStatus != 3 &&
        widget.orderData.deliveryStatus == 3) {
      _deliveryStatus = DeliveryStatus.shipping;
    } else if (widget.orderData.orderStatus != 3 &&
        widget.orderData.deliveryStatus == 4) {
      _deliveryStatus = DeliveryStatus.completed;
    }

    // _deliveryStatus = widget.orderData.deliveryStatus == 2
    //     ? DeliveryStatus.prepared
    //     : widget.orderData.deliveryStatus == 3
    //         ? DeliveryStatus.shipping
    //         : DeliveryStatus.completed;

    // _orderStatus = widget.orderData.orderStatus == 1
    //     ? OrderStatus.available
    //     : widget.orderData.orderStatus == 2
    //         ? OrderStatus.postponed
    //         : OrderStatus.unable;
  }

  @override
  Widget build(BuildContext context) {
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
        title: Text(
          "[주문] ${widget.orderData.products[0].productName} ${widget.orderData.products[0].prices[0].unit}",
          style: const TextStyle(fontSize: 18),
        ),
        children: [
          Text(
            "[주소] ${widget.orderData.destination.destinationAddress}",
            style: const TextStyle(fontSize: 16),
          ),
          Gaps.v4,
          Text(
            "[가격] ${NumberFormat.currency(locale: 'ko_KR', symbol: '').format(widget.orderData.products[0].prices[0].priceByUnit)}원",
            style: const TextStyle(fontSize: 16),
          ),
          Gaps.v4,
          Text(
            "[이름] ${widget.orderData.deliveryTargetName}",
            style: const TextStyle(fontSize: 16),
          ),
          Gaps.v4,
          Text(
            "[연락처] ${widget.orderData.deliveryPhoneNumber}",
            style: const TextStyle(fontSize: 16),
          ),
          Gaps.v4,
          const CenteredDivider(text: "진행 상황"),
          Align(
            alignment: Alignment.bottomCenter,
            child: SegmentedButton(
              showSelectedIcon: false,
              segments: [
                ButtonSegment(
                  enabled: _deliveryStatus == DeliveryStatus.prepared,
                  value: DeliveryStatus.prepared,
                  label: const Text('준비중'),
                ),
                ButtonSegment(
                  enabled: _deliveryStatus == DeliveryStatus.shipping,
                  value: DeliveryStatus.shipping,
                  label: const Text('배달중'),
                ),
                ButtonSegment(
                  enabled: _deliveryStatus == DeliveryStatus.completed,
                  value: DeliveryStatus.completed,
                  label: const Text('완료됨'),
                ),
                ButtonSegment(
                  enabled: _deliveryStatus == DeliveryStatus.cancelled,
                  value: DeliveryStatus.cancelled,
                  label: const Text('취소됨'),
                ),
              ],
              selected: <DeliveryStatus>{_deliveryStatus},
              onSelectionChanged: (p0) {},
            ),
          ),
          Gaps.v4,
          if (_deliveryStatus == DeliveryStatus.cancelled)
            Text(
              "취소 사유 : $_reasonText",
              style: const TextStyle(
                color: Colors.red,
                fontSize: 15,
              ),
            ),
        ],
      ),
    );
  }
}
