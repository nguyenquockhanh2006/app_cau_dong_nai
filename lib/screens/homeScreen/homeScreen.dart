import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_application_4/screens/homeScreen/mapScreen.dart';
import 'package:flutter_application_4/screens/homeScreen/listScreen.dart';
import 'package:flutter_application_4/screens/homeScreen/menu.dart';

class home extends StatelessWidget {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorKey: navigatorKey,
      home: Scaffold(
        appBar: AppBar(
          title: Text('CẦU ĐỒNG NAI'),
          leading: CircleAvatar(
            backgroundImage: NetworkImage('https://i.imgur.com/vHZ2Ewl.png'),
          ),
        ),
        endDrawer: menu(),
        body: Container(
          child: flutter_map_load(),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => {
            navigatorKey.currentState?.push(
              MaterialPageRoute(builder: (context) => list_info_bridge()),
            ),
          },
          child: Icon(Icons.list),
          backgroundColor: Colors.blue,
        ),
      ),
    );
  }
}

class MyNewPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('My New Page')),
      body: Center(
        child: Text('This is my new page'),
      ),
    );
  }
}
