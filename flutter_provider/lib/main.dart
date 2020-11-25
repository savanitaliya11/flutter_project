import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_provider/provider/my_cart.dart';
import 'package:flutter_provider/screens/my_cart_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => MyCart(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: Demo(),
      ),
    );
  }
}

class Demo extends StatelessWidget {
  final TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Cart'),
      ),
      body: Column(
        children: [
          Expanded(
            flex: 2,
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: TextField(
                    controller: controller,
                    decoration: InputDecoration(hintText: 'Enter your items'),
                  ),
                ),
                RaisedButton(
                  onPressed: () {
                    Provider.of<MyCart>(context, listen: false)
                        .addItems(controller.text);
                    controller.clear();
                  },
                  child: Text('Add Items'),
                ),
              ],
            ),
          ),
          Expanded(flex: 5, child: ListItem()),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FlatButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => MyCartScreen()));
                  },
                  child: CircleAvatar(
                    child: Icon(
                      Icons.add_shopping_cart,
                      color: Colors.white,
                    ),
                    backgroundColor: Colors.red,
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

class ListItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<MyCart>(builder: (context, snapshot, child) {
        return ListView.builder(
          itemBuilder: (context, index) {
            return Column(
              children: [
                ListTile(
                  title: Text(snapshot.listitems[index]),
                )
              ],
            );
          },
          itemCount: snapshot.listitems.length,
        );
      }),
    );
  }
}

// class Home extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             RaisedButton(
//               onPressed: () {
//                 Navigator.push(context,
//                     MaterialPageRoute(builder: (context) => MyHomePage()));
//               },
//               child: Text("gotoHomeWithoutPro"),
//             ),
//             SizedBox(
//               width: 20,
//             ),
//             RaisedButton(
//               onPressed: () {
//                 Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                         builder: (context) => MultiProvider(providers: [
//                               ChangeNotifierProvider(
//                                   create: (context) => ItemProvider()),
//                             ], child: MyHomePage())));
//               },
//               child: Text("gotoHomeWithPro"),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// class MyHomePage extends StatelessWidget {
//   final TextEditingController _controller = TextEditingController();
//
//   @override
//   Widget build(BuildContext context) {
//     print("build");
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("counter App"),
//       ),
//       body: Column(
//         children: [
//           Expanded(
//             flex: 1,
//             child: Column(
//               children: [
//                 Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: TextField(
//                     controller: _controller,
//                   ),
//                 ),
//                 RaisedButton(
//                   onPressed: () {
//                     Provider.of<ItemProvider>(context, listen: false)
//                         .add(_controller.text);
//                     _controller.clear();
//                   },
//                   child: Text("Add Item"),
//                 )
//               ],
//             ),
//           ),
//           Expanded(
//               flex: 5,
//               // ignore: missing_required_param
//               child: Consumer<ItemProvider>(
//                 builder: (context, itemProvider, child) {
//                   return ListView.builder(
//                     itemBuilder: (context, index) {
//                       return ListTile(
//                         title: Text("${itemProvider.item[index]}"),
//                       );
//                     },
//                     itemCount: itemProvider.item.length,
//                   );
//                 },
//               )),
//         ],
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           Navigator.push(
//               context, MaterialPageRoute(builder: (context) => SecondPage()));
//         },
//         tooltip: 'Increment',
//         child: Icon(Icons.add),
//       ), // This trailing comma makes auto-formatting nicer for build methods.
//     );
//   }
// }
//
// class SecondPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("My Cart"),
//       ),
//       body: RaisedButton(
//         onPressed: () {
//           Navigator.push(
//               context, MaterialPageRoute(builder: (context) => ThirdPage()));
//         },
//         child: Text("Next"),
//       ),
//     );
//   }
// }
//
// class ThirdPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("My Cart"),
//       ),
//       body: Consumer<ItemProvider>(
//         builder: (context, itemProvider, child) {
//           return ListView.builder(
//             itemBuilder: (context, index) {
//               return ListTile(
//                 title: Text("${itemProvider.item[index]}"),
//               );
//             },
//             itemCount: itemProvider.item.length,
//           );
//         },
//       ),
//     );
//   }
// }
