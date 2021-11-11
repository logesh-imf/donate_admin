class DonationDetails {
  String itemName = "",
      itemId = "",
      donarImage = "",
      donaterId = "",
      donaterName = "",
      city = "",
      description = "",
      category = "",
      donated = "",
      state = "";
  List<String> imagesURLs = [];

  DonationDetails(
      String name,
      String did,
      String dname,
      String dimage,
      String ci,
      String des,
      String cat,
      String d,
      String iid,
      String sta,
      List<String> images) {
    itemName = name;
    donaterId = did;
    donated = d;
    donaterName = dname;
    donarImage = dimage;
    city = ci;
    description = des;
    category = cat;
    state = sta;
    itemId = iid;
    imagesURLs = images;
  }
}
