import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:swag_marine_products/constants/sizes.dart';
import 'package:swag_marine_products/features/store/profile/store_inform_inquiry_screen.dart';

class StoreProfileCard extends StatefulWidget {
  const StoreProfileCard({
    Key? key,
  }) : super(key: key);

  @override
  State<StoreProfileCard> createState() => _StoreProfileCardState();
}

class _StoreProfileCardState extends State<StoreProfileCard> {
  // void _showEditDialog(BuildContext context) {
  //   showDialog(
  //     context: context,
  //     builder: (BuildContext dialogContext) {
  //       String editedUserDef = widget.userData?.userDef ?? '';

  //       return AlertDialog(
  //         title: Text("상태 메시지"),
  //         content: TextField(
  //           onChanged: (newValue) {
  //             editedUserDef = newValue;
  //           },
  //           controller: TextEditingController(text: editedUserDef),
  //         ),
  //         actions: [
  //           TextButton(
  //             onPressed: () {
  //               Navigator.pop(dialogContext);
  //             },
  //             child: Text("취소"),
  //           ),
  //           TextButton(
  //             onPressed: () {
  //               _onUpdateDef(userData!.userId, _DefController.text);
  //             },
  //             child: Text("저장"),
  //           ),
  //         ],
  //       );
  //     },
  //   );
  // }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        context.pushNamed(StoreInformInquiryScreen.routeName);
      },
      leading: CircleAvatar(
        radius: 40,
        backgroundColor: Colors.blue.shade400,
        child: const FaIcon(
          FontAwesomeIcons.shop,
          size: 35,
          color: Colors.white,
        ),
      ),
      // leading: Container(
      //   padding: const EdgeInsets.symmetric(
      //     vertical: 4,
      //     horizontal: 2,
      //   ),
      //   color: Colors.blue.shade400,
      //   child: const FaIcon(
      //     FontAwesomeIcons.shop,
      //     size: 45,
      //     color: Colors.white,
      //   ),
      // ),
      title: const Text(
        "가게이름",
        style: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: Sizes.size18,
        ),
      ),
      subtitle: const Text(
        "가게 주소",
        style: TextStyle(
          fontSize: Sizes.size14,
        ),
      ),
      trailing: const Icon(
        Icons.chevron_right_rounded,
        size: Sizes.size40,
      ),
    );
  }
}
