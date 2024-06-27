import 'dart:convert';
import 'package:http/http.dart' as http;
import 'user.dart';

class ApiService {
  static const String apiUrl1 = 'https://reqres.in/api/users';
  static const String apiUrl2 = 'https://reqres.in/api/users?page=2';

  Future<List<User>> fetchUsers() async {
    final response1 = await http.get(Uri.parse(apiUrl1));
    final response2 = await http.get(Uri.parse(apiUrl2));

    if (response1.statusCode == 200 && response2.statusCode == 200) {
      List<dynamic> body1 = jsonDecode(response1.body)['data'];
      List<dynamic> body2 = jsonDecode(response2.body)['data'];

      List<User> users = body1.map((dynamic item) => User.fromJson(item)).toList();
      users.addAll(body2.map((dynamic item) => User.fromJson(item)).toList());

      return users;
    } else {
      throw Exception('Failed to load users');
    }
  }
}