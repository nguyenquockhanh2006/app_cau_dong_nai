import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:app_cau_dong_nai/views/home_views/menu.dart';
import 'package:app_cau_dong_nai/views/home_views/flutter_map_load.dart';

class home extends StatelessWidget {
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
                backgroundImage:
                    NetworkImage('https://i.imgur.com/78M9KfI.jpg'),
              ),
              // assets/logoes/logo.jpg
            ),
            //
            body: flutter_map_load(),
            ),
            );
  }
}
