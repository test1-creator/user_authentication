import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:user_authentication/provider/auth_provider.dart';
import 'package:user_authentication/screens/signup_screen.dart';
import 'package:user_authentication/widgets/decorations.dart';
import 'package:user_authentication/widgets/main_appbar.dart';

class LoginScreen extends StatefulWidget {

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  String _email = "", _password = "";
  final _passwordFocusNode = FocusNode();
  final _loginBtnFocusNode = FocusNode();

  @override
  void dispose() {
    _passwordFocusNode.dispose();
    _loginBtnFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: mainAppBar('Login'),
      body: Center(
        child: Container(
          width: 350,
          height: 400,
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  onSaved: (value) {
                      _email = value!;
                  },
                  onFieldSubmitted: (_) {
                    FocusScope.of(context).requestFocus(_passwordFocusNode);
                  },
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
                    FocusScope.of(context).requestFocus(_loginBtnFocusNode);
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
                    focusNode: _loginBtnFocusNode,
                    onPressed: _login,
                    child: Text(
                      "Log in",
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
                    Text("Don't have an account?", style: TextStyle(fontSize: 18, color: Color(0xFF7B7B7B)),),
                    SizedBox(
                      width: 10,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => SignUpScreen()));
                      },
                      child: Text("Sign up", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }


  void _login() async {
    FocusScope.of(context).unfocus();
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      bool loggedIn = await Provider.of<AuthProvider>(context, listen: false).login(context, _email, _password);
      if(loggedIn) {
        Provider.of<AuthProvider>(context, listen: false).isLoggedIn = true;
      }
    }
  }
}
