import 'package:flutter/material.dart';
import 'package:latihan_mobile/media_player/player_widget.dart';


class AudioPlayerPage extends StatelessWidget {
  const AudioPlayerPage({super.key});

  @override
  Widget build(BuildContext context) {
    final String urlExample = "http://ia802609.us.archive.org/13/items/quraninindonesia/001AlFaatihah.mp3";
    final String nameExample = "Al-Fatihah";

    return Scaffold(
      appBar: AppBar(
        title: const Text('Audio Player'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const Text("Al Fatihah"),
          Container(
            margin: const EdgeInsets.all(8.0),
            child: PlayerWidget(url: urlExample, fileName: nameExample),
          ),
        ],
      ),
    );
  }
}