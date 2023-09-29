import 'package:flutter/material.dart';

class HomeMenuButton extends StatelessWidget {
  const HomeMenuButton({
    super.key,
    required this.icon,
    required this.text,
    required this.onClick,
    required this.color,
    required this.backgroundColor,
  });

  final IconData icon;
  final String text;
  final Color color;
  final Color backgroundColor;
  final Function onClick;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onClick(),
      child: Padding(
        padding: const EdgeInsets.all(4),
        child: Container(
          clipBehavior: Clip.hardEdge, // 자신의 영역에서 벗어난 자식들을 통제하는 기능
          decoration: BoxDecoration(
            color: backgroundColor,
            border: Border.all(
              width: 1,
              color: color,
            ),
            borderRadius: const BorderRadius.all(
              Radius.circular(10),
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
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                child: Text(
                  text,
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: color,
                  ),
                ),
              ),
              Transform.scale(
                // 안의 요소가 부모보다 커져도 크기변화 없음
                scale: 2.2,
                child: Transform.translate(
                  // 요소의 위치 조절
                  offset: const Offset(40, 42),
                  child: Icon(
                    icon,
                    color: color.withOpacity(0.6),
                    size: 50,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
