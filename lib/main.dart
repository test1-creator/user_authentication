import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:user_authentication/provider/auth_provider.dart';
import 'package:user_authentication/screens/login_screen.dart';
import 'package:user_authentication/screens/profile_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown
  ]);
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AuthProvider>(
        create: (context) => AuthProvider(),
        builder: (context, _) {
          return MaterialApp(
            home: Consumer<AuthProvider>(
              builder: (context, auth, _) {
                return auth.isLoggedIn ? ProfileScreen() : LoginScreen();
              },

            ),
          );
        },

    );
  }
}

