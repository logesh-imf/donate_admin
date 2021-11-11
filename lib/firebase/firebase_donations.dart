import 'package:donate_admin/class/donations.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseDonation {
  List<DonationDetails> donationDetails = [];
  String itemName = "",
      itemid = "",
      donaterId = "",
      dname = "",
      address = "",
      description = "",
      category = "",
      state = "",
      dimage = "";
  List<String> imagesURLs = [];

  Future getDonationDetails() async {
    donationDetails.clear();

    await FirebaseFirestore.instance.collection('items').get().then((value) {
      value.docs.forEach((element) {
        imagesURLs = [];
        for (dynamic item in element['images']) {
          imagesURLs.add(item['url']);
        }

        donationDetails.add(
          DonationDetails(
              element['name'],
              element['email'],
              dname,
              dimage,
              element['city'],
              element['description'],
              element['category'],
              element['donated'],
              element.id,
              element['state'],
              imagesURLs),
        );
      });
    });

    for (int i = 0; i < donationDetails.length; i++) {
      FirebaseFirestore.instance
          .collection('users')
          .doc(donationDetails[i].donaterId)
          .get()
          .then((value) {
        donationDetails[i].donarImage = value.get('image');
        donationDetails[i].donaterName = value.get('name');
      });
    }
  }
}
