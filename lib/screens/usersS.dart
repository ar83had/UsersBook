import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:userbook/models/userM.dart';
import 'package:userbook/widgets/user_list.dart';

class UsersScreen extends StatefulWidget{

  const UsersScreen({super.key});

  @override
  State<UsersScreen> createState()=> _UsersScreenState();
}

class _UsersScreenState extends State<UsersScreen>{

  List<UsersModel> usersModelList = [];
  List<UsersModel> helperUserModelList=[];
  late dynamic userApi;

  @override
  initState(){
    super.initState();
    getUserData();
  }

  Future<void> getUserData() async {
    const String USER_URL= "https://dummyjson.com/users";
    List<Map<String,dynamic>> userList = [];

    final res= await http.get(Uri.parse(USER_URL));

    if(res.statusCode == 200){
      userApi = res.body;
      userApi = json.decode(userApi);
      userList = List<Map<String,dynamic>>.from(userApi["users"]);
      debugPrint("$userList");
      usersModelList = userList.map((el)=>UsersModel.fromJson(el)).toList();
      helperUserModelList = usersModelList;
      // filterUser(key: "country");
      setState(() {});
    }else{
      debugPrint("data not fetched terminate with status code ${res.statusCode}");
    }

    return;
  }

  void filterUser({required String key}){

    debugPrint("filter List : $key, $usersModelList");
    if(key.isNotEmpty){

      helperUserModelList.sort((a,b)=>filterUserHelper(a,b,key));
    }
    else{
      helperUserModelList = usersModelList;
    }

    debugPrint("filter List : $key, $usersModelList");
  }

  int filterUserHelper(UsersModel a, UsersModel b,String key){
    late String v1;
    late String v2;

    switch(key){

      case "bloodG":
        v1=a.bloodG;
        v2=b.bloodG;
        break;
    }

    return v1.compareTo(v2);
  }

  void searchUser({required String key}){

    debugPrint("search List : $key, $usersModelList");
    if(key.isNotEmpty){
      helperUserModelList = usersModelList
                      .where((user)=>user.name.toLowerCase().contains(key.toLowerCase()))
                      .toList();
    }
    else{
      helperUserModelList = usersModelList;
    }

    debugPrint("search List : $key, $usersModelList");

  }

  @override 
  Widget build(BuildContext build){
        return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
      ),
      body:SafeArea(
        child: Column(
          children: [
            UsersList(userList: helperUserModelList),
          ],
        ),
      )
    );
  }

}