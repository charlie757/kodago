class CommentModel {
  dynamic status;
  dynamic message;
  Data? data;

  CommentModel({this.status, this.message, this.data});

  CommentModel.fromJson(Map<String, dynamic> json) {
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
  Comments? comments;

  Data({this.comments});

  Data.fromJson(Map<String, dynamic> json) {
    comments = json['comments'] != null
        ?  Comments.fromJson(json['comments'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    if (comments != null) {
      data['comments'] = comments!.toJson();
    }
    return data;
  }
}

class Comments {
  dynamic total;
  List<Dbdata>? dbdata;

  Comments({this.total, this.dbdata});

  Comments.fromJson(Map<String, dynamic> json) {
    total = json['total'];
    if (json['dbdata'] != null) {
      dbdata = <Dbdata>[];
      json['dbdata'].forEach((v) {
        dbdata!.add( Dbdata.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    data['total'] = total;
    if (dbdata != null) {
      data['dbdata'] = dbdata!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Dbdata {
  dynamic id;
  dynamic userId;
  dynamic sheetDataId;
  dynamic comment;
  dynamic createdAt;
  dynamic updatedAt;
  dynamic username;
  dynamic userImage;
  dynamic imageLink;

  Dbdata(
      {this.id,
      this.userId,
      this.sheetDataId,
      this.comment,
      this.createdAt,
      this.updatedAt,
      this.username,
      this.userImage,
      this.imageLink});

  Dbdata.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    sheetDataId = json['sheet_data_id'];
    comment = json['comment'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    username = json['username'];
    userImage = json['user_image'];
    imageLink = json['imageLink'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    data['id'] = id;
    data['user_id'] = userId;
    data['sheet_data_id'] = sheetDataId;
    data['comment'] = comment;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['username'] = username;
    data['user_image'] = userImage;
    data['imageLink'] = imageLink;
    return data;
  }
}
