class ProfileModel {
  dynamic status;
  dynamic message;
  Data? data;

  ProfileModel({this.status, this.message, this.data});

  ProfileModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ?  Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
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
  dynamic haveImage;

  Data(
      {this.name,
      this.email,
      this.phoneNumber,
      this.userImage,
      this.haveImage});

  Data.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    phoneNumber = json['phone_number'];
    userImage = json['user_image'];
    haveImage = json['haveImage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    data['name'] = name;
    data['email'] = email;
    data['phone_number'] = phoneNumber;
    data['user_image'] = userImage;
    data['haveImage'] = haveImage;
    return data;
  }
}
