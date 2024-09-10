class VerifyModel {
  dynamic status;
  dynamic message;
  Data? data;

  VerifyModel({this.status, this.message, this.data});

  VerifyModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['status'] = status;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  dynamic name;
  dynamic email;
  dynamic phoneNumber;
  dynamic userImage;
  dynamic deviceId;
  dynamic deviceType;
  dynamic token;
  dynamic userid;
  dynamic userId;

  Data(
      {this.name,
      this.email,
      this.phoneNumber,
      this.userImage,
      this.deviceId,
      this.deviceType,
      this.token,
      this.userid,
      this.userId});

  Data.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    phoneNumber = json['phone_number'];
    userImage = json['user_image'];
    deviceId = json['device_id'];
    deviceType = json['device_type'];
    token = json['token'];
    userid = json['userid'];
    userId = json['user_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['name'] = name;
    data['email'] = email;
    data['phone_number'] = phoneNumber;
    data['user_image'] = userImage;
    data['device_id'] = deviceId;
    data['device_type'] = deviceType;
    data['token'] = token;
    data['userid'] = userid;
    data['user_id'] = userId;
    return data;
  }
}
