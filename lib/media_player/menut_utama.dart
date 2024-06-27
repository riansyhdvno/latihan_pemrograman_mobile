import 'audio_player.dart';
import 'package:flutter/material.dart';
import 'video_player.dart';

class MenuUtama extends StatefulWidget {
  const MenuUtama({super.key});

  @override
  State<MenuUtama> createState() => _MenuUtamaState();
}

class _MenuUtamaState extends State<MenuUtama> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        title: Text('Media Player App'),
      ),
      body: Center(
        child: ListView(
          children: [
            SizedBox(height: 20,),
            MaterialButton(onPressed: (){
              Navigator.push(context,
                  MaterialPageRoute(builder: (_) => AudioPlayerPage()));
            },
              child: Text('Audio Player'),
              textColor: Colors.white,
              color: Colors.blueAccent,
            ),
            SizedBox(height: 20,),
            MaterialButton(onPressed: (){
              Navigator.push(context,
                  MaterialPageRoute(builder: (_) => VideoApp()));
            },
              child: Text('Media Player'),
              textColor: Colors.white,
              color: Colors.blueAccent,
            ),
          ],
        ),
      ),
    );
  }
}