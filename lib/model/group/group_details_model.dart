class GroupDetailsModel {
  dynamic status;
  dynamic message;
  Data? data;

  GroupDetailsModel({this.status, this.message, this.data});

  GroupDetailsModel.fromJson(Map<String, dynamic> json) {
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
  GroupDetail? groupDetail;
  LoginUserData? loginUserData;

  Data({this.groupDetail, this.loginUserData});

  Data.fromJson(Map<String, dynamic> json) {
    groupDetail = json['groupDetail'] != null
        ? GroupDetail.fromJson(json['groupDetail'])
        : null;
    loginUserData = json['loginUserData'] != null
        ? LoginUserData.fromJson(json['loginUserData'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (groupDetail != null) {
      data['groupDetail'] = groupDetail!.toJson();
    }
    if (loginUserData != null) {
      data['loginUserData'] = loginUserData!.toJson();
    }
    return data;
  }
}

class GroupDetail {
  dynamic id;
  dynamic name;
  dynamic alias;
  dynamic image;
  dynamic disabledFilerack;
  dynamic userId;
  dynamic isAdmin;
  dynamic createdAt;
  dynamic updatedAt;
  List<Members>? members;
  dynamic imageLink;
  dynamic shareLink;

  GroupDetail(
      {this.id,
      this.name,
      this.alias,
      this.image,
      this.disabledFilerack,
      this.userId,
      this.isAdmin,
      this.createdAt,
      this.updatedAt,
      this.members,
      this.imageLink,
      this.shareLink});

  GroupDetail.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    alias = json['alias'];
    image = json['image'];
    disabledFilerack = json['disabled_filerack'];
    userId = json['user_id'];
    isAdmin = json['is_admin'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    if (json['members'] != null) {
      members = <Members>[];
      json['members'].forEach((v) {
        members!.add(Members.fromJson(v));
      });
    }
    imageLink = json['imageLink'];
    shareLink = json['shareLink'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['name'] = name;
    data['alias'] = alias;
    data['image'] = image;
    data['disabled_filerack'] = disabledFilerack;
    data['user_id'] = userId;
    data['is_admin'] = isAdmin;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    if (members != null) {
      data['members'] = members!.map((v) => v.toJson()).toList();
    }
    data['imageLink'] = imageLink;
    data['shareLink'] = shareLink;
    return data;
  }
}

class Members {
  dynamic id;
  dynamic name;
  dynamic email;
  dynamic phoneNumber;
  dynamic userImage;
  dynamic isOnline;
  dynamic updatedAt;
  dynamic isAdmin;
  dynamic joinDate;
  dynamic memberJoinId;
  dynamic unreadMsgCount;
  dynamic imageLink;

  Members(
      {this.id,
      this.name,
      this.email,
      this.phoneNumber,
      this.userImage,
      this.isOnline,
      this.updatedAt,
      this.isAdmin,
      this.joinDate,
      this.memberJoinId,
      this.unreadMsgCount,
      this.imageLink});

  Members.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phoneNumber = json['phone_number'];
    userImage = json['user_image'];
    isOnline = json['is_online'];
    updatedAt = json['updated_at'];
    isAdmin = json['is_admin'];
    joinDate = json['join_date'];
    memberJoinId = json['member_join_id'];
    unreadMsgCount = json['unread_msg_count'];
    imageLink = json['imageLink'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['name'] = name;
    data['email'] = email;
    data['phone_number'] = phoneNumber;
    data['user_image'] = userImage;
    data['is_online'] = isOnline;
    data['updated_at'] = updatedAt;
    data['is_admin'] = isAdmin;
    data['join_date'] = joinDate;
    data['member_join_id'] = memberJoinId;
    data['unread_msg_count'] = unreadMsgCount;
    data['imageLink'] = imageLink;
    return data;
  }
}

class LoginUserData {
  dynamic id;
  dynamic name;
  dynamic email;
  dynamic phoneNumber;
  dynamic changePhoneOtp;
  dynamic phoneNumberChange;
  dynamic userImage;
  dynamic token;
  dynamic appversion;
  dynamic apiversion;
  dynamic deviceType;
  dynamic deviceId;
  dynamic isOnline;
  dynamic status;
  dynamic createdAt;
  dynamic updatedAt;
  dynamic imageLink;

  LoginUserData(
      {this.id,
      this.name,
      this.email,
      this.phoneNumber,
      this.changePhoneOtp,
      this.phoneNumberChange,
      this.userImage,
      this.token,
      this.appversion,
      this.apiversion,
      this.deviceType,
      this.deviceId,
      this.isOnline,
      this.status,
      this.createdAt,
      this.updatedAt,
      this.imageLink});

  LoginUserData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phoneNumber = json['phone_number'];
    changePhoneOtp = json['change_phone_otp'];
    phoneNumberChange = json['phone_number_change'];
    userImage = json['user_image'];
    token = json['token'];
    appversion = json['appversion'];
    apiversion = json['apiversion'];
    deviceType = json['device_type'];
    deviceId = json['device_id'];
    isOnline = json['is_online'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    imageLink = json['imageLink'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['name'] = name;
    data['email'] = email;
    data['phone_number'] = phoneNumber;
    data['change_phone_otp'] = changePhoneOtp;
    data['phone_number_change'] = phoneNumberChange;
    data['user_image'] = userImage;
    data['token'] = token;
    data['appversion'] = appversion;
    data['apiversion'] = apiversion;
    data['device_type'] = deviceType;
    data['device_id'] = deviceId;
    data['is_online'] = isOnline;
    data['status'] = status;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['imageLink'] = imageLink;
    return data;
  }
}
