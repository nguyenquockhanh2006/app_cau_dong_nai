import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_application_4/screens/homeScreen/menu.dart';
import 'package:flutter_application_4/screens/infoBridgeScreen/listInfoBridge.dart';

class infoBridgeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        endDrawer: menu(),
        appBar: AppBar(
            title: Text('CẦU ĐỒNG NAI'),
            leading: CircleAvatar(
              backgroundImage: NetworkImage('https://i.imgur.com/vHZ2Ewl.png'),
            ),
          ),
        //
        body: listInfoBridge(),
      ),
    );
  }
}
