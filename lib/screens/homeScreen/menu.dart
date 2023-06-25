import 'package:flutter/material.dart';
import 'package:flutter_application_4/screens/repairScreen/repairHomeScreenShow.dart';
import 'package:flutter_application_4/screens/infoBridgeScreen/infoBridgeScreen.dart';
import 'homeScreen.dart';

class menu extends StatelessWidget {
  const menu({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Column(children: [
              Image.asset('lib/assets/images/Logo_Dong_Nai.png',
              width: 110,
              height: 110,),
              Text('CẦU ĐỒNG NAI',
              style: TextStyle(fontSize: 17),)
            ],),
          ),
          ListTile(
            leading: const Icon(Icons.map),
            title: const Text('Bản đồ'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => home()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.info),
            title: const Text('Thông tin cầu'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => infoBridgeScreen()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.check),
            title: const Text('Thông tin kiểm tra/ sửa chữa'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => repairHomeScreenShow()),
              );
            },
          ),
        ],
      ),
    );
  }
}
