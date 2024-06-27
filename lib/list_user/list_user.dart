import 'package:flutter/material.dart';
import 'package:latihan_mobile/list_user/detail_user.dart';
import 'api_service.dart';
import 'user.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'User List',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: UserListPage(),
    );
  }
}

class UserListPage extends StatelessWidget {
  final ApiService apiService = ApiService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User List by Vano Coder'),
      ),
      body: FutureBuilder<List<User>>(
        future: apiService.fetchUsers(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData) {
            return Center(child: Text('No data found'));
          } else {
            List<User> users = snapshot.data!;
            return ListView.builder(
              itemCount: users.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(users[index].avatar),
                  ),
                  title: Text('${users[index].firstName} ${users[index].lastName}'),
                  subtitle: Text(users[index].email),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => UserDetailPage(user: users[index]),
                      ),
                    );
                  },
                );
              },
            );
          }
        },
      ),
    );
  }
}