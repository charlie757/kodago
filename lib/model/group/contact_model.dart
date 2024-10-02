class ContactModel {
  dynamic status;
  dynamic message;
  List<Data>? data;
  List addedList = [];

  ContactModel({this.status, this.message, this.data});

  ContactModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['status'] = status;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  dynamic id;
  dynamic email;
  dynamic name;
  dynamic image;
  dynamic isAdded;
  dynamic isSelected = false;

  Data({this.id, this.email, this.name, this.image, this.isAdded});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    email = json['email'];
    name = json['name'];
    image = json['image'];
    isAdded = json['is_added'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['email'] = email;
    data['name'] = name;
    data['image'] = image;
    data['is_added'] = isAdded;
    return data;
  }
}
