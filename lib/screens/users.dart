import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class UsersScreen extends StatefulWidget{

  const UsersScreen({super.key});

  @override
  State<UsersScreen> createState()=> _UsersScreenState();
}

class _UsersScreenState extends State<UsersScreen>{

  List<Map<String,dynamic>> userList = [];
  late dynamic userApi;

  initState(){
    super.initState();
    getUserData();
  }

  Future<void> getUserData() async {
    final res= await http.get(Uri.parse("https://dummyjson.com/users"));

    if(res.statusCode == 200){
      userApi = res.body;
      userApi = json.decode(userApi);
      userList = List<Map<String,dynamic>>.from(userApi["users"]);
      debugPrint("$userList");
    }else{
      debugPrint("data not fetched terminate with status code ${res.statusCode}");
    }

    return;
  }

  @override 
  Widget build(BuildContext build){
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
      ),
    );
  }

}