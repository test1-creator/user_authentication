
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:user_authentication/provider/auth_provider.dart';
import 'package:user_authentication/widgets/decorations.dart';
import 'package:user_authentication/widgets/main_appbar.dart';

class SignUpScreen extends StatefulWidget {

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {

  final _formKey = GlobalKey<FormState>();
  String _name = "";
  int _mobile = 0;
  String _email = "", _password = "";
  final _mobileFocusNode = FocusNode();
  final _emailFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();
  final _createBtnFocusNode = FocusNode();

  @override
  void dispose() {
    _mobileFocusNode.dispose();
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    _createBtnFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: mainAppBar('Sign up'),
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            width: 350,
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  SizedBox(
                    height: 50,
                  ),
                  TextFormField(
                    onSaved: (value) {
                      _name = value!;
                    },
                    onFieldSubmitted: (_) {
                      FocusScope.of(context).requestFocus(_mobileFocusNode);
                    },
                    validator: (value) {
                      if (value!.isEmpty) return 'Name required';
                      return null;
                    },
                    textCapitalization: TextCapitalization.sentences,
                    style: TextStyle(color: Colors.black, fontSize: 20),
                    cursorColor: Colors.black,
                    decoration: fieldDecoration('Enter your name'),
                    keyboardType: TextInputType.name,
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  TextFormField(
                    onSaved: (value) {
                      _mobile = int.parse(value!);
                    },
                    onFieldSubmitted: (_) {
                      FocusScope.of(context).requestFocus(_emailFocusNode);
                    },
                    focusNode: _mobileFocusNode,
                    validator: (value) {
                      if (value!.isEmpty) return 'Mobile number required';
                      if (value.length != 10)
                        return 'Invalid mobile number';
                      return null;
                    },
                    maxLength: 10,
                    style: TextStyle(color: Colors.black, fontSize: 20),
                    cursorColor: Colors.black,
                    decoration: fieldDecoration('Enter your mobile number'),
                    keyboardType: TextInputType.number,
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  TextFormField(
                    onSaved: (value) {
                      _email = value!;
                    },
                    onFieldSubmitted: (_) {
                      FocusScope.of(context).requestFocus(_passwordFocusNode);
                    },
                    focusNode: _emailFocusNode,
                    validator: (value) {
                      if (value!.isEmpty) return 'Email required';
                      if (!value.contains('@')) return 'Invalid email';
                      return null;
                    },
                    style: TextStyle(color: Colors.black, fontSize: 20),
                    cursorColor: Colors.black,
                    decoration: fieldDecoration('Enter your email'),
                    keyboardType: TextInputType.emailAddress,
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  TextFormField(
                    onSaved: (value) {
                      _password = value!;
                    },
                    onFieldSubmitted: (_) {
                      FocusScope.of(context).requestFocus(_createBtnFocusNode);
                    },
                    focusNode: _passwordFocusNode,
                    validator: (value) {
                      if (value!.isEmpty) return 'Password required';
                      if (value.length < 8)
                        return 'Password is too short, minimum 8 characters required';
                      return null;
                    },
                    obscureText: true,
                    style: TextStyle(color: Colors.black, fontSize: 20),
                    cursorColor: Colors.black,
                    decoration: fieldDecoration('Enter your password'),
                    keyboardType: TextInputType.visiblePassword,
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  //Login button
                  Container(
                    height: 80,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.blue,
                    ),
                    child: TextButton(
                      focusNode: _createBtnFocusNode,
                      onPressed: _signUp,
                      child: Text(
                        "Sign Up",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 30,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),

                  SizedBox(
                    height: 25,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Already have an account?", style: TextStyle(fontSize: 18, color: Color(0xFF7B7B7B)),),
                      SizedBox(
                        width: 10,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Text("Log in", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _signUp() async {
    bool signedUp = false;
    FocusScope.of(context).unfocus();
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      signedUp = await Provider.of<AuthProvider>(context, listen: false).signUp(context, _email, _password, _name, _mobile);
      if(signedUp) {
        Navigator.pop(context);
      }

    }
  }
}
