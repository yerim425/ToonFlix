import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:toonflix/models/webtoon_detail_model.dart';
import 'package:toonflix/models/webtoon_episode_model.dart';
import 'package:toonflix/services/api_service.dart';
import 'package:toonflix/widgets/episode_widget.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

class DetailPage extends StatefulWidget {
  final String title, thumb, id;
  const DetailPage({
    super.key,
    required this.title,
    required this.thumb,
    required this.id,
  });

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  late Future<WebtoonDetailModel> webtoon;
  late Future<List<WebtoonEpisodeModel>> episodes;

  @override
  void initState() {
    super.initState();
    webtoon = ApiService.getWebtoonById(widget.id);
    episodes = ApiService.getLatestEpisodesById(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        shadowColor: Theme.of(context).colorScheme.primary
            .withValues(alpha: 0.8),
        elevation: 8,
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(width: 8),
            Text(
              widget.title,
              style: TextStyle(
                color: Theme.of(context).colorScheme.onPrimary,
                fontSize: 20,
              ),
            ),
          ],
        ),
        backgroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(50),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Hero(
                    tag: widget.id,
                    child: Container(
                      width: 250,
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
                        widget.thumb,
                        headers: const {'Referer': 'https://comic.naver.com'},
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 25),
              FutureBuilder(
                future: webtoon,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          snapshot.data!.about,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        SizedBox(height: 15),
                        Text(
                          '${snapshot.data!.genre} | ${snapshot.data!.age}',
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                      ],
                    );
                  }
                  return Text("");
                },
              ),
              SizedBox(height: 25),
              FutureBuilder(
                future: episodes,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Column(
                      children: [
                        for (var episode in snapshot.data!)
                          Episode(episode: episode, webtoonId: widget.id),
                      ],
                    );
                  }
                  return Container();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
