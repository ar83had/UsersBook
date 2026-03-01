import 'package:flutter/material.dart';
import 'package:userbook/models/userM.dart';
import 'package:userbook/screens/detailScreen.dart';

class UsersList extends StatefulWidget{

  final List<UsersModel> userList;
  const UsersList({super.key,required this.userList});

  State<UsersList> createState() => _UsersListState();
}

class _UsersListState extends State<UsersList>{

  _UsersListState();
  @override
  Widget build(BuildContext context){
    return ListView.separated(
      itemBuilder: (context,index){
        UsersModel user  = widget.userList[index];
    
        return ListTile(
          leading: CircleAvatar(child: Image.network(user.image),),
          title: Text("${user.name}"),
          subtitle: Text("Blood Group :${user.bloodG}"),
          trailing: IconButton(
            onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>DetailScreen(userDetail: user,)));
            }, 
            icon: Icon(Icons.info_outline),
          ),
        );
      }, 
      separatorBuilder: (context,index){
        return Divider();
      }, 
      itemCount: widget.userList.length,
    );
  }
}