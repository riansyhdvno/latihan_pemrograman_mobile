import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:latihan_mobile/lat_prauas/Api/Api.dart';
import 'package:latihan_mobile/lat_prauas/CRUD/Detail_page_Berita.dart';

class BeritaPage extends StatefulWidget {
  @override
  _BeritaPageState createState() => _BeritaPageState();
}

class _BeritaPageState extends State<BeritaPage> {
  List<dynamic> beritaList = [];
  List<dynamic> filteredBeritaList = [];
  bool _isloading = false;

  TextEditingController searchController = TextEditingController();

  Future<void> fetchBerita() async {
    try {
      setState(() {
        _isloading = true;
      });
      final response = await http.get(Uri.parse(Api.Read));
      final responseData = json.decode(response.body);

      if (responseData['isSuccess']) {
        setState(() {
          _isloading = false;
          beritaList = responseData['data'];
          filteredBeritaList = beritaList; // Inisialisasi filteredBeritaList
        });
      } else {
        print('Gagal: ${responseData['message']}');
      }
    } catch (error) {
      print('Error: $error');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchBerita();
  }

  void filterBerita(String query) {
    List<dynamic> filteredBerita = [];
    filteredBeritaList.forEach((berita) {
      if (berita['judul'].toLowerCase().contains(query.toLowerCase())) {
        filteredBerita.add(berita);
      }
    });
    setState(() {
      filteredBeritaList = filteredBerita;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Berita'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              showSearch(context: context, delegate: BeritaSearch(beritaList));
            },
          ),
        ],
      ),
      body: _isloading
          ? Center(
        child: CircularProgressIndicator(),
      )
          : ListView.builder(
        itemCount: filteredBeritaList.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DetailPage(
                      konten: filteredBeritaList[index]['konten'],
                      gambar: filteredBeritaList[index]['gambar'],
                    ),
                  ));
            },
            leading: CircleAvatar(
              backgroundImage: NetworkImage(
                Api.Image + filteredBeritaList[index]['gambar'],
              ),
              radius: 30,
            ),
            title: Text(filteredBeritaList[index]['judul'],
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text(
              filteredBeritaList[index]['konten'],
              overflow: TextOverflow.ellipsis,
            ),
            // Tambahkan penanganan ketika item ditekan sesuai kebutuhan
          );
        },
      ),
    );
  }
}

class BeritaSearch extends SearchDelegate<String> {
  final List<dynamic> beritaList;

  BeritaSearch(this.beritaList);

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      )
    ];
  }

  @override
  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        Navigator.pop(context);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final List<dynamic> results = query.isEmpty
        ? beritaList
        : beritaList
        .where((berita) =>
        berita['judul'].toLowerCase().contains(query.toLowerCase()))
        .toList();

    return ListView.builder(
      itemCount: results.length,
      itemBuilder: (context, index) => ListTile(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DetailPage(
                  konten: beritaList[index]['konten'],
                  gambar: beritaList[index]['gambar'],
                ),
              ));
        },
        title: Text(results[index]['judul']),
        subtitle: Text(results[index]['konten'],
          overflow: TextOverflow.ellipsis,
        ),
        // Tambahkan penanganan ketika item ditekan sesuai kebutuhan
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final List<dynamic> suggestionList = query.isEmpty
        ? []
        : beritaList
        .where((berita) =>
        berita['judul'].toLowerCase().contains(query.toLowerCase()))
        .toList();

    return ListView.builder(
      itemCount: suggestionList.length,
      itemBuilder: (context, index) => ListTile(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DetailPage(
                  konten: beritaList[index]['konten'],
                  gambar: beritaList[index]['gambar'],
                ),
              ));
        },
        title: Text(suggestionList[index]['judul']),
        // Tambahkan penanganan ketika item ditekan sesuai kebutuhan
      ),
    );
  }
}
