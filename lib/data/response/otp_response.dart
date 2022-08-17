
class OtpResponse {
  int? statusCode;
  String? message;
  Data? data;
  String? token;
  bool? status;

  OtpResponse(
      {this.statusCode, this.message, this.data, this.token, this.status});

  OtpResponse.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    token = json['token'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['statusCode'] = this.statusCode;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['token'] = this.token;
    data['status'] = this.status;
    return data;
  }
}

class Data {
  int? id;
  Null? name;
  Null? email;
  String? mobile;

  Data({this.id, this.name, this.email, this.mobile});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    mobile = json['mobile'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['mobile'] = this.mobile;
    return data;
  }
}