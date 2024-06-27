import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';

class PegawaiScreen extends StatefulWidget {
  @override
  _PegawaiScreenState createState() => _PegawaiScreenState();
}

class _PegawaiScreenState extends State<PegawaiScreen> {
  late Future<ModelPegawai> futurePegawai;

  @override
  void initState() {
    super.initState();
    futurePegawai = fetchPegawai();
  }

  Future<ModelPegawai> fetchPegawai() async {
    final response = await http.get(Uri.parse('http://192.168.18.21/mobprolanjut/pegawai/getPegawai.php'));

    if (response.statusCode == 200) {
      return modelPegawaiFromJson(response.body);
    } else {
      throw Exception('Failed to load pegawai');
    }
  }

  Future<void> addOrUpdatePegawai({required Datum pegawai}) async {
    String url = pegawai.id.isEmpty
        ? 'http://192.168.18.21/mobprolanjut/pegawai/addPegawai.php'
        : 'http://192.168.18.21/mobprolanjut/pegawai/updatePegawai.php';

    final response = await http.post(
      Uri.parse(url),
      body: {
        if (pegawai.id.isNotEmpty) 'id': pegawai.id,
        'first_name': pegawai.firstName,
        'last_name': pegawai.lastName,
        'phone_number': pegawai.phoneNumber,
        'email': pegawai.email,
      },
    );

    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      if (jsonResponse['value'] == 1) {
        // Update futurePegawai to trigger FutureBuilder to rebuild
        setState(() {
          futurePegawai = fetchPegawai();
        });
        Fluttertoast.showToast(
          msg: pegawai.id.isEmpty ? 'Pegawai added' : 'Pegawai updated',
          backgroundColor: Colors.white,
          textColor: Colors.black,
        );
      } else {
        Fluttertoast.showToast(
          msg: jsonResponse['message'],
          backgroundColor: Colors.white,
          textColor: Colors.black,
        );
      }
    } else {
      Fluttertoast.showToast(
        msg: 'Failed to save pegawai',
        backgroundColor: Colors.white,
        textColor: Colors.black,
      );
    }
  }

  Future<void> deletePegawai(String id) async {
    final response = await http.post(
      Uri.parse('http://192.168.18.21/mobprolanjut/pegawai/deletePegawai.php'),
      body: {'id': id},
    );

    if (response.statusCode == 200) {
      // Update futurePegawai to trigger FutureBuilder to rebuild
      setState(() {
        futurePegawai = fetchPegawai();
      });
      Fluttertoast.showToast(
        msg: 'Pegawai deleted',
        backgroundColor: Colors.white,
        textColor: Colors.black,
      );
    } else {
      Fluttertoast.showToast(
        msg: 'Failed to delete pegawai',
        backgroundColor: Colors.white,
        textColor: Colors.black,
      );
    }
  }


  void showPegawaiDetail(Datum pegawai) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('${pegawai.firstName} ${pegawai.lastName}'),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Phone: ${pegawai.phoneNumber}'),
              Text('Email: ${pegawai.email}'),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Close'),
            ),
          ],
        );
      },
    );
  }

  void _showPegawaiDialog(BuildContext context, {Datum? pegawai}) {
    final _formKey = GlobalKey<FormState>();
    final TextEditingController firstNameController =
    TextEditingController(text: pegawai?.firstName ?? '');
    final TextEditingController lastNameController =
    TextEditingController(text: pegawai?.lastName ?? '');
    final TextEditingController phoneNumberController =
    TextEditingController(text: pegawai?.phoneNumber ?? '');
    final TextEditingController emailController =
    TextEditingController(text: pegawai?.email ?? '');

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(pegawai == null ? 'Add Pegawai' : 'Edit Pegawai'),
          content: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: firstNameController,
                  decoration: InputDecoration(labelText: 'First Name'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter first name';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: lastNameController,
                  decoration: InputDecoration(labelText: 'Last Name'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter last name';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: phoneNumberController,
                  decoration: InputDecoration(labelText: 'Phone Number'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter phone number';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: emailController,
                  decoration: InputDecoration(labelText: 'Email'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter email';
                    }
                    return null;
                  },
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text(pegawai == null ? 'Add' : 'Update'),
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  Navigator.of(context).pop();
                  String idToUpdate = pegawai?.id ?? ''; // Ensure idToUpdate is initialized
                  addOrUpdatePegawai(
                    pegawai: Datum(
                      id: idToUpdate,
                      firstName: firstNameController.text,
                      lastName: lastNameController.text,
                      phoneNumber: phoneNumberController.text,
                      email: emailController.text,
                    ),
                  );
                }
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
        title: Text('Latihan CRUD Pegawai'),
      ),
      body: FutureBuilder<ModelPegawai>(
        future: futurePegawai,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Failed to load pegawai'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.data.length,
              itemBuilder: (context, index) {
                return PegawaiCard(
                  pegawai: snapshot.data!.data[index],
                  onDelete: () => deletePegawai(snapshot.data!.data[index].id),
                  onEdit: () => _showPegawaiDialog(context, pegawai: snapshot.data!.data[index]),
                  onView: () => showPegawaiDetail(snapshot.data!.data[index]),
                );
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showPegawaiDialog(context), // Menggunakan context dari Scaffold
        child: Icon(Icons.add),
      ),
    );
  }
}

class PegawaiCard extends StatelessWidget {
  final Datum pegawai;
  final VoidCallback onDelete;
  final VoidCallback onEdit;
  final VoidCallback onView;

  PegawaiCard({
    required this.pegawai,
    required this.onDelete,
    required this.onEdit,
    required this.onView,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(8.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${pegawai.firstName} ${pegawai.lastName}',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              'Phone: ${pegawai.phoneNumber}',
              style: TextStyle(
                fontSize: 16.0,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            Text(
              'Email: ${pegawai.email}',
              style: TextStyle(
                fontSize: 16.0,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(height: 8.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  icon: Icon(Icons.visibility),
                  onPressed: onView,
                ),
                IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: onEdit,
                ),
                IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: onDelete,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// Model Pegawai
ModelPegawai modelPegawaiFromJson(String str) => ModelPegawai.fromJson(json.decode(str));

String modelPegawaiToJson(ModelPegawai data) => json.encode(data.toJson());

class ModelPegawai {
  bool isSuccess;
  String message;
  List<Datum> data;

  ModelPegawai({
    required this.isSuccess,
    required this.message,
    required this.data,
  });

  factory ModelPegawai.fromJson(Map<String, dynamic> json) => ModelPegawai(
    isSuccess: json["isSuccess"],
    message: json["message"],
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "isSuccess": isSuccess,
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class Datum {
  String id;
  String firstName;
  String lastName;
  String phoneNumber;
  String email;

  Datum({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.phoneNumber,
    required this.email,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    firstName: json["first_name"],
    lastName: json["last_name"],
    phoneNumber: json["phone_number"],
    email: json["email"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "first_name": firstName,
    "last_name": lastName,
    "phone_number": phoneNumber,
    "email": email,
  };
}