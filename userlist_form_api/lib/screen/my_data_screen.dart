import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:userlist_form_api/model/my_data.dart';

class MyDataScreen extends StatelessWidget {
  Future<MyData> getuserData() async {
    http.Response response = await http.get('https://reqres.in/api/login');
    //print(response.body);
    return MyData.fromJson(jsonDecode(response.body));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Data Screen'),
      ),
      body: FutureBuilder(
        builder: (BuildContext context, AsyncSnapshot<MyData> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            var _userData = snapshot.data;
            return ListView.builder(
              itemBuilder: (context, index) {
                var user = _userData.data[index];
                // print(user);
                return Column(
                  children: [
                    ListTile(
                        leading: Text(user.id.toString()),
                        title: Text(user.name),
                        subtitle: Text(user.year.toString())),
                  ],
                );
              },
              itemCount: _userData.data.length,
            );
          } else {
            return Center(
              child: CupertinoActivityIndicator(),
            );
          }
        },
        future: getuserData(),
      ),
    );
  }
}
