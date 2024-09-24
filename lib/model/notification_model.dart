class NotificationModel {
  dynamic status;
  dynamic message;
  Data? data;

  NotificationModel({this.status, this.message, this.data});

  NotificationModel.fromJson(Map<String, dynamic> json) {
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
  List<Dbdata>? dbdata;
  dynamic total;

  Data({this.dbdata, this.total});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['dbdata'] != null) {
      dbdata = <Dbdata>[];
      json['dbdata'].forEach((v) {
        dbdata!.add(Dbdata.fromJson(v));
      });
    }
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (dbdata != null) {
      data['dbdata'] = dbdata!.map((v) => v.toJson()).toList();
    }
    data['total'] = total;
    return data;
  }
}

class Dbdata {
  dynamic rowId;
  dynamic groupId;
  dynamic referId;
  dynamic dataId;
  dynamic fromUserId;
  dynamic fromUserName;
  dynamic rowClass;
  dynamic image;
  dynamic msg;
  dynamic notiType;
  ExtraParams? extraParams;
  dynamic dataStr;
  dynamic dataTime;

  Dbdata(
      {this.rowId,
      this.groupId,
      this.referId,
      this.dataId,
      this.fromUserId,
      this.fromUserName,
      this.rowClass,
      this.image,
      this.msg,
      this.notiType,
      this.extraParams,
      this.dataStr,
      this.dataTime});

  Dbdata.fromJson(Map<String, dynamic> json) {
    rowId = json['rowId'];
    groupId = json['group_id'];
    referId = json['refer_id'];
    dataId = json['data_id'];
    fromUserId = json['from_user_id'];
    fromUserName = json['from_user_name'];
    rowClass = json['rowClass'];
    image = json['image'];
    msg = json['msg'];
    notiType = json['noti_type'];
    extraParams = json['extra_params'] != null
        ? new ExtraParams.fromJson(json['extra_params'])
        : null;
    dataStr = json['dataStr'];
    dataTime = json['dataTime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['rowId'] = rowId;
    data['group_id'] = groupId;
    data['refer_id'] = referId;
    data['data_id'] = dataId;
    data['from_user_id'] = fromUserId;
    data['from_user_name'] = fromUserName;
    data['rowClass'] = rowClass;
    data['image'] = image;
    data['msg'] = msg;
    data['noti_type'] = notiType;
    if (extraParams != null) {
      data['extra_params'] = extraParams!.toJson();
    }
    data['dataStr'] = dataStr;
    data['dataTime'] = dataTime;
    return data;
  }
}

class ExtraParams {
  dynamic groupId;
  dynamic dataId;

  ExtraParams({this.groupId, this.dataId});

  ExtraParams.fromJson(Map<String, dynamic> json) {
    groupId = json['group_id'];
    dataId = json['data_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['group_id'] = groupId;
    data['data_id'] = dataId;
    return data;
  }
}
