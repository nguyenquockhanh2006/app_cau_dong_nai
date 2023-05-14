import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:app_cau_dong_nai/views/home_views/menu.dart';
import 'package:app_cau_dong_nai/views/info_bridge_views/list_info_bridge.dart';

class info_bridge_home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        endDrawer: menu(),
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: Color.fromARGB(255, 24, 92, 255),
          ),
          backgroundColor: Colors.white,
          title: Text(
            'CẦU ĐỒNG NAI',
            style: TextStyle(color: Color.fromARGB(255, 24, 92, 255)),
          ),
          leading: CircleAvatar(
            backgroundImage: NetworkImage('https://i.imgur.com/78M9KfI.jpg'),
          ),
          // assets/logoes/logo.jpg
        ),
        //
        body: list_info_bridge(),
      ),
    );
  }
}
