import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:userlist_form_api/model/listModel.dart';

class Cool extends StatelessWidget {
  Future<WelCome> getcolorData() async {
    http.Response response = await http.get('https://reqres.in/api/unknown');
    return welComeFromJson(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Color List'),
      ),
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
                      title: Text(user.name),
                      subtitle: Text(user.year.toString()),
                      leading: CircleAvatar(
                        backgroundColor: Color(0xff53B0AE),
                      ),
                    )
                  ],
                );
              },
              itemCount: userData.data.length,
            );
          } else {
            return Center(child: CupertinoActivityIndicator());
          }
        },
        future: getcolorData(),
      ),
    );
  }
}
