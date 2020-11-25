import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_provider/provider/my_cart.dart';
import 'package:provider/provider.dart';

class MyCartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Cart List'),
      ),
      body: Consumer<MyCart>(builder: (context, snapshot, child) {
        return ListView.builder(
          itemBuilder: (context, index) {
            return Column(children: [
              Dismissible(
                background: Container(
                  color: Colors.red,
                ),
                onDismissed: (direction) {
                  Provider.of<MyCart>(context, listen: false)
                      .removeItems(index);
                },
                key: UniqueKey(),
                child: ListTile(
                  title: Text(snapshot.listitems[index]),
                ),
              )
            ]);
          },
          itemCount: snapshot.listitems.length,
        );
      }),
    );
  }
}
