import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:latihan_mobile/lat_prauas/Api/Api.dart';
import 'package:latihan_mobile/lat_prauas/Model/model_list_mahasiswa.dart';
import 'package:http/http.dart' as http;
import 'package:latihan_mobile/lat_prauas/screen_page/list_mahasiswa.dart';


class PageDetailMahasiswa extends StatefulWidget {
  final Datum mahasiswa;
  const PageDetailMahasiswa({super.key, required this.mahasiswa});

  @override
  State<PageDetailMahasiswa> createState() => _PageDetailMahasiswaState();
}

class _PageDetailMahasiswaState extends State<PageDetailMahasiswa> {

  Future<void> deleteMahasiswa(int id) async {
    try {
      final response = await http.post(
        Uri.parse(Api.DeleteMahasiswa),
        body: {'id': id.toString()},
      );

      final responseData = json.decode(response.body);
      if (responseData['isSuccess']) {

        print('mahasiswa berhasil dihapus');
        // fetchDataPegawai(); // Memuat ulang data setelah penghapusan

        // Tampilkan dialog berhasil dihapus
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Sukses'),
              content: Text('Mahasiswa berhasil dihapus'),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context)
                    =>ListMahasiswaPage()
                    ));
                  },
                  child: Text('OK'),
                ),
              ],
            );
          },
        );
      } else {
        // mahasiswa gagal dihapus
        print('mahasiswa gagal dihapus');
      }
    } catch (error) {
      print('Error: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    var mahasiswax = this.widget.mahasiswa ;
    return Scaffold(
      appBar: AppBar(
        title: Text('${mahasiswax.namaMahasiswa}',  style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.purple,
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(10,),
        child: Column(
          children: [
            SizedBox(height : 10),
            Text(mahasiswax.noBp),
            SizedBox(height : 10),
            Text(mahasiswax.email),
            SizedBox(height : 10),
            Text(mahasiswax.jenisKelamin),
            SizedBox(height : 30),

            Center(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  MaterialButton(onPressed: (){

                  },
                    textColor: Colors.white,
                    child: Text('Edit Data'),
                    color: Colors.purple,
                  ),

                  SizedBox(width: 10,),
                  MaterialButton(onPressed: (){
                    showDeleteConfirmationDialog(
                        int.parse(mahasiswax.id));

                  },
                    textColor: Colors.white,
                    child: Text('Delete Data'),
                    color: Colors.purple,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<void> showDeleteConfirmationDialog(int id) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // User harus menekan tombol untuk keluar
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Konfirmasi Hapus'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Apakah Anda yakin ingin menghapus data mahasiswa id =  $id ini?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Tidak'),
              onPressed: () {
                Navigator.of(context).pop(); // Tutup dialog
              },
            ),
            TextButton(
              child: Text('Ya'),
              onPressed: () {
                deleteMahasiswa(id);
                Navigator.of(context).pop(); // Tutup dialog
              },
            ),
          ],
        );
      },
    );
  }
}


