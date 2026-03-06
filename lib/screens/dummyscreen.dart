import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import 'package:userbook/models/dummymodel.dart';
import 'package:userbook/widgets/circularprogression.dart';
import 'package:userbook/widgets/user_list.dart';
import 'package:userbook/api/api.dart';


class DummyScreen extends StatefulWidget{

  const DummyScreen({super.key});

  @override
  State<DummyScreen> createState()=> _DummyScreenState();
}


class _DummyScreenState extends State<DummyScreen>{

  List<DummyModel>? DummyModelList;
  List<DummyModel>? helperUserModelList;

  @override
  initState(){
    super.initState();
    getUserData();
  }

  //get data from api;
  Future<void> getUserData() async {
    List<Map<String,dynamic>> userList = [];
    final res = await API.getDummyData();

    if(res.statusCode == 200){
      userList = List<Map<String,dynamic>>.from(jsonDecode(res.body)["users"]);
      debugPrint("$userList");
      DummyModelList = userList.map((el)=>DummyModel.fromJson(el)).toList();
      await Future.delayed(Duration(seconds: 2));
      helperUserModelList = DummyModelList;
      setState(() {});
    }else{
      debugPrint("data not fetched terminate with status code ${res.statusCode}");
    }
    return;
  }

  //filter users base on blood group
  void filterUser({String? key}){
    if(key==null || key.toLowerCase()=="all"){
      helperUserModelList = DummyModelList;
    }
    else{
      helperUserModelList=DummyModelList!.where((user)=>user.bloodG.toLowerCase()==key.toLowerCase()).toList();
    }
    setState(() {});
  }

  //search user
  void searchUser({required String key}){
    if(key.isNotEmpty){
      helperUserModelList = DummyModelList!
                      .where((user)=>user.name.toLowerCase().substring(0,key.length)==key.toLowerCase())
                      .toList();
    }
    else{
      helperUserModelList = DummyModelList;
    }
    setState(() {});
  }

  @override 
  Widget build(BuildContext build){
      return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
      ),
      body: (helperUserModelList==null)?
      Circularprogression():
      SafeArea(
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
            Expanded(child: UsersList(userList: helperUserModelList!)),
          ],
        ),
      )
    );
  }

}