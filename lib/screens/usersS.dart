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

  //get data from api;
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
      setState(() {});
    }else{
      debugPrint("data not fetched terminate with status code ${res.statusCode}");
    }
    return;
  }

  //filter users base on blood group
  void filterUser({String? key}){
    if(key==null || key.toLowerCase()=="all"){
      helperUserModelList = usersModelList;
    }
    else{
      helperUserModelList=usersModelList.where((user)=>user.bloodG.toLowerCase()==key.toLowerCase()).toList();
    }
    setState(() {});
  }

  //search user
  void searchUser({required String key}){
    if(key.isNotEmpty){
      helperUserModelList = usersModelList
                      .where((user)=>user.name.toLowerCase().substring(0,key.length)==key.toLowerCase())
                      .toList();
    }
    else{
      helperUserModelList = usersModelList;
    }
    setState(() {});
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
            Padding(
              padding: const EdgeInsets.all(12),
              child: Row(
                children: [

                  //search
                  Expanded(
                    flex: 3,
                    child: TextField(
                      onChanged: (value) {
                        searchUser(key: value);
                      },
                      decoration: InputDecoration(
                        hintText: "Search",
                        prefixIcon: const Icon(Icons.search),
                        contentPadding: const EdgeInsets.symmetric(vertical: 14),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15), 
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(width: 10),

                  //filter
                  Expanded(
                    flex: 2,
                    child: DropdownButtonFormField<String>(
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.filter_list),
                        contentPadding: const EdgeInsets.symmetric(horizontal: 12),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      items: const [
                        DropdownMenuItem(value: "All", child: Text("All")),
                        DropdownMenuItem(value: "A+", child: Text("A+")),
                        DropdownMenuItem(value: "A-", child: Text("A-")),
                        DropdownMenuItem(value: "B+", child: Text("B+")),
                        DropdownMenuItem(value: "B-", child: Text("B-")),
                        DropdownMenuItem(value: "O+", child: Text("O+")),
                        DropdownMenuItem(value: "O-", child: Text("O-")),
                        DropdownMenuItem(value: "AB+", child: Text("AB+")),
                        DropdownMenuItem(value: "AB-", child: Text("AB-")),
                      ],
                      onChanged: (value) {
                        filterUser(key: value);
                      },
                    ),
                  ),
                ],
              ),
            ),

            //userList
            Expanded(child: UsersList(userList: helperUserModelList)),
          ],
        ),
      )
    );
  }

}