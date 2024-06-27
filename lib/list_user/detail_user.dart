import 'package:flutter/material.dart';
import 'user.dart';

class UserDetailPage extends StatelessWidget {
  final User user;

  UserDetailPage({required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${user.firstName} ${user.lastName}'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage(user.avatar),
              ),
              SizedBox(height: 20),
              Text(
                '${user.firstName} ${user.lastName}',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text(user.email, style: TextStyle(fontSize: 18)),
            ],
          ),
        ),
      ),
    );
  }
}