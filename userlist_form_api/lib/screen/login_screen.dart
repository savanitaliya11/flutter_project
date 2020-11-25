import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'home_page.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _userNameTextController = TextEditingController();

  TextEditingController _passwordTextController = TextEditingController();

  Future<Map> isValidUser(String email, String password) async {
    Map requestBody = {"email": email, "password": password};
    http.Response response =
        await http.post('https://reqres.in/api/login', body: requestBody);
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      return {"message": "done!", "token": data['token'], "isLogin": true};
    } else {
      var data = jsonDecode(response.body);
      return {"message": data['error'], "token": "", "isLogin": false};
    }
  }

  bool porgrees = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: TextField(
                  controller: _userNameTextController,
                  decoration: InputDecoration(hintText: "UserName"),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: TextField(
                  controller: _passwordTextController,
                  decoration: InputDecoration(hintText: "password"),
                ),
              ),
              Builder(
                builder: (context) => RaisedButton(
                  onPressed: () async {
                    setState(() {
                      porgrees = true;
                    });
                    Map result = await isValidUser(_userNameTextController.text,
                        _passwordTextController.text);

                    if (result['isLogin'] == false) {
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
                  child: Text("Login"),
                ),
              )
            ],
          ),
          porgrees
              ? Container(
                  color: Colors.black.withOpacity(0.5),
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: Center(
                    child: CupertinoActivityIndicator(
                      radius: 20,
                    ),
                  ),
                )
              : SizedBox()
        ],
      ),
    );
  }
}
