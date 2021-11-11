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
  bool initiated = false, clickedButton = false;
  UserDetails curUser = UserDetails('', '', '', '', '');
  final _formkey = GlobalKey<FormState>();

  String updatedName = "",
      updatedMobile = "",
      updatedAddress = "",
      updatedEmail = "";

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
                ? Stack(children: [
                    Container(
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
                            const SizedBox(
                              height: 25,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Container(
                                    margin: EdgeInsets.all(8),
                                    width: 150,
                                    height: 40,
                                    decoration: BoxDecoration(
                                        boxShadow: [
                                          BoxShadow(
                                              color: Colors.grey,
                                              spreadRadius: 3,
                                              blurRadius: 5)
                                        ],
                                        borderRadius:
                                            new BorderRadius.circular(20),
                                        color: Colors.greenAccent),
                                    child: Center(
                                      child: TextButton(
                                        child: const Text(
                                          'Edit',
                                          style: TextStyle(color: Colors.black),
                                        ),
                                        onPressed: () {
                                          setState(() {
                                            clickedButton = true;
                                          });
                                        },
                                      ),
                                    )),
                                Container(
                                    margin: EdgeInsets.all(8),
                                    width: 150,
                                    height: 40,
                                    decoration: BoxDecoration(
                                        boxShadow: [
                                          BoxShadow(
                                              color: Colors.grey,
                                              spreadRadius: 3,
                                              blurRadius: 5)
                                        ],
                                        borderRadius:
                                            new BorderRadius.circular(20),
                                        color: Colors.redAccent),
                                    child: Center(
                                      child: TextButton(
                                        child: const Text(
                                          'Delete',
                                          style: TextStyle(color: Colors.black),
                                        ),
                                        onPressed: () {},
                                      ),
                                    ))
                              ],
                            ),
                          ],
                        )),
                    (clickedButton)
                        ? Row(children: [
                            Expanded(
                              child: Container(
                                color: Colors.black.withOpacity(0.5),
                                child: Center(
                                  child: Container(
                                    width: 650,
                                    height: 400,
                                    color: Colors.white,
                                    child: Column(
                                      children: [
                                        const Text(
                                          'Update User Details',
                                          style: TextStyle(
                                              fontSize: 30, color: Colors.teal),
                                        ),
                                        Container(
                                          padding: EdgeInsets.all(10),
                                          child: Form(
                                              key: _formkey,
                                              child: Column(
                                                children: [
                                                  SizedBox(
                                                    height: 25,
                                                  ),
                                                  Container(
                                                    child: Row(
                                                      children: [
                                                        Container(
                                                          padding:
                                                              EdgeInsets.all(
                                                                  10),
                                                          width: 280,
                                                          height: 50,
                                                          color:
                                                              Colors.grey[400],
                                                          child:
                                                              Text('User Name'),
                                                        ),
                                                        SizedBox(
                                                          width: 20,
                                                        ),
                                                        Container(
                                                            width: 280,
                                                            child:
                                                                TextFormField(
                                                              initialValue:
                                                                  curUser.name,
                                                              onSaved: (val) {
                                                                updatedName = val
                                                                    .toString();
                                                              },
                                                            )),
                                                      ],
                                                    ),
                                                  ),
                                                  Container(
                                                    child: Row(
                                                      children: [
                                                        Container(
                                                          padding:
                                                              EdgeInsets.all(
                                                                  10),
                                                          width: 280,
                                                          height: 50,
                                                          color:
                                                              Colors.grey[400],
                                                          child: Text(
                                                              'User Email'),
                                                        ),
                                                        SizedBox(
                                                          width: 20,
                                                        ),
                                                        Container(
                                                            width: 280,
                                                            child:
                                                                TextFormField(
                                                              initialValue:
                                                                  curUser.email,
                                                              onSaved: (val) {
                                                                updatedEmail = val
                                                                    .toString();
                                                              },
                                                            )),
                                                      ],
                                                    ),
                                                  ),
                                                  Container(
                                                    child: Row(
                                                      children: [
                                                        Container(
                                                          padding:
                                                              EdgeInsets.all(
                                                                  10),
                                                          width: 280,
                                                          height: 50,
                                                          color:
                                                              Colors.grey[400],
                                                          child: Text('Mobile'),
                                                        ),
                                                        SizedBox(
                                                          width: 20,
                                                        ),
                                                        Container(
                                                            width: 280,
                                                            child:
                                                                TextFormField(
                                                              initialValue:
                                                                  curUser
                                                                      .mobile,
                                                              onSaved: (val) {
                                                                updatedMobile =
                                                                    val.toString();
                                                              },
                                                            )),
                                                      ],
                                                    ),
                                                  ),
                                                  Container(
                                                    child: Row(
                                                      children: [
                                                        Container(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(10),
                                                          width: 280,
                                                          height: 100,
                                                          color:
                                                              Colors.grey[400],
                                                          child: const Text(
                                                              'Address'),
                                                        ),
                                                        const SizedBox(
                                                          width: 20,
                                                        ),
                                                        Container(
                                                            width: 280,
                                                            child:
                                                                TextFormField(
                                                              maxLines: 4,
                                                              initialValue:
                                                                  curUser
                                                                      .address,
                                                              onSaved: (val) {
                                                                updatedAddress =
                                                                    val.toString();
                                                              },
                                                            )),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              )),
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Container(
                                                margin: EdgeInsets.all(8),
                                                width: 150,
                                                height: 40,
                                                decoration: BoxDecoration(
                                                    boxShadow: [
                                                      BoxShadow(
                                                          color: Colors.grey,
                                                          spreadRadius: 3,
                                                          blurRadius: 5)
                                                    ],
                                                    borderRadius:
                                                        new BorderRadius
                                                            .circular(20),
                                                    color: Colors.redAccent),
                                                child: Center(
                                                  child: TextButton(
                                                    child: const Text(
                                                      'Cancel',
                                                      style: TextStyle(
                                                          color: Colors.black),
                                                    ),
                                                    onPressed: () {
                                                      setState(() {
                                                        clickedButton = false;
                                                      });
                                                    },
                                                  ),
                                                )),
                                            Container(
                                                margin: EdgeInsets.all(8),
                                                width: 150,
                                                height: 40,
                                                decoration: BoxDecoration(
                                                    boxShadow: [
                                                      BoxShadow(
                                                          color: Colors.grey,
                                                          spreadRadius: 3,
                                                          blurRadius: 5)
                                                    ],
                                                    borderRadius:
                                                        new BorderRadius
                                                            .circular(20),
                                                    color: Colors.greenAccent),
                                                child: Center(
                                                  child: TextButton(
                                                      child: const Text(
                                                        'Update',
                                                        style: TextStyle(
                                                            color:
                                                                Colors.black),
                                                      ),
                                                      onPressed: () async {
                                                        try {
                                                          _formkey.currentState!
                                                              .save();
                                                          await FirebaseFirestore
                                                              .instance
                                                              .collection(
                                                                  'users')
                                                              .doc(
                                                                  curUser.email)
                                                              .update({
                                                            'name': updatedName,
                                                            'mobile':
                                                                updatedMobile,
                                                            'address':
                                                                updatedAddress,
                                                            'email':
                                                                updatedEmail
                                                          }).then((value) =>
                                                                  print(
                                                                      'Updated'));
                                                        } catch (e) {
                                                          print(e.toString());
                                                        }

                                                        setState(() {
                                                          clickedButton = false;
                                                        });
                                                      }),
                                                ))
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ])
                        : Container(),
                  ])
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
