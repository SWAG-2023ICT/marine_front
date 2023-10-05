import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:swag_marine_products/constants/sizes.dart';
import 'package:swag_marine_products/features/store/profile/store_user_inform_inquiry_screen.dart';

class UserProfileCard extends StatefulWidget {
  const UserProfileCard({
    Key? key,
  }) : super(key: key);

  @override
  State<UserProfileCard> createState() => _UserProfileCardState();
}

class _UserProfileCardState extends State<UserProfileCard> {
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
        context.pushNamed(StoreUserInformInquiryScreen.routeName);
      },
      leading: CircleAvatar(
        radius: 40,
        backgroundColor: Colors.blue.shade400,
        child: const FaIcon(
          FontAwesomeIcons.solidCircleUser,
          size: 45,
          color: Colors.white,
        ),
      ),
      title: const Text(
        "이재현@dlwogus1027",
        style: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: Sizes.size18,
        ),
      ),
      subtitle: const Text(
        "01049049193",
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
