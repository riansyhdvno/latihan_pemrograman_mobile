import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:audioplayers/audioplayers.dart';
import 'model/audio_model.dart';

enum PlayerState { stopped, playing, paused }

class PageListAudio extends StatefulWidget {
  const PageListAudio({super.key});

  @override
  State<PageListAudio> createState() => _PageListAudioState();
}

class _PageListAudioState extends State<PageListAudio> {
  List<Datum> _audioList = [];
  List<Datum> _filteredAudioList = [];
  bool _isLoading = true;
  final List<AudioPlayer> _audioPlayers = [];
  final List<PlayerState> _playerStates = [];
  TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _fetchAudioData();
  }

  Future<void> _fetchAudioData() async {
    try {
      final response = await http.get(Uri.parse('http://192.168.18.21/mobprolanjut/audio/audio.php'));

      if (response.statusCode == 200) {
        final modelAudio = modelAudioFromJson(response.body);
        if (modelAudio.isSuccess && modelAudio.data.isNotEmpty) {
          setState(() {
            _audioList = modelAudio.data;
            _filteredAudioList = _audioList; // Initialize filtered list with all audio items
            for (int i = 0; i < _audioList.length; i++) {
              _audioPlayers.add(AudioPlayer());
              _playerStates.add(PlayerState.stopped);
            }
            _isLoading = false;
          });
        } else {
          setState(() {
            _isLoading = false;
          });
        }
      } else {
        throw Exception('Failed to load audio data: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching audio data: $e');
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _stopAllPlayers() async {
    for (int i = 0; i < _audioPlayers.length; i++) {
      if (_playerStates[i] == PlayerState.playing || _playerStates[i] == PlayerState.paused) {
        await _audioPlayers[i].stop();
        setState(() {
          _playerStates[i] = PlayerState.stopped;
        });
      }
    }
  }

  Future<void> _play(int index) async {
    await _stopAllPlayers();  // Stop all players before starting a new one

    final audioUrl = 'http://192.168.18.21/mobprolanjut/audio/sound/${_audioList[index].audio}';
    try {
      await _audioPlayers[index].play(audioUrl);
      setState(() => _playerStates[index] = PlayerState.playing);
    } catch (e) {
      print('Error playing audio: $e');
    }
  }

  Future<void> _pause(int index) async {
    try {
      await _audioPlayers[index].pause();
      setState(() => _playerStates[index] = PlayerState.paused);
    } catch (e) {
      print('Error pausing audio: $e');
    }
  }

  Future<void> _stop(int index) async {
    try {
      await _audioPlayers[index].stop();
      setState(() => _playerStates[index] = PlayerState.stopped);
    } catch (e) {
      print('Error stopping audio: $e');
    }
  }

  void _filterAudioList(String query) {
    setState(() {
      _filteredAudioList = _audioList.where((audio) =>
          audio.lagu.toLowerCase().contains(query.toLowerCase())
      ).toList();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    for (var player in _audioPlayers) {
      player.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Latihan Playlist Audio', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  labelText: 'Search',
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(),
                ),
                onChanged: _filterAudioList,
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: _filteredAudioList.length,
              itemBuilder: (context, index) {
                return Card(
                  margin: const EdgeInsets.all(2.0),
                  color: Theme.of(context).cardColor, // Adapt to theme
                  child: ListTile(
                    leading: Image.network(
                      "http://192.168.18.21/mobprolanjut/audio/logo/${_filteredAudioList[index].photo}",
                      width: 50,
                      height: 50,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return const Icon(Icons.error, size: 50);
                      },
                    ),
                    title: Text(_filteredAudioList[index].lagu
                        , style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.play_arrow),
                          onPressed: _playerStates[index] == PlayerState.playing ? null : () => _play(index),
                        ),
                        IconButton(
                          icon: const Icon(Icons.pause),
                          onPressed: _playerStates[index] == PlayerState.playing ? () => _pause(index) : null,
                        ),
                        IconButton(
                          icon: const Icon(Icons.stop),
                          onPressed: _playerStates[index] == PlayerState.playing || _playerStates[index] == PlayerState.paused ? () => _stop(index) : null,
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

}

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Latihan Playlist Audio',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        brightness: Brightness.light,
        cardColor: Colors.white,
        scaffoldBackgroundColor: Colors.white,
      ),
      darkTheme: ThemeData(
        primarySwatch: Colors.blue,
        brightness: Brightness.dark,
        cardColor: Colors.grey[800],
        scaffoldBackgroundColor: Colors.black,
      ),
      themeMode: ThemeMode.system, // Automatically switch between light and dark themes
      home: PageListAudio(),
    );
  }
}