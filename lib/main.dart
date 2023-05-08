import 'package:flutter/material.dart';
import 'package:php_flutter/app/auth/login.dart';
import 'package:php_flutter/app/auth/signup.dart';
import 'package:php_flutter/app/home.dart';
import 'package:php_flutter/app/notes/add.dart';
import 'package:php_flutter/app/notes/edit.dart';
import 'package:shared_preferences/shared_preferences.dart';

late SharedPreferences sharedPref;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  sharedPref = await SharedPreferences.getInstance();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'PHP Project',
      theme: ThemeData(
        useMaterial3: true,
        primarySwatch: Colors.blue,
      ),
      initialRoute: sharedPref.getString('id') == null ? 'login' : 'home',
      routes: {
        'login': (context) => const Login(),
        'signup': (context) => const SignUp(),
        'home': (context) => const Home(),
        'edit': (context) => const EditNotes(),
        'add': (context) => const AddNotes(),
      },
    );
  }
}
