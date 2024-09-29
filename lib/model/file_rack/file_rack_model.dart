class FileRackModel {
  dynamic status;
  dynamic message;
  Data? data;

  FileRackModel({this.status, this.message, this.data});

  FileRackModel.fromJson(Map<String, dynamic> json) {
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
  List<Sheets>? sheets;

  Data({this.sheets});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['sheets'] != null) {
      sheets = <Sheets>[];
      json['sheets'].forEach((v) {
        sheets!.add(Sheets.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (sheets != null) {
      data['sheets'] = sheets!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Sheets {
  dynamic id;
  dynamic name;
  dynamic categoryName;
  dynamic imageIcon;
  dynamic groupId;
  dynamic userId;
  dynamic createdAt;
  dynamic updatedAt;
  dynamic sheetDs;
  dynamic isSuperAdmin;
  dynamic isAdmin;
  dynamic canEdit;
  dynamic ownerName;
  dynamic qrcode;
  dynamic addViewSetting;
  dynamic isAllowMoreRecords;
  List<Members>? members;

  Sheets(
      {this.id,
      this.name,
      this.categoryName,
      this.imageIcon,
      this.groupId,
      this.userId,
      this.createdAt,
      this.updatedAt,
      this.sheetDs,
      this.isSuperAdmin,
      this.isAdmin,
      this.canEdit,
      this.ownerName,
      this.qrcode,
      this.addViewSetting,
      this.isAllowMoreRecords,
      this.members});

  Sheets.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    categoryName = json['category_name'];
    imageIcon = json['image_icon'];
    groupId = json['group_id'];
    userId = json['user_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    sheetDs = json['sheet_ds'];
    isSuperAdmin = json['is_super_admin'];
    isAdmin = json['is_admin'];
    canEdit = json['can_edit'];
    ownerName = json['owner_name'];
    qrcode = json['qrcode'];
    addViewSetting = json['add_view_setting'];
    isAllowMoreRecords = json['is_allow_more_records'];
    if (json['members'] != null) {
      members = <Members>[];
      json['members'].forEach((v) {
        members!.add(new Members.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['name'] = name;
    data['category_name'] = categoryName;
    data['image_icon'] = imageIcon;
    data['group_id'] = groupId;
    data['user_id'] = userId;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['sheet_ds'] = sheetDs;
    data['is_super_admin'] = isSuperAdmin;
    data['is_admin'] = isAdmin;
    data['can_edit'] = canEdit;
    data['owner_name'] = ownerName;
    data['qrcode'] = qrcode;
    data['add_view_setting'] = addViewSetting;
    data['is_allow_more_records'] = isAllowMoreRecords;
    if (members != null) {
      data['members'] = members!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Members {
  dynamic id;
  dynamic name;
  dynamic userImage;
  dynamic isMemberJoin;
  dynamic joinDate;
  dynamic imageLink;

  Members(
      {this.id,
      this.name,
      this.userImage,
      this.isMemberJoin,
      this.joinDate,
      this.imageLink});

  Members.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    userImage = json['user_image'];
    isMemberJoin = json['is_member_join'];
    joinDate = json['join_date'];
    imageLink = json['imageLink'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['name'] = name;
    data['user_image'] = userImage;
    data['is_member_join'] = isMemberJoin;
    data['join_date'] = joinDate;
    data['imageLink'] = imageLink;
    return data;
  }
}
