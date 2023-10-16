import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:swag_marine_products/constants/gaps.dart';
import 'package:swag_marine_products/utils/time_parse.dart';

class UserCommunityScreen extends StatefulWidget {
  const UserCommunityScreen({super.key});

  @override
  State<UserCommunityScreen> createState() => _UserCommunityScreenState();
}

class _UserCommunityScreenState extends State<UserCommunityScreen> {
  final TextEditingController _searchController = TextEditingController();
  bool _isBarriered = false;

  Future<void> _onSearch() async {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.blue.shade50,
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
      floatingActionButton: Visibility(
        visible: !_isBarriered,
        child: AnimatedOpacity(
          opacity: _isBarriered ? 0 : 1,
          duration: const Duration(milliseconds: 200),
          child: FloatingActionButton(
            heroTag: "user_community_edit",
            onPressed: () {},
            backgroundColor: Colors.blue.shade400,
            child: const FaIcon(
              FontAwesomeIcons.penToSquare,
              color: Colors.black,
            ),
          ),
        ),
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
            itemCount: _communityDumyData.length,
            itemBuilder: (context, index) {
              String image;
              if (index % 3 == 0) {
                image = "assets/images/fish3.png";
              } else if (index % 2 == 0) {
                image = "assets/images/fish2.png";
              } else {
                image = "assets/images/fish.png";
              }
              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(
                    width: 0.4,
                  ),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(0),
                  ),
                  boxShadow: [
                    BoxShadow(
                      offset: const Offset(2, 2),
                      color: Colors.grey.shade400,
                      blurRadius: 1,
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    ListTile(
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 6,
                      ),
                      leading: CircleAvatar(
                        radius: 16,
                        backgroundColor: Colors.blue.shade400,
                        child: const FaIcon(
                          FontAwesomeIcons.solidCircleUser,
                          size: 25,
                          color: Colors.white,
                        ),
                      ),
                      title: Text("testUserId${index + 1}"),
                      subtitle: Text(
                        TimeParse.getTimeAgo(
                          DateTime.now().subtract(
                            Duration(days: index + 1),
                          ),
                        ),
                      ),
                      // trailing: IconButton(
                      //   onPressed: () {},
                      //   icon: const Icon(Icons.comment_outlined),
                      // ),
                      trailing: IconButton(
                        onPressed: () {},
                        icon: const FaIcon(FontAwesomeIcons.comment),
                      ),
                    ),
                    Row(
                      children: [
                        Image.asset(
                          image,
                          width: 75,
                          height: 75,
                        ),
                        Gaps.h10,
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                _communityDumyData[index]["title"],
                                style: const TextStyle(fontSize: 16),
                              ),
                              const Divider(),
                              Text(
                                _communityDumyData[index]["content"],
                                style: const TextStyle(fontSize: 14),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
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

final List<Map<String, dynamic>> _communityDumyData = [
  {
    'title': '남해 수산물에 관한 정보가 필요합니다!',
    'content': '남해에는 어떤 수산물이 저렴한가요?',
  },
  {
    'title': 'OO도매시장에서 구입해서 가격을 나누실분 있으신가요?',
    'content': '인당 ...원으로 나눌 생각입니다.',
  },
  {
    'title': 'OOO를 사려면 어느 지역에서 저렴한가요?',
    'content': 'OOO지역에서 가까우면 되도록 좋을것같습니다.',
  },
  {
    'title': '동해 수산물에 관한 정보가 필요합니다!',
    'content': '동해에는 어떤 수산물이 저렴한가요?',
  },
  {
    'title': '서해 수산물에 관한 정보가 필요합니다!',
    'content': '서해에는 어떤 수산물이 저렴한가요?',
  },
];
