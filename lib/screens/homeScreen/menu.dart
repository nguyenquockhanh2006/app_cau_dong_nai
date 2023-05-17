import 'package:flutter/material.dart';
import 'package:flutter_application_4/screens/infoBridgeScreen/detailBridgeScreen.dart';
import 'package:flutter_application_4/screens/infoBridgeScreen/infoBridgeScreen.dart';

import 'homeScreen.dart';

class menu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Text('app cầu đồng nai'),
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
          ),
          ListTile(
            leading: Icon(Icons.map),
            title: Text('Bản đồ'),
            onTap: () {
              Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => home()),
                      );
            },
          ),
          ListTile(
            leading: Icon(Icons.info),
            title: Text('Thông tin cầu'),
            onTap: () {
              Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => infoBridgeScreen()),
                      );
            },
          ),
          ListTile(
            leading: Icon(Icons.check),
            title: Text('Thông tin kiểm tra/ sửa chữa'),
            onTap: () {
              
            },
          ),
        ],
      ),
    );
  }
}
