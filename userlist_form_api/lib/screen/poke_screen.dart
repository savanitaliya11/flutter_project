import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:userlist_form_api/model/my_data.dart';

class Pokemon extends StatelessWidget {
  Future<MyData> getapiData() async {
    http.Response response =
        await http.get('https://pokeapi.co/api/v2/pokemon/ditto');
    print(response.body);
    return MyData.fromJson(jsonDecode(response.body));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('PokeMon'),
      ),
      body: FutureBuilder(
        builder: (BuildContext context, AsyncSnapshot<MyData> snapshot) {
          return Column(
            children: [Text('name')],
          );
        },
        future: getapiData(),
      ),
    );
  }
}
