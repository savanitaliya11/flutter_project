import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:whatsapp_ui/screen/status_screen.dart';

import 'chat_screen.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  TabController tabController;

  Icon fabIcon;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    tabController = TabController(vsync: this, length: 4)
      ..addListener(() {
        setState(() {
          switch (tabController.index) {
            case 0:
              break;
            case 1:
              fabIcon = Icon(Icons.message);
              break;
            case 2:
              fabIcon = Icon(Icons.camera_enhance);
              break;
            case 3:
              fabIcon = Icon(Icons.call);
              break;
          }
        });
      });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 4,
        initialIndex: 1,
        child: Scaffold(
            floatingActionButton: FloatingActionButton(
              onPressed: () {},
              child: fabIcon,
              backgroundColor: Color(0xff25D366),
            ),
            appBar: AppBar(
              bottom: TabBar(
                tabs: [
                  Tab(
                    icon: Icon(Icons.camera_alt),
                  ),
                  Tab(
                    child: Text('CHATS'),
                  ),
                  Tab(
                    child: Text('STATUS'),
                  ),
                  Tab(
                    child: Text('CALLS'),
                  ),
                ],
                indicatorColor: Colors.white,
                controller: tabController,
              ),
              title: Text(
                'WhatsApp',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 22),
              ),
              actions: <Widget>[
                Padding(
                  padding: EdgeInsets.only(right: 20),
                  child: Icon(Icons.search),
                ),
                Padding(
                  padding: EdgeInsets.only(right: 15),
                  child: Icon(Icons.more_vert),
                ),
              ],
              backgroundColor: Color(0xff138C7E),
            ),
            body: TabBarView(
              children: [
                Icon(Icons.camera_alt),
                ChatScreen(),
                StatusScreen(),
                Text("Call Screen"),
              ],
              controller: tabController,
            )));
  }
}
