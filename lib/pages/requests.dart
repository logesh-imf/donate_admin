import 'package:flutter/material.dart';
import 'package:donate_admin/class/request.dart';
import 'package:donate_admin/firebase/firebase_requests.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Requests extends StatefulWidget {
  const Requests({Key? key}) : super(key: key);

  @override
  _RequestsState createState() => _RequestsState();
}

class _RequestsState extends State<Requests> {
  bool initiated = false, clickedButton = false;
  final _formkey = GlobalKey<FormState>();
  Request curRequest = Request(' ', ' ', ' ', ' ', ' ', ' ');
  FirebaseRequest firebaseRequest = FirebaseRequest();
  String updatedName = "", updatedReason = "", updatedAddress = "";

  @override
  Widget build(BuildContext context) {
    firebaseRequest.getRequestDetails();
    return StreamBuilder(
        stream: FirebaseFirestore.instance.collection('requests').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            firebaseRequest.getRequestDetails();
            return getRequestDetails(context, firebaseRequest);
          }
          return const CircularProgressIndicator();
        });
  }

  Expanded getRequestDetails(
      BuildContext context, FirebaseRequest firebaseRequest) {
    return Expanded(
        child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 400,
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: firebaseRequest.requestDetails
                  .map((e) => ListTile(
                        title: Text(e.requestName),
                        subtitle: Text(e.requesterId),
                        onTap: () {
                          setState(() {
                            initiated = true;
                            curRequest = e;
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
                              height: 2,
                              color: Colors.grey[400],
                            ),
                            makeRow('Request Name', curRequest.requestName),
                            Container(
                              height: 2,
                              color: Colors.grey[400],
                            ),
                            makeRow('Reason', curRequest.requestReason),
                            Container(
                              height: 2,
                              color: Colors.grey[400],
                            ),
                            makeRow('Address', curRequest.address),
                            Container(
                              height: 2,
                              color: Colors.grey[400],
                            ),
                            makeRow('Requester Name', curRequest.requesterName),
                            Container(
                              height: 2,
                              color: Colors.grey[400],
                            ),
                            makeRow('Requester Id', curRequest.requesterId),
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
                                          'Update Request Details',
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
                                                          child: Text(
                                                              'Request Name'),
                                                        ),
                                                        SizedBox(
                                                          width: 20,
                                                        ),
                                                        Container(
                                                            width: 280,
                                                            child:
                                                                TextFormField(
                                                              initialValue:
                                                                  curRequest
                                                                      .requestName,
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
                                                              'Request Reason'),
                                                        ),
                                                        SizedBox(
                                                          width: 20,
                                                        ),
                                                        Container(
                                                            width: 280,
                                                            child:
                                                                TextFormField(
                                                              initialValue:
                                                                  curRequest
                                                                      .requestReason,
                                                              onSaved: (val) {
                                                                updatedReason =
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
                                                              EdgeInsets.all(
                                                                  10),
                                                          width: 280,
                                                          height: 50,
                                                          color:
                                                              Colors.grey[400],
                                                          child:
                                                              Text('Address'),
                                                        ),
                                                        SizedBox(
                                                          width: 20,
                                                        ),
                                                        Container(
                                                            width: 280,
                                                            height: 50,
                                                            child:
                                                                TextFormField(
                                                              initialValue:
                                                                  curRequest
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
                                                                  'requests')
                                                              .doc(curRequest
                                                                  .requestId)
                                                              .update({
                                                            'item_name':
                                                                updatedName,
                                                            'address':
                                                                updatedAddress,
                                                            'reason':
                                                                updatedReason,
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
          width: 200,
          height: 50,
          color: Colors.grey[400],
          child: Text(title),
        ),
        SizedBox(
          width: 20,
        ),
        Container(child: Container(width: 400, height: 50, child: Text(val)))
      ],
    ),
  );
}
