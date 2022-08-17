class OtpRequest {
  String? mobile;
  String? otp;

  OtpRequest({this.mobile, this.otp});

  OtpRequest.fromJson(Map<String, dynamic> json) {
    mobile = json['mobile'];
    otp = json['otp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['mobile'] = this.mobile;
    data['otp'] = this.otp;
    return data;
  }
}