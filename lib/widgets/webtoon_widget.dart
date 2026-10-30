import 'package:flutter/material.dart';
import 'package:toonflix/pages/detail_page.dart';

class Webtoon extends StatelessWidget {
  final String title, thumb, id;

  const Webtoon({
    super.key,
    required this.title,
    required this.thumb,
    required this.id,
  });

  @override
  Widget build(BuildContext context) {
    print(thumb);
    // GestureDetector : 동작 감지
    return GestureDetector(
      onTap: () {
        // 누르면 DetailPage로 이동
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                DetailPage(title: title, thumb: thumb, id: id),
            fullscreenDialog: true, //뒤로가기가 아닌 창 닫기(X)
          ),
          // 오른쪽->왼쪽
          // PageRouteBuilder(
          //   transitionsBuilder:
          //       (context, animation, secondaryAnimation, child) {
          //         var begin = const Offset(1.0, 0.0);
          //         var end = Offset.zero;
          //         var curve = Curves.ease;
          //         var tween = Tween(
          //           begin: begin,
          //           end: end,
          //         ).chain(CurveTween(curve: curve));
          //         return SlideTransition(
          //           position: animation.drive(tween),
          //           child: child,
          //         );
          //       },
          //   pageBuilder: (context, anmation, secondaryAnimation) =>
          //       DetailPage(id: id, title: title, thumb: thumb),
          // ),
          // 아래->위
          // PageRouteBuilder(
          //   transitionDuration: Duration(milliseconds: 300),
          //   pageBuilder: (context, animation, secondaryAnimation) =>
          //       DetailPage(title: title, thumb: thumb, id: id),
          //   transitionsBuilder:
          //       (context, animation, secondaryAnimation, child) {
          //         final curvedAnimation = CurvedAnimation(
          //           parent: animation,
          //           curve: Curves.easeOut,
          //         );

          //         final offsetAnimation = Tween(
          //           begin: Offset(0, 1),
          //           end: Offset.zero,
          //         ).animate(curvedAnimation);

          //         return SlideTransition(
          //           position: offsetAnimation,
          //           child: child,
          //         );
          //       },
          // ),
        );
      },
      child: Column(
        children: [
          Hero(
            tag: id,
            child: Container(
              width: 250,
              height: 323,
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    blurRadius: 8,
                    offset: Offset(6, 6),
                    color: Colors.black.withValues(alpha: 0.8),
                  ),
                ],
              ),
              child: Image.network(
                thumb,
                headers: const {'Referer': 'https://comic.naver.com/'},
              ),
            ),
          ),
          SizedBox(height: 20),
          Text(title, style: Theme.of(context).textTheme.bodyLarge),
        ],
      ),
    );
  }
}
