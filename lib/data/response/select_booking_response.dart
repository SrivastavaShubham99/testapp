

class SelectbookingResponse {
  bool? status;
  String? dateString;
  List<Date>? date;

  SelectbookingResponse({this.status, this.dateString, this.date});

  SelectbookingResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    dateString = json['date_string'];
    if (json['date'] != null) {
      date = <Date>[];
      json['date'].forEach((v) {
        date!.add(new Date.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['date_string'] = this.dateString;
    if (this.date != null) {
      data['date'] = this.date!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Date {
  String? date;

  Date({this.date});

  Date.fromJson(Map<String, dynamic> json) {
    date = json['date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['date'] = this.date;
    return data;
  }
}