import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserInfoScreen extends StatefulWidget {
  const UserInfoScreen({Key? key}) : super(key: key);

  @override
  _UserInfoScreenState createState() => _UserInfoScreenState();
}

class _UserInfoScreenState extends State<UserInfoScreen> {
  bool isLoading = false;
  String _uid = "";
  List params = ['Name: ', 'Email: ', 'Mobile: '];
  List values = [];

  @override
  void initState() {
    if(mounted) {
      _uid = FirebaseAuth.instance.currentUser!.uid;
      Future.delayed(Duration(seconds: 1));
      getUserProfile();
    }
    super.initState();
  }

  Future<void> getUserProfile() async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection('users').where('uid', isEqualTo: _uid).get();
    if(querySnapshot.size == 1) {
      querySnapshot.docs.forEach((doc) {
        values.add(doc['name']);
        values.add(doc['email']);
        values.add(doc['mobile']);
      });
      setState(() {
        isLoading = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return isLoading ? Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            height: 20,
          ),
          Icon(Icons.account_circle, size: 100, color: Colors.blue,),
          SizedBox(
            height: 20,
          ),
          for(int i=0; i<params.length; i++)
            Container(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(params[i], style: TextStyle(fontSize: 18), textAlign: TextAlign.left,),
                      Text(values[i].toString(), style: TextStyle(fontSize: 18),),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
        ],
      ),
    ) : Center(child: CircularProgressIndicator(color: Colors.black,),);
  }
}
