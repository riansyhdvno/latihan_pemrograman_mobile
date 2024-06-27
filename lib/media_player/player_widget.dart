import 'dart:async';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:latihan_mobile/media_player/video_player.dart';
import 'package:latihan_mobile/media_player/player_widget.dart';
import 'package:latihan_mobile/media_player/menut_utama.dart';
import 'package:latihan_mobile/media_player/audio_player.dart';

enum PlayerState { stopped, playing, paused }

class PlayerWidget extends StatefulWidget {
  final String url;
  final String fileName;
  final PlayerMode mode;

  const PlayerWidget({
    required this.url,
    this.mode = PlayerMode.MEDIA_PLAYER,
    required this.fileName,
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _PlayerWidgetState(url, mode, fileName);
}

class _PlayerWidgetState extends State<PlayerWidget> {
  final String url;
  final PlayerMode mode;
  final String fileName;

  late AudioPlayer _audioPlayer;
  Duration? _duration;
  Duration? _position;

  PlayerState _playerState = PlayerState.stopped;
  late StreamSubscription<Duration> _durationSubscription;
  late StreamSubscription<Duration?> _positionSubscription;
  late StreamSubscription _playerCompleteSubscription;
  late StreamSubscription<String> _playerErrorSubscription;

  bool get _isPlaying => _playerState == PlayerState.playing;
  bool get _isPaused => _playerState == PlayerState.paused;
  bool get _isStopped => _playerState == PlayerState.stopped;

  String get _durationText => _duration?.toString().split('.').first ?? '';
  String get _positionText => _position?.toString().split('.').first ?? '';

  _PlayerWidgetState(this.url, this.mode, this.fileName);

  @override
  void initState() {
    super.initState();
    _audioPlayer = AudioPlayer(mode: mode);

    _durationSubscription = _audioPlayer.onDurationChanged.listen((duration) {
      setState(() => _duration = duration);
    });

    _positionSubscription = _audioPlayer.onAudioPositionChanged.listen((position) {
      setState(() => _position = position);
    });

    _playerCompleteSubscription = _audioPlayer.onPlayerCompletion.listen((event) {
      _onComplete();
      setState(() {
        _position = _duration;
      });
    });

    _playerErrorSubscription = _audioPlayer.onPlayerError.listen((msg) {
      print('audioPlayer error: $msg');
      setState(() {
        _playerState = PlayerState.stopped;
        _duration = Duration.zero;
        _position = Duration.zero;
      });
    });
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    _durationSubscription.cancel();
    _positionSubscription.cancel();
    _playerCompleteSubscription.cancel();
    _playerErrorSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[600],
        borderRadius: BorderRadius.circular(5),
        boxShadow: const [
          BoxShadow(
            color: Colors.black45,
            blurRadius: 5.0,
            spreadRadius: 0.5,
            offset: Offset(
              1.0,
              1.0,
            ),
          )
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                onPressed: _isPlaying ? null : _play,
                iconSize: 50.0,
                icon: const Icon(Icons.play_arrow),
                color: Colors.orange.shade300,
              ),
              IconButton(
                onPressed: _isPlaying ? _pause : null,
                iconSize: 50.0,
                icon: const Icon(Icons.pause),
                color: Colors.orange.shade300,
              ),
              IconButton(
                onPressed: _isPlaying || _isPaused ? _stop : null,
                iconSize: 50.0,
                icon: const Icon(Icons.stop),
                color: Colors.orange.shade300,
              ),
            ],
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Stack(
                  children: [
                    Slider(
                      inactiveColor: Colors.orange.shade300,
                      activeColor: Colors.orange.shade900,
                      onChanged: (v) {
                        if (_duration != null) {
                          final position = v * _duration!.inMilliseconds;
                          _audioPlayer.seek(Duration(milliseconds: position.round()));
                        }
                      },
                      value: (_position != null &&
                          _duration != null &&
                          _position!.inMilliseconds > 0 &&
                          _position!.inMilliseconds < _duration!.inMilliseconds)
                          ? _position!.inMilliseconds / _duration!.inMilliseconds
                          : 0.0,
                    ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.all(8.0),
                child: Text(
                  _position != null
                      ? '${_positionText ?? ''} / ${_durationText ?? ''}'
                      : _duration != null
                      ? _durationText
                      : '',
                  style: const TextStyle(fontSize: 16.0, color: Colors.white),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _play() async {
    final playPosition = (_position != null &&
        _duration != null &&
        _position!.inMilliseconds > 0 &&
        _position!.inMilliseconds < _duration!.inMilliseconds)
        ? _position
        : null;
    final result = await _audioPlayer.play(url, position: playPosition);
    if (result == 1) setState(() => _playerState = PlayerState.playing);
  }

  Future<void> _pause() async {
    final result = await _audioPlayer.pause();
    if (result == 1) setState(() => _playerState = PlayerState.paused);
  }

  Future<void> _stop() async {
    final result = await _audioPlayer.stop();
    if (result == 1) {
      setState(() {
        _playerState = PlayerState.stopped;
        _position = Duration.zero;
      });
    }
  }

  void _onComplete() {
    setState(() => _playerState = PlayerState.stopped);
  }
}