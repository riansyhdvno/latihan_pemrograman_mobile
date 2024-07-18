// ignore_for_file: prefer_const_constructors, avoid_print

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:latihan_mobile/lat_prauas/Api/Api.dart';

class AddPegawaiPage extends StatefulWidget {
  @override
  _AddPegawaiPageState createState() => _AddPegawaiPageState();
}

class _AddPegawaiPageState extends State<AddPegawaiPage> {
  TextEditingController noBpController = TextEditingController();
  TextEditingController noHpController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  final _keyForm = GlobalKey<FormState>();

// Saat tambah data berhasil, data clear dan tampil alert berhasil, dan kembali ke halaman read data Pegawai
  Future<void> addPegawai() async {
    try {
      final response = await http.post(
        Uri.parse(Api.AddPegawai),
        body: {
          'no_bp': noBpController.text,
          'no_hp': noHpController.text,
          'email': emailController.text,
        },
      );

      final responseData = json.decode(response.body);
      if (responseData['isSuccess']) {
        // Pegawai berhasil ditambahkan
        print('Pegawai berhasil ditambahkan');

        // Tampilkan dialog berhasil tambah data
        _showSuccessDialog();

        // Bersihkan inputan pada field
        noBpController.clear();
        noHpController.clear();
        emailController.clear();
      } else {
        // Pegawai gagal ditambahkan
        print('Pegawai gagal ditambahkan');

        // Tampilkan pesan kesalahan kepada pengguna
        _showErrorDialog('Gagal menambahkan pegawai. Silakan coba lagi.');
      }
    } catch (error) {
      // Tangani kesalahan dengan menampilkan pesan kesalahan yang deskriptif
      print('Error: $error');
      _showErrorDialog('Terjadi kesalahan. Silakan coba lagi.');
    }
  }

// Method untuk menampilkan dialog berhasil tambah data
  void _showSuccessDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Berhasil'),
          content: Text('Data pegawai berhasil ditambahkan.'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Tutup dialog
                Navigator.of(context).pop(); // Tutup dialog
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

// Method untuk menampilkan dialog gagal tambah data
  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Gagal'),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Tutup dialog
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tambah Pegawai'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _keyForm,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: noBpController,
                validator: (value) {
                  return value!.isEmpty ? "No Bp tidak boleh kosong" : null;
                },
                decoration: InputDecoration(labelText: 'No. BP'),
              ),
              TextFormField(
                controller: noHpController,
                validator: (value) {
                  return value!.isEmpty ? "No Hp tidak boleh kosong" : null;
                },
                decoration: InputDecoration(labelText: 'No. HP'),
              ),
              TextFormField(
                controller: emailController,
                validator: (value) {
                  return value!.isEmpty ? "Email tidak boleh kosong" : null;
                },
                decoration: InputDecoration(labelText: 'Email'),
              ),
              SizedBox(height: 24.0),
              ElevatedButton(
                onPressed: () {
                  // Validasi sebelum menambah pegawai
                  if (_keyForm.currentState!.validate()) {
                    addPegawai();
                  }
                },
                child: Text('Tambah Pegawai'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
