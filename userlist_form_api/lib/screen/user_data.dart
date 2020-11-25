import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UserDataModel extends StatelessWidget {
  final String name;

  UserDataModel({this.url, this.name, this.email});

  final String email;
  final String url;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Data Model'),
      ),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                backgroundImage: NetworkImage(url),
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [Text(name)],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [Text(email)],
          )
        ],
      ),
    );
  }
}
