import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:userlist_form_api/screen/home_page.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  Future<Map> isValidUser(String email, String password) async {
    Map requestBody = {"email": email, "password": password};

    http.Response response =
        await http.post('https://reqres.in/api/register', body: requestBody);
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      return {
        "message": data['Registration success'],
        "id": data['id'],
        "token": data['token'],
        "isRegister": true
      };
    } else {
      var data = jsonDecode(response.body);
      return {
        "message": data['Registration failed'],
        "id": "",
        "token": " ",
        "isRegister": false
      };
    }
  }

  bool porgrees = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Registration Page'),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _usernameController,
              decoration: InputDecoration(hintText: 'username'),
            ),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(hintText: 'password'),
            ),
            Builder(
              builder: (context) => RaisedButton(
                color: Colors.lightBlue,
                onPressed: () async {
                  setState(() {
                    porgrees = true;
                  });
                  Map result = await isValidUser(
                      _usernameController.text, _passwordController.text);
                  if (result['isRegister'] == false) {
                    Scaffold.of(context)
                        .showSnackBar(
                            SnackBar(content: Text(result['message'])))
                        .closed
                        .then((value) {
                      setState(() {
                        porgrees = false;
                      });
                    });
                  } else {
                    setState(() {
                      porgrees = false;
                    });
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => HomePage()));
                  }
                },
                child: Text('Register'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
