import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'package:donate_admin/firebase/users.dart';

class AllUsers extends StatefulWidget {
  const AllUsers({Key? key}) : super(key: key);

  @override
  _AllUsersState createState() => _AllUsersState();
}

class _AllUsersState extends State<AllUsers> {
  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<AllUsersFirebase>(context, listen: false);
    userProvider.getAllUsers();
    return StreamBuilder(
        stream: FirebaseFirestore.instance.collection('users').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return getUsers(context);
          }
          return const Center(child: CircularProgressIndicator());
        });
  }

  Row getUsers(BuildContext context) {
    final userProvider = Provider.of<AllUsersFirebase>(context, listen: false);
    return Row(
      children: [
        Container(
          width: 400,
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: userProvider.allusers
                  .map((e) => ListTile(
                        title: Text(e.name),
                        subtitle: Text(e.email),
                        onTap: () {},
                      ))
                  .toList(),
            ),
          ),
        )
      ],
    );
  }
}
