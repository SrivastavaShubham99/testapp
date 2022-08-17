

class SelectbookingRequest {
  String? month;
  String? year;

  SelectbookingRequest({ this.month, this.year});

  SelectbookingRequest.fromJson(Map<String, dynamic> json) {

    month = json['month'];
    year = json['year'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['month'] = this.month;
    data['year'] = this.year;
    return data;
  }
}