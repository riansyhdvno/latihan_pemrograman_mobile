// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:latihan_mobile/lat_prauas/Api/Api.dart';
import 'package:latihan_mobile/lat_prauas/Api/Class_pegawai.dart';
import 'package:latihan_mobile/lat_prauas/CRUD/Add.dart';
import 'package:latihan_mobile/lat_prauas/CRUD/Update.dart';

class DataPegawaiPage extends StatefulWidget {
  @override
  _DataPegawaiPageState createState() => _DataPegawaiPageState();
}

class _DataPegawaiPageState extends State<DataPegawaiPage> {
  late Future<List<dynamic>> _fetchDataPegawai;
  List<dynamic> _originalPegawaiList = []; // Simpan data asli
  List<dynamic> filteredPegawaiList = [];
  bool _isLoading = false;
  TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _fetchDataPegawai = fetchDataPegawai();
    _searchController.addListener(() {
      filterPegawaiList(_searchController.text);
    });
  }

  Future<List<dynamic>> fetchDataPegawai() async {
    try {
      setState(() {
        _isLoading = true;
      });
      final response = await http.get(Uri.parse(Api.ReadPegawai));
      final responseData = json.decode(response.body);

      if (responseData['isSuccess']) {
        setState(() {
          _isLoading = false;
          _originalPegawaiList = responseData['data']; // Simpan data asli
          filteredPegawaiList = responseData['data'];
        });
        return responseData['data'];
      } else {
        print('Gagal: ${responseData['message']}');
        throw Exception('Gagal memuat data');
      }
    } catch (error) {
      print('Error: $error');
      throw Exception('Error memuat data: $error');
    }
  }

  void filterPegawaiList(String query) {
    List<dynamic> filteredPegawai = [];
    if (query.isEmpty) {
      // Jika query kosong, tampilkan data asli
      setState(() {
        filteredPegawaiList = _originalPegawaiList;
      });
      return;
    }
    _originalPegawaiList.forEach((pegawai) {
      if (pegawai['id'].toString().contains(query) ||
          pegawai['no_bp'].toLowerCase().contains(query.toLowerCase()) ||
          pegawai['no_hp'].toLowerCase().contains(query.toLowerCase()) ||
          pegawai['email'].toLowerCase().contains(query.toLowerCase())) {
        filteredPegawai.add(pegawai);
      }
    });
    setState(() {
      filteredPegawaiList = filteredPegawai;
    });
  }

  Future<void> deletePegawai(int id) async {
    try {
      final response = await http.post(
        Uri.parse(Api.DeletePegawai),
        body: {'id': id.toString()},
      );

      final responseData = json.decode(response.body);
      if (responseData['isSuccess']) {
        // Pegawai berhasil dihapus
        print('Pegawai berhasil dihapus');
        fetchDataPegawai(); // Memuat ulang data setelah penghapusan

        // Tampilkan dialog berhasil dihapus
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Sukses'),
              content: Text('Pegawai berhasil dihapus'),
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
      } else {
        // Pegawai gagal dihapus
        print('Pegawai gagal dihapus');
      }
    } catch (error) {
      print('Error: $error');
    }
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
                Text('Apakah Anda yakin ingin menghapus data pegawai ini?'),
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
                deletePegawai(id);
                Navigator.of(context).pop(); // Tutup dialog
              },
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
        title: Text('Data Pegawai'),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          setState(() {
            _fetchDataPegawai = fetchDataPegawai();
          });
        },
        child: FutureBuilder(
          future: _fetchDataPegawai,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else {
              // Render data
              return Column(
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
                    ),
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: DataTable(
                          columns: [
                            DataColumn(label: Text('ID')),
                            DataColumn(label: Text('No. BP')),
                            DataColumn(label: Text('No. HP')),
                            DataColumn(label: Text('Email')),
                            DataColumn(label: Text('Aksi')),
                          ],
                          rows: filteredPegawaiList
                              .map(
                                (pegawai) => DataRow(
                              cells: [
                                DataCell(Text(pegawai['id'].toString())),
                                DataCell(Text(pegawai['no_bp'])),
                                DataCell(Text(pegawai['no_hp'])),
                                DataCell(Text(pegawai['email'])),
                                DataCell(
                                  Row(
                                    children: [
                                      IconButton(
                                        icon: Icon(Icons.edit),
                                        onPressed: () {
                                          FocusScope.of(context)
                                              .unfocus(); // Menutup keyboard
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  EditPegawaiPage(
                                                    data: Pegawai(
                                                      id: int.parse(
                                                          pegawai['id']),
                                                      noBp: pegawai['no_bp'],
                                                      noHp: pegawai['no_hp'],
                                                      email: pegawai['email'],
                                                    ),
                                                  ),
                                            ),
                                          ).then((value) {
                                            if (value != null && value) {
                                              // Jika berhasil menyimpan perubahan, muat ulang data pegawai
                                              setState(() {
                                                _fetchDataPegawai =
                                                    fetchDataPegawai();
                                              });
                                            }
                                          });
                                        },
                                      ),
                                      IconButton(
                                        icon: Icon(Icons.delete),
                                        onPressed: () {
                                          showDeleteConfirmationDialog(
                                              int.parse(pegawai['id']));
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          )
                              .toList(),
                        ),
                      ),
                    ),
                  ),
                ],
              );
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => AddPegawaiPage()));
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
