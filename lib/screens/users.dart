import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:userbook/models/user.dart';

class UsersScreen extends StatefulWidget{

  const UsersScreen({super.key});

  @override
  State<UsersScreen> createState()=> _UsersScreenState();
}

class _UsersScreenState extends State<UsersScreen>{

  late List<UsersModel> usersModelList = [];
  late dynamic userApi;

  initState(){
    super.initState();
    getUserData();
  }

  Future<void> getUserData() async {
    List<Map<String,dynamic>> userList = [];
    final res= await http.get(Uri.parse("https://dummyjson.com/users"));

    if(res.statusCode == 200){
      userApi = res.body;
      userApi = json.decode(userApi);
      userList = List<Map<String,dynamic>>.from(userApi["users"]);
      usersModelList = userList.map((el)=>UsersModel.fromJson(el)).toList();
      debugPrint("$usersModelList");
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