import 'package:flutter/material.dart';
import 'package:userbook/models/dummymodel.dart';
import 'package:userbook/screens/dummydetailscreen.dart';

class UsersList extends StatefulWidget{

  final List<DummyModel> userList;
  const UsersList({super.key,required this.userList});

  State<UsersList> createState() => _UsersListState();
}

class _UsersListState extends State<UsersList>{

  _UsersListState();
  @override
  Widget build(BuildContext context){
    return ListView.separated(
      itemBuilder: (context,index){
        DummyModel user  = widget.userList[index];
    
        return ListTile(
          leading: CircleAvatar(child: Image.network(user.image),),
          title: Text("${user.name}"),
          subtitle: Text("Blood Group :${user.bloodG}"),
          trailing: IconButton(
            onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>DummyDetailScreen(userDetail: user,)));
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