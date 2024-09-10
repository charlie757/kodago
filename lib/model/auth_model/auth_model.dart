class AuthModel {
  dynamic status;
  dynamic message;
  dynamic verifyOtp;
  Data? data;

  AuthModel({this.status, this.message, this.data});

  AuthModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    verifyOtp = json['verify_otp'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['status'] = status;
    data['verify_otp'] = verifyOtp;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  dynamic phoneNumber;
  dynamic userid;

  Data({this.phoneNumber, this.userid});

  Data.fromJson(Map<String, dynamic> json) {
    phoneNumber = json['phone_number'];
    userid = json['userid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['phone_number'] = phoneNumber;
    data['userid'] = userid;
    return data;
  }
}
