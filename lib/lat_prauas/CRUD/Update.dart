// ignore_for_file: prefer_const_constructors, avoid_print

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:latihan_mobile/lat_prauas/Api/Api.dart';
import 'dart:convert';
import 'package:latihan_mobile/lat_prauas/Api/Class_pegawai.dart';

class EditPegawaiPage extends StatefulWidget {
  final Pegawai data; // Menerima objek Pegawai untuk mengedit data

  EditPegawaiPage({required this.data});

  @override
  _EditPegawaiPageState createState() => _EditPegawaiPageState();
}

class _EditPegawaiPageState extends State<EditPegawaiPage> {
  TextEditingController noBpController = TextEditingController();
  TextEditingController noHpController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  final _key = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    // Panggil fetchDataPegawai di initState
    fetchDataPegawai();
  }

  Future<void> fetchDataPegawai() async {
    try {
      // Inisialisasi controller berdasarkan data Pegawai yang diterima
      noBpController.text = widget.data.noBp;
      noHpController.text = widget.data.noHp;
      emailController.text = widget.data.email;
    } catch (error) {
      print('Error: $error');
    }
  }

  Future<void> editPegawai() async {
    try {
      final response = await http.post(
        Uri.parse(Api.EditPegawai),
        body: {
          'id': widget.data.id.toString(),
          'no_bp': noBpController.text,
          'no_hp': noHpController.text,
          'email': emailController.text,
        },
      );

      final responseData = json.decode(response.body);
      if (responseData['isSuccess']) {
        // Pegawai berhasil diperbarui
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Berhasil'),
              content: Text('Data pegawai berhasil diperbarui.'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context); // Tutup dialog
                    Navigator.pop(
                        context, true); // Kembali ke halaman sebelumnya
                  },
                  child: Text('OK'),
                ),
              ],
            );
          },
        );

        // Membersihkan data pada controller teks
        noBpController.clear();
        noHpController.clear();
        emailController.clear();
      } else {
        // Pegawai gagal diperbarui
        print('Pegawai gagal diperbarui');
      }
    } catch (error) {
      print('Error: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Pegawai'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _key,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: noBpController,
                validator: (value) {
                  return value!.isEmpty ? "No Bp boleh kosong" : null;
                },
                decoration: InputDecoration(labelText: 'No. BP'),
              ),
              TextFormField(
                controller: noHpController,
                validator: (value) {
                  return value!.isEmpty ? "No Hp boleh kosong" : null;
                },
                decoration: InputDecoration(labelText: 'No. HP'),
              ),
              TextFormField(
                controller: emailController,
                validator: (value) {
                  return value!.isEmpty ? "Email boleh kosong" : null;
                },
                decoration: InputDecoration(labelText: 'Email'),
              ),
              SizedBox(height: 24.0),
              ElevatedButton(
                onPressed: () {
                  if (_key.currentState!.validate()) {
                    editPegawai(); // Panggil metode editPegawai saat tombol ditekan
                  }
                },
                child: Text('Simpan Perubahan'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
