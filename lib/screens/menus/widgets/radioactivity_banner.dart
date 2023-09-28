import 'package:flutter/material.dart';
import 'package:swag_marine_products/constants/gaps.dart';
import 'package:swag_marine_products/constants/sizes.dart';

class RadioactivityBanner extends StatelessWidget {
  const RadioactivityBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: const BorderRadius.all(
          Radius.circular(10.0),
        ),
        boxShadow: const [
          BoxShadow(
            color: Colors.grey, // 그림자 색상
            offset: Offset(1.5, 1.5), // 그림자 위치 (가로, 세로)
            blurRadius: 5, // 그림자의 흐림 정도
            spreadRadius: 0, // 그림자 확산 정도
          ),
        ],
      ),
      child: ExpansionTile(
        initiallyExpanded: true,
        backgroundColor: Colors.white,
        collapsedBackgroundColor: Colors.white,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(10.0),
          ),
        ),
        collapsedShape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(10.0),
          ),
        ),
        title: Row(
          children: [
            Image.asset(
              "assets/images/radioactivity.png",
              width: 16,
              height: 16,
            ),
            Gaps.h6,
            const Text(
              "수산물 일일 방사능 검사결과",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        children: const [
          Padding(
            padding: EdgeInsets.only(
              bottom: Sizes.size8,
              left: Sizes.size8,
              right: Sizes.size8,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                RadioactivityCard(
                  title: "전체 건 수",
                  num: 29,
                ),
                RadioactivityCard(
                  title: "적합 건 수",
                  num: 29,
                  isNumBold: true,
                  numColor: Colors.blue,
                ),
                RadioactivityCard(
                  title: "부적합 건 수",
                  num: 0,
                  isNumBold: true,
                  numColor: Colors.red,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class RadioactivityCard extends StatelessWidget {
  const RadioactivityCard({
    super.key,
    required this.title,
    required this.num,
    this.isNumBold = false,
    this.numColor = Colors.black,
  });

  final String title;
  final int num;
  final bool isNumBold;
  final Color numColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(Sizes.size10),
      decoration: BoxDecoration(
        border: Border.all(
          width: 0.6,
        ),
        borderRadius: const BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      child: Column(
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            num.toString(),
            style: TextStyle(
              fontSize: 15,
              fontWeight: isNumBold ? FontWeight.bold : FontWeight.normal,
              color: num == 0 ? Colors.grey : numColor,
            ),
          ),
        ],
      ),
    );
  }
}
