import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:donate_admin/class/request.dart';

class FirebaseRequest {
  List<Request> requestDetails = [];

  Future getRequestDetails() async {
    await FirebaseFirestore.instance.collection('requests').get().then((value) {
      requestDetails.clear();
      value.docs.forEach((element) {
        requestDetails.add(
          Request(element.id, element['item_name'], " ",
              element['requester_id'], element['reason'], element['address']),
        );
      });
      for (int i = 0; i < requestDetails.length; i++) {
        FirebaseFirestore.instance
            .collection('users')
            .doc(requestDetails[i].requesterId)
            .get()
            .then((value) {
          requestDetails[i].requesterName = value.get('name');
          // print(value.get('name'));
        });
      }
    });
  }
}
