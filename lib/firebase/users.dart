import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:donate_admin/class/user.dart';

class AllUsersFirebase extends ChangeNotifier {
  bool load = false;
  bool get isLoading => load;

  List<UserDetails> allusers = [];

  Future getAllUsers() async {
    try {
      // setLoad(true);
      allusers.clear();
      await FirebaseFirestore.instance.collection('users').get().then((value) {
        value.docs.forEach((element) {
          allusers.add(UserDetails(element['name'], element['email'],
              element['image'], element['address'], element['mobile']));
        });
      });

      // setLoad(false);
    } catch (e) {
      print(e.toString());
    }
  }

  void setLoad(bool val) {
    load = val;
    notifyListeners();
  }
}
