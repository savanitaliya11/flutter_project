import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:userlist_form_api/model/delaymodel.dart';

class Late extends StatelessWidget {
  getlateData() async {
    http.Response response =
        await http.get('https://reqres.in/api/users?delay=3');
    return delayedFromJson(response.body);
    //var data = delayedFromJson(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            var userData = snapshot.data;
            return ListView.builder(
              itemBuilder: (context, index) {
                var user = userData.data[index];
                return Column(
                  children: [
                    ListTile(
                      leading: CircleAvatar(
                        child: Text(user.avatar),
                      ),
                      title: Text("${user.firstName} ${user.lastName}"),
                      subtitle: Text(user.email),
                    )
                  ],
                );
              },
              itemCount: userData.data.length,
            );
          } else {
            return Center(
              child: CupertinoActivityIndicator(),
            );
          }
        },
        future: getlateData(),
      ),
    );
  }
}
