import 'package:flutter/material.dart';

class PhotosScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          height: 500,
          width: 500,
          child: Image.asset('assets/images/pancake.png'),
        ),
      ),
    );
  }
}
