import 'package:flutter/material.dart';
import 'package:donate_admin/class/donations.dart';
import 'package:donate_admin/firebase/firebase_donations.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Donations extends StatefulWidget {
  const Donations({Key? key}) : super(key: key);

  @override
  _DonationsState createState() => _DonationsState();
}

class _DonationsState extends State<Donations> {
  bool initiated = false, clickedButton = false;
  DonationDetails curDonationDetail =
      DonationDetails('', '', '', '', '', '', '', '', '', '', []);
  final _formkey = GlobalKey<FormState>();

  FirebaseDonation firebaseDonation = FirebaseDonation();

  String updateName = "",
      updateDescition = "",
      updatedCat = "",
      updatedDonate = "";

  @override
  Widget build(BuildContext context) {
    firebaseDonation.getDonationDetails();
    return StreamBuilder(
        stream: FirebaseFirestore.instance.collection('items').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return getDonationDetails(context, firebaseDonation);
          }
          return const CircularProgressIndicator();
        });
  }

  Expanded getDonationDetails(
      BuildContext context, FirebaseDonation firebaseDonation) {
    return Expanded(
        child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 400,
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: firebaseDonation.donationDetails
                  .map((e) => ListTile(
                        title: Text(e.itemName),
                        subtitle: Text(e.donaterId),
                        onTap: () {
                          setState(() {
                            initiated = true;
                            curDonationDetail = e;
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
                    SingleChildScrollView(
                        child: Container(
                            padding: EdgeInsets.all(20),
                            color: Colors.grey[350],
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(
                                  height: 20,
                                ),
                                Text(
                                  curDonationDetail.itemName,
                                  style: const TextStyle(
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.teal),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Container(
                                  width: 650,
                                  height: 250,
                                  child: Container(
                                      child: Scrollbar(
                                          child: SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: Row(
                                        children: curDonationDetail.imagesURLs
                                            .map((e) => Container(
                                                  height: 250,
                                                  margin:
                                                      const EdgeInsets.all(10),
                                                  child: Image(
                                                    fit: BoxFit.contain,
                                                    image: NetworkImage(e),
                                                  ),
                                                ))
                                            .toList()),
                                  ))),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Container(
                                  height: 2,
                                  color: Colors.grey[400],
                                ),
                                makeRow('Name', curDonationDetail.itemName),
                                Container(
                                  height: 2,
                                  color: Colors.grey[400],
                                ),
                                makeRow('Category', curDonationDetail.category),
                                Container(
                                  height: 2,
                                  color: Colors.grey[400],
                                ),
                                makeRow('Description',
                                    curDonationDetail.description),
                                Container(
                                  height: 2,
                                  color: Colors.grey[400],
                                ),
                                makeRow('Donated', curDonationDetail.donated),
                                Container(
                                  height: 2,
                                  color: Colors.grey[400],
                                ),
                                makeRow('Donater Name',
                                    curDonationDetail.donaterName),
                                Container(
                                  height: 2,
                                  color: Colors.grey[400],
                                ),
                                makeRow(
                                    'Donar Id ', curDonationDetail.donaterId),
                                Container(
                                  height: 2,
                                  color: Colors.grey[400],
                                ),
                                makeRow('City', curDonationDetail.city),
                                Container(
                                  height: 2,
                                  color: Colors.grey[400],
                                ),
                                makeRow('State', curDonationDetail.state),
                                Container(
                                  height: 2,
                                  color: Colors.grey[400],
                                ),
                                const SizedBox(
                                  height: 25,
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
                                                new BorderRadius.circular(20),
                                            color: Colors.greenAccent),
                                        child: Center(
                                          child: TextButton(
                                            child: const Text(
                                              'Edit',
                                              style: TextStyle(
                                                  color: Colors.black),
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
                                              style: TextStyle(
                                                  color: Colors.black),
                                            ),
                                            onPressed: () {},
                                          ),
                                        ))
                                  ],
                                ),
                              ],
                            ))),
                    (clickedButton)
                        ? Row(children: [
                            Expanded(
                              child: Container(
                                color: Colors.black.withOpacity(0.5),
                                child: Center(
                                  child: Container(
                                    width: 650,
                                    height: 500,
                                    color: Colors.white,
                                    child: Column(
                                      children: [
                                        const Text(
                                          'Edit Details',
                                          style: TextStyle(
                                              fontSize: 30, color: Colors.teal),
                                        ),
                                        SingleChildScrollView(
                                            child: Container(
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
                                                              Text('Item Name'),
                                                        ),
                                                        SizedBox(
                                                          width: 20,
                                                        ),
                                                        Container(
                                                            width: 280,
                                                            child:
                                                                TextFormField(
                                                              initialValue:
                                                                  curDonationDetail
                                                                      .itemName,
                                                              onSaved: (val) {
                                                                updateName = val
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
                                                          child:
                                                              Text('Category'),
                                                        ),
                                                        SizedBox(
                                                          width: 20,
                                                        ),
                                                        Container(
                                                            width: 280,
                                                            child:
                                                                TextFormField(
                                                              initialValue:
                                                                  curDonationDetail
                                                                      .category,
                                                              onSaved: (val) {
                                                                updatedCat = val
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
                                                              const EdgeInsets
                                                                  .all(10),
                                                          width: 280,
                                                          height: 100,
                                                          color:
                                                              Colors.grey[400],
                                                          child: const Text(
                                                              'Description'),
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
                                                                  curDonationDetail
                                                                      .description,
                                                              onSaved: (val) {
                                                                updateDescition =
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
                                                          child: Text(
                                                              'Is Donated'),
                                                        ),
                                                        SizedBox(
                                                          width: 20,
                                                        ),
                                                        Container(
                                                            width: 280,
                                                            child:
                                                                TextFormField(
                                                              initialValue:
                                                                  curDonationDetail
                                                                      .donated,
                                                              onSaved: (val) {
                                                                updatedDonate =
                                                                    val.toString();
                                                              },
                                                            )),
                                                      ],
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    height: 10,
                                                  ),
                                                ],
                                              )),
                                        )),
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
                                                                  'items')
                                                              .doc(
                                                                  curDonationDetail
                                                                      .itemId)
                                                              .update({
                                                            'name': updateName,
                                                            'description':
                                                                updateDescition,
                                                            'donated':
                                                                updatedDonate,
                                                            'category':
                                                                updatedCat
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
                            ),
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
        Container(width: 330, child: Text(val)),
      ],
    ),
  );
}
