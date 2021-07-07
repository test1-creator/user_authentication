import 'package:flutter/material.dart';
import 'package:user_authentication/widgets/drawer.dart';

class ItemsScreen extends StatelessWidget {
  ItemsScreen(this.color, this.number);

  final Color color;
  final int number;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Menu', style: TextStyle(fontSize: 30),),
        ),
      drawer: CustomDrawer(),
      backgroundColor: color,
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Item $number', style: TextStyle(fontSize: 22, color: Colors.white),),
            ],
          ),
        ],
      ),
    );
  }
}
