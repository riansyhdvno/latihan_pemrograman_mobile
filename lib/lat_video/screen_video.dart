import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:latihan_mobile/lat_video/model/video_model.dart';
import 'package:latihan_mobile/lat_video/detail_video.dart';

class PageVideo extends StatefulWidget {
  const PageVideo({Key? key}) : super(key: key);

  @override
  State<PageVideo> createState() => _PageVideoState();
}

class _PageVideoState extends State<PageVideo> {
  List<DatumVideo> _videoList = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchVideoData();
  }

  Future<void> _fetchVideoData() async {
    try {
      final response = await http.get(Uri.parse('http://192.168.18.21/mobprolanjut/video/video.php'));

      if (response.statusCode == 200) {
        final modelVideo = modelVideoFromJson(response.body);
        if (modelVideo.isSuccess && modelVideo.data.isNotEmpty) {
          setState(() {
            _videoList = modelVideo.data;
            _isLoading = false;
          });
        } else {
          setState(() {
            _isLoading = false;
          });
        }
      } else {
        throw Exception('Failed to load video data: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching video data: $e');
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _navigateToVideoPlayerPage(String videoUrl) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => VideoPlayerPage(videoUrl: videoUrl),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Latihan PlayList Video'),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
        itemCount: _videoList.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              _navigateToVideoPlayerPage('http://192.168.18.21/mobprolanjut/video/clip/${_videoList[index].video}');
            },
            child: Card(
              margin: const EdgeInsets.all(16.0),
              child: ListTile(
                leading: Image.network(
                  'http://192.168.18.21/mobprolanjut/video/logo/${_videoList[index].thumbnail}',
                  width: 100,
                  fit: BoxFit.cover,
                ),
                title: Text(_videoList[index].judul),
              ),
            ),
          );
        },
      ),
    );
  }
}