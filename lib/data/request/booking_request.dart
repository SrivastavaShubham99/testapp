
class BookingRequest {
  String? date;
  String? total;

  BookingRequest({this.date, this.total});

  BookingRequest.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['date'] = this.date;
    data['total'] = this.total;
    return data;
  }
}