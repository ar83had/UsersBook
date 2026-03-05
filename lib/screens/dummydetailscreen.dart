import 'package:flutter/material.dart';
import 'package:userbook/models/dummymodel.dart';

class DummyDetailScreen extends StatelessWidget {
  final DummyModel userDetail;

  const DummyDetailScreen({super.key, required this.userDetail});

  @override
  Widget build(BuildContext context) {
    final fullName =
        "${userDetail.firstName} ${userDetail.maidenName} ${userDetail.lastName}";

    final address =
        "${userDetail.address["address"]}, ${userDetail.address["city"]}, "
        "${userDetail.address["state"]}, ${userDetail.address["country"]}";

    return Scaffold(
      appBar: AppBar(
        title: const Text("User Details"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [

            /// Profile Image
            CircleAvatar(
              radius: 60,
              backgroundImage: NetworkImage(userDetail.image),
            ),

            const SizedBox(height: 20),

            /// Full Name
            Text(
              fullName,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 20),

            /// Info Section
            buildInfoTile("Age", userDetail.age.toString()),
            buildInfoTile("Gender", userDetail.gender),
            buildInfoTile("Email", userDetail.email),
            buildInfoTile("Phone", userDetail.phone),
            buildInfoTile("Blood Group", userDetail.bloodG),
            buildInfoTile("Address", address),
          ],
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
            ),
          ),
          Expanded(
            child: Text(value),
          ),
        ],
      ),
    );
  }
}