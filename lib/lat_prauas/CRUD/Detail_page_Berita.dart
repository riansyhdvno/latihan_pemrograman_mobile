import 'package:flutter/material.dart';
import 'package:latihan_mobile/lat_prauas/Api/Api.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({super.key, required this.konten, required this.gambar});
  final String konten;
  final String gambar;

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: 200,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(Api.Image + widget.gambar),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              widget.konten,
              textAlign: TextAlign.justify,
            ),
            Text(
              widget.konten,
              textAlign: TextAlign.justify,
            ),
            Text(
              widget.konten,
              textAlign: TextAlign.justify,
            ),
            Text(
              widget.konten,
              textAlign: TextAlign.justify,
            ),
            Text(
              widget.konten,
              textAlign: TextAlign.justify,
            ),
            Text(
              widget.konten,
              textAlign: TextAlign.justify,
            ),
          ],
        ),
      ),
    );
  }
}
