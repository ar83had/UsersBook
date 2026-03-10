import 'package:flutter/material.dart';
import 'package:userbook/screens/signup.dart';
import 'package:userbook/screens/usersS.dart';
import 'package:userbook/widgets/circularprogression.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  

  MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool? isAuth;

  late SharedPreferences prefs;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    checkAuthStatus();

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'User Book',
      home: isAuth==null?Circularprogression():(isAuth!)?UsersScreen():SignUp(),
    );
  }

void checkAuthStatus() async{
  prefs = await SharedPreferences.getInstance();
  String? token = prefs.getString("token");

  isAuth = (token==null)?false:true;

  await Future.delayed(Duration(seconds: 2));
  setState(() {});
}

}

