import 'package:donate_admin/class/user.dart';
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
  bool initiated = false;
  UserDetails curUser = UserDetails('', '', '', '', '');
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
          return const CircularProgressIndicator();
        });
  }

  Expanded getUsers(BuildContext context) {
    final userProvider = Provider.of<AllUsersFirebase>(context, listen: false);
    return Expanded(
        child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 400,
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: userProvider.allusers
                  .map((e) => ListTile(
                        leading: Container(
                          width: 100,
                          height: 100,
                          child: CircleAvatar(
                            backgroundImage: NetworkImage(e.imageURL),
                          ),
                        ),
                        title: Text(e.name),
                        subtitle: Text(e.email),
                        onTap: () {
                          setState(() {
                            initiated = true;
                            curUser = e;
                          });
                        },
                      ))
                  .toList(),
            ),
          ),
        ),
        Expanded(
            child: (initiated)
                ? Container(
                    color: Colors.grey[350],
                    padding: const EdgeInsets.all(35),
                    child: Column(
                      children: [
                        Container(
                          width: 200,
                          height: 200,
                          child: CircleAvatar(
                            backgroundImage: NetworkImage(curUser.imageURL),
                          ),
                        ),
                        SizedBox(
                          height: 50,
                        ),
                        Container(
                          height: 2,
                          color: Colors.grey[400],
                        ),
                        makeRow('Name', curUser.name),
                        Container(
                          height: 2,
                          color: Colors.grey[400],
                        ),
                        makeRow('Email', curUser.email),
                        Container(
                          height: 2,
                          color: Colors.grey[400],
                        ),
                        makeRow('Mobile', curUser.mobile),
                        Container(
                          height: 2,
                          color: Colors.grey[400],
                        ),
                        makeRow('Address', curUser.address),
                        Container(
                          height: 2,
                          color: Colors.grey[400],
                        ),
                      ],
                    ))
                : Container())
      ],
    ));
  }
}

Container makeRow(String title, String val) {
  return Container(
    child: Row(
      children: [
        Container(
          padding: EdgeInsets.all(10),
          width: 300,
          color: Colors.grey[400],
          child: Text(title),
        ),
        SizedBox(
          width: 20,
        ),
        Container(child: Container(child: Text(val)))
      ],
    ),
  );
}
