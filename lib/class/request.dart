class Request {
  String requestId = "",
      requestName = "",
      requesterName = " ",
      requesterId = " ",
      requestReason = "",
      address = "";
  Request(String id, String name, String rname, String rid, String reason,
      String adr) {
    requestId = id;
    requestName = name;
    requesterId = rid;
    requesterName = rname;
    requestReason = reason;
    address = adr;
  }
}
