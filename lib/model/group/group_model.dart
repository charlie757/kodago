class GroupModel {
  dynamic status;
  dynamic message;
  List<Data>? data;

  GroupModel({this.status, this.message, this.data});

  GroupModel.fromJson(Map<String, dynamic> json) {
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
  dynamic name;
  dynamic alias;
  dynamic memoryUsed;
  dynamic image;
  dynamic notiTotal;
  dynamic addedOn;
  dynamic createdAt;
  dynamic updatedAt;
  dynamic isAdmin;
  dynamic groupTag;

  Data(
      {this.id,
      this.name,
      this.alias,
      this.memoryUsed,
      this.image,
      this.notiTotal,
      this.addedOn,
      this.createdAt,
      this.updatedAt,
      this.isAdmin,
      this.groupTag});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    alias = json['alias'];
    memoryUsed = json['memory_used'];
    image = json['image'];
    notiTotal = json['notiTotal'];
    addedOn = json['added_on'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    isAdmin = json['is_admin'];
    groupTag = json['groupTag'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['name'] = name;
    data['alias'] = alias;
    data['memory_used'] = memoryUsed;
    data['image'] = image;
    data['notiTotal'] = notiTotal;
    data['added_on'] = addedOn;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['is_admin'] = isAdmin;
    data['groupTag'] = groupTag;
    return data;
  }
}
