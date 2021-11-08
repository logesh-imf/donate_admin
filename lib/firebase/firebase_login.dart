import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseLogin {
  String id = "", pass = "";
  bool _exist = false;

  bool get isAdminExist => _exist;

  FirebaseLogin(String i, String p) {
    id = i;
    pass = p;
  }

  Future login() async {
    CollectionReference adminuser =
        FirebaseFirestore.instance.collection('admin');
    var docRef = await adminuser
        .where('email', isEqualTo: id)
        .where('password', isEqualTo: pass)
        .get();

    if (docRef.size == 0) {
      _exist = false;
    } else {
      _exist = true;
    }
  }
}
