import 'package:flutter/material.dart';
import 'package:user_authentication/screens/items_screen.dart';
import 'package:user_authentication/screens/profile_screen.dart';

class CustomDrawer extends StatelessWidget {
  final List<Color> colorValues = [Colors.black, Colors.purple];

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 40, bottom: 20),
            child: Text('Items Drawer', style: TextStyle(fontSize: 22,),),
          ),
          Divider(),
          ListTile(onTap: () {
            Navigator.pop(context);
            Navigator.popUntil(context, (route) => route.isFirst);
          }, title: Text('Profile', style: TextStyle(fontSize: 18,))),
          Divider(),
          for(int i=0; i<colorValues.length; i++)
            Column(
              children: [
                ListTile(onTap: () {
                  Navigator.pop(context);
                  Navigator.push(context, MaterialPageRoute(builder: (context) => ItemsScreen(colorValues[i], (i+1))));
                }, title: Text('Item ${i+1}', style: TextStyle(fontSize: 18,))),
                Divider(),
              ],
            )
        ],
      ),
    );
  }
}
