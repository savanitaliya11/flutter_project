import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:userlist_form_api/model/userModel.dart';
import 'package:userlist_form_api/screen/user_data.dart';

class HomePage extends StatelessWidget {
  Future<UserData> getUserData() async {
    http.Response response =
        await http.get('https://reqres.in/api/users?page=2');
    return UserData.fromJson(jsonDecode(response.body));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Users Data"),
      ),
      body: FutureBuilder(
        builder: (BuildContext context, AsyncSnapshot<UserData> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            var _userData = snapshot.data;
            return ListView.builder(
              itemBuilder: (context, index) {
                var user = _userData.data[index];

                return Column(
                  children: [
                    ListTile(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => UserDataModel(
                                name: "${user.firstName} ${user.lastName}",
                                email: user.email,
                                url: user.avatar,
                              ),
                              // settings: RouteSettings(arguments: {
                              //   'name': "${user.firstName} ${user.lastName}",
                              //   'email': 'user.email',
                              //   'url': 'user.avatar',
                              // }
                            ));
                      },
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(user.avatar),
                      ),
                      title: Text("${user.firstName} ${user.lastName}"),
                      subtitle: Text(user.email),
                    ),
                    Divider(
                      height: 0,
                    )
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
        future: getUserData(),
      ),
    );
  }
}
