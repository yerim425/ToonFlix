import 'package:flutter/material.dart';
import 'package:toonflix/models/webtoon_model.dart';
import 'package:toonflix/services/api_service.dart';
import 'package:toonflix/widgets/webtoon_widget.dart';

class HomePage extends StatelessWidget {
  final Future<List<WebtoonModel>> webtoons = ApiService.getTodaysToons();

  HomePage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shadowColor: Theme.of(context).colorScheme.primary
            .withValues(alpha: 0.6),
        elevation: 10,

        title: Row(
          children: [
            SizedBox(width: 8),
            Text(
              'TOON',
              style: TextStyle(
                color: Theme.of(context).colorScheme.onPrimary,
                fontWeight: FontWeight.w600,
                fontSize: 22,
              ),
            ),
            Text(
              'FLIX',
              style: TextStyle(
                color: Theme.of(context).colorScheme.primary,
                fontWeight: FontWeight.w600,
                fontSize: 22,
              ),
            ),
          ],
        ),
        backgroundColor: Colors.black,
      ),
      body: Container(
        color: Theme.of(context).colorScheme.surface,
        child: FutureBuilder(
          future: webtoons,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Center(child: Text('데이터를 불러오지 못했습니다.'));
            }
            if (snapshot.hasData) {
              return Column(
                children: [
                  SizedBox(height: 100),
                  Expanded(child: makeList(snapshot)),
                ],
              );
            }
            return Center(
              child: CircularProgressIndicator(color: Color(0xFF03C75A)),
            );
          },
        ),
      ),
    );
  }

  // Future 데이터들을 리스트로 보여주기
  ListView makeList(AsyncSnapshot<List<WebtoonModel>> snapshot) {
    return ListView.separated(
      shrinkWrap: true,

      scrollDirection: Axis.horizontal,
      itemCount: snapshot.data!.length,
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      itemBuilder: (context, index) {
        // listview에 들어가는 아이템들을 만들어줌
        var webtoon = snapshot.data![index];
        return Webtoon(
          title: webtoon.title,
          thumb: webtoon.thumb,
          id: webtoon.id,
        );
      },
      separatorBuilder: (context, index) => SizedBox(width: 40),
    );
  }
}
