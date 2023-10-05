import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:swag_marine_products/constants/gaps.dart';
import 'package:swag_marine_products/constants/sizes.dart';
import 'package:swag_marine_products/features/sign_in_up/widgets/centered_divider.dart';
import 'package:swag_marine_products/features/store/profile/store_inform_update_screen.dart';

class StoreInformInquiryScreen extends StatefulWidget {
  static const routeName = "store_inquiry_screen";
  static const routeURL = "store_inquiry_screen";

  const StoreInformInquiryScreen({
    super.key,
  });

  @override
  State<StoreInformInquiryScreen> createState() =>
      _StoreInformInquiryScreenState();
}

class _StoreInformInquiryScreenState extends State<StoreInformInquiryScreen> {
  final String _address = "주소 1";

  void _onChangeStoreImage() async {}

  @override
  Widget build(BuildContext context) {
    DateTime? birthday = DateTime.now();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "가게 정보",
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: Sizes.size20, vertical: Sizes.size8),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: TextFormField(
                      initialValue: "수산의 왕",
                      readOnly: true,
                      decoration: InputDecoration(
                        labelText: "가게 이름",
                        prefixIcon: Icon(
                          Icons.person_outline,
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      context.pushNamed(
                        StoreInformUpdateScreen.routeName,
                        extra: const StoreInformUpdateScreenArgs(
                          updateType: UpdateType.storeName,
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.all(24),
                      textStyle: const TextStyle(fontSize: 14),
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                    ),
                    child: const Text("수정"),
                  ),
                ],
              ),
              Gaps.v10,
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: TextFormField(
                      initialValue: "진주시 가좌동",
                      readOnly: true,
                      decoration: InputDecoration(
                        labelText: "가게 주소",
                        prefixIcon: Icon(
                          Icons.badge_outlined,
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      context.pushNamed(
                        StoreInformUpdateScreen.routeName,
                        extra: const StoreInformUpdateScreenArgs(
                          updateType: UpdateType.storeAddress,
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.all(24),
                      textStyle: const TextStyle(fontSize: 14),
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                    ),
                    child: const Text("수정"),
                  ),
                ],
              ),
              Gaps.v10,
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: TextFormField(
                      initialValue: "01012345678",
                      readOnly: true,
                      decoration: InputDecoration(
                        labelText: "가게 전화번호",
                        prefixIcon: Icon(
                          Icons.phone_iphone_rounded,
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      context.pushNamed(
                        StoreInformUpdateScreen.routeName,
                        extra: const StoreInformUpdateScreenArgs(
                          updateType: UpdateType.storePhoneNumber,
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.all(24),
                      textStyle: const TextStyle(fontSize: 14),
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                    ),
                    child: const Text("수정"),
                  ),
                ],
              ),
              Gaps.v10,
              const CenteredDivider(text: "이미지"),
              Image.asset(
                "assets/images/fishShop.png",
                width: MediaQuery.of(context).size.width,
              ),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: _onChangeStoreImage,
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.all(20),
                        textStyle: const TextStyle(fontSize: 18),
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                        ),
                      ),
                      child: const Text("수정"),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class UserDataBox extends StatelessWidget {
  const UserDataBox({
    super.key,
    required this.data,
    required this.name,
    this.hint,
  });

  final String name;
  final String data;
  final String? hint;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: Sizes.size5),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Text(
              name,
              style: Theme.of(context).textTheme.titleSmall,
            ),
          ),
          Gaps.h10,
          Expanded(
            flex: 4,
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 14,
                vertical: 14,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  width: 1,
                  color: const Color(0xFFDBDBDB),
                ),
              ),
              child: Text(
                data.trim().isEmpty ? hint ?? "" : data,
                style: data.trim().isEmpty
                    ? Theme.of(context).textTheme.labelLarge
                    : Theme.of(context).textTheme.bodyMedium,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
