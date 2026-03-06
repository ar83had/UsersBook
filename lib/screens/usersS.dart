
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:userbook/api/api.dart';
import 'package:userbook/screens/dummyscreen.dart';

class UsersScreen extends StatefulWidget {
  const UsersScreen({super.key});

  @override
  State<UsersScreen> createState() => _UsersScreenState();
}

class _UsersScreenState extends State<UsersScreen> {

  Map<String, dynamic>? userMap;
  late SharedPreferences prefs;

  @override
  void initState() {
    super.initState();
    getUsersData();
  }

  void getUsersData() async {

    final token = await getToken();
    final res = await API.getUsersData(token: token);

    if (res["success"] == true) {
      setState(() {
        userMap = res["data"];
      });
    } else {
      debugPrint(res["message"]);
    }
  }

  dynamic getToken() async {
    prefs = await SharedPreferences.getInstance();
    return prefs.getString("token");
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text("User Details"),
        backgroundColor: Colors.blue,
      ),

      body: userMap == null
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: SizedBox(
                width: double.infinity,
                child: Column(
                  children: [
                
                    SizedBox(height: 10,),
                    /// Profile Image
                    const CircleAvatar(
                      radius: 100,
                      backgroundImage: NetworkImage(
                        "https://images.ctfassets.net/h6goo9gw1hh6/2sNZtFAWOdP1lmQ33VwRN3/24e953b920a9cd0ff2e1d587742a2472/1-intro-photo-final.jpg?w=1200&h=992&fl=progressive&q=70&fm=jpg"
                      ),
                    ),
                
                    const SizedBox(height: 20),
                
                    /// Name
                    Text(
                      userMap!["name"],
                      style: const TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                
                    const SizedBox(height: 20),
                
                    /// Info Section
                    SizedBox(
                      width: 300,
                      child: Column(
                        children: [
                          buildInfoTile("ID", userMap!["id"].toString()),
                          buildInfoTile("Email", userMap!["email"]),
                          buildInfoTile("Mobile", userMap!["mobile"].toString()),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            
                  /// Button fixed at bottom of screen
            bottomNavigationBar: (userMap==null)?null:Padding(
              padding: const EdgeInsets.all(30),
              child: SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (_)=>DummyScreen()));
                  },
                  child: const Text(
                    "Dummy List",
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ),
            ),
    );
  }

  Widget buildInfoTile(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Text(
            "$title: ",
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),

          Expanded(
            child: Text(
              value,
              style: TextStyle(
                fontSize: 17,
              ),
            ),
          ),

        ],
      ),
    );
  }
}