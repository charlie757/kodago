class FeedsModel {
  dynamic status;
  dynamic message;
  Data? data;

  FeedsModel({this.status, this.message, this.data});

  FeedsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
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
  List<Stories>? stories;
  List<Feeds>? feeds;
  dynamic start;
  dynamic perpage;
  dynamic total;

  Data({this.stories, this.feeds, this.start, this.perpage, this.total});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['stories'] != null) {
      stories = <Stories>[];
      json['stories'].forEach((v) {
        stories!.add(Stories.fromJson(v));
      });
    }
    if (json['feeds'] != null) {
      feeds = <Feeds>[];
      json['feeds'].forEach((v) {
        feeds!.add(Feeds.fromJson(v));
      });
    }
    start = json['start'];
    perpage = json['perpage'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (stories != null) {
      data['stories'] = stories!.map((v) => v.toJson()).toList();
    }
    if (feeds != null) {
      data['feeds'] = feeds!.map((v) => v.toJson()).toList();
    }
    data['start'] = start;
    data['perpage'] = perpage;
    data['total'] = total;
    return data;
  }
}

class Story {
  dynamic storyName;
  dynamic storyImageLink;
  List<Stories>? stories;

  Story({this.storyName, this.storyImageLink, this.stories});

  Story.fromJson(Map<String, dynamic> json) {
    storyName = json['name'];
    storyImageLink = json['imageLink'];
    if (json['stories'] != null) {
      stories = <Stories>[];
      json['stories'].forEach((v) {
        stories!.add(Stories.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = storyName;
    data['imageLink'] = storyImageLink;
    if (stories != null) {
      data['stories'] = stories!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Stories {
  dynamic storyId;
  dynamic sheetId;
  dynamic sheetDataId;
  dynamic groupId;
  dynamic name;
  dynamic imageLink;
  dynamic groupName;
  dynamic sheetName;
  dynamic fieldType;
  dynamic fieldName;
  dynamic text;
  dynamic lastUpdate;
  dynamic dateText;
  List<Video>? video;
  dynamic image;

  Stories(
      {this.storyId,
      this.sheetId,
      this.sheetDataId,
      this.groupId,
      this.name,
      this.imageLink,
      this.groupName,
      this.sheetName,
      this.fieldType,
      this.fieldName,
      this.text,
      this.lastUpdate,
      this.dateText,
      this.video,
      this.image});

  Stories.fromJson(Map<String, dynamic> json) {
    storyId = json['story_id'];
    sheetId = json['sheet_id'];
    sheetDataId = json['sheet_data_id'];
    groupId = json['group_id'];
    name = json['name'];
    imageLink = json['imageLink'];
    groupName = json['group_name'];
    sheetName = json['sheet_name'];
    fieldType = json['field_type'];
    fieldName = json['field_name'];
    text = json['text'];
    lastUpdate = json['last_update'];
    dateText = json['date_text'];
    if (json['video'] != null) {
      video = <Video>[];
      json['video'].forEach((v) {
        video!.add(new Video.fromJson(v));
      });
    }
    if (json['image'] != null) {
      image = json['image'];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['story_id'] = storyId;
    data['sheet_id'] = sheetId;
    data['sheet_data_id'] = sheetDataId;
    data['group_id'] = groupId;
    data['name'] = name;
    data['imageLink'] = imageLink;
    data['group_name'] = groupName;
    data['sheet_name'] = sheetName;
    data['field_type'] = fieldType;
    data['field_name'] = fieldName;
    data['text'] = text;
    data['last_update'] = lastUpdate;
    data['date_text'] = dateText;
    if (video != null) {
      data['video'] = video!.map((v) => v.toJson()).toList();
    }
    if (image != null) {
      data['image'] = image;
    }
    return data;
  }
}

class Video {
  dynamic mainURL;
  dynamic thumbURL;
  dynamic fileName;

  Video({this.mainURL, this.thumbURL, this.fileName});

  Video.fromJson(Map<String, dynamic> json) {
    mainURL = json['mainURL'];
    thumbURL = json['thumbURL'];
    fileName = json['file_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['mainURL'] = mainURL;
    data['thumbURL'] = thumbURL;
    data['file_name'] = fileName;
    return data;
  }
}

class Feeds {
  dynamic name;
  dynamic imageLink;
  dynamic groupId;
  dynamic sheetId;
  dynamic sheetDataId;
  dynamic isSound = true;
  dynamic groupName;
  dynamic sheetName;
  dynamic fieldType;
  dynamic fieldName;
  dynamic text;
  dynamic dateText;
  dynamic commentCount;
  List<Video>? video;
  dynamic image;

  Feeds(
      {this.name,
      this.imageLink,
      this.groupId,
      this.sheetId,
      this.sheetDataId,
      this.groupName,
      this.sheetName,
      this.fieldType,
      this.fieldName,
      this.text,
      this.dateText,
      this.commentCount,
      this.video,
      this.image});

  Feeds.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    imageLink = json['imageLink'];
    groupId = json['group_id'];
    sheetId = json['sheet_id'];
    sheetDataId = json['sheet_data_id'];
    groupName = json['group_name'];
    sheetName = json['sheet_name'];
    fieldType = json['field_type'];
    fieldName = json['field_name'];
    text = json['text'];
    dateText = json['date_text'];
    commentCount = json['commentCount'];
    if (json['video'] != null) {
      video = <Video>[];
      json['video'].forEach((v) {
        video!.add(new Video.fromJson(v));
      });
    }
    if (json['image'] != null) {
      image = json['image'];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['name'] = name;
    data['imageLink'] = imageLink;
    data['group_id'] = groupId;
    data['sheet_id'] = sheetId;
    data['sheet_data_id'] = sheetDataId;
    data['group_name'] = groupName;
    data['sheet_name'] = sheetName;
    data['field_type'] = fieldType;
    data['field_name'] = fieldName;
    data['text'] = text;
    data['date_text'] = dateText;
    data['commentCount'] = commentCount;
    if (video != null) {
      data['video'] = video!.map((v) => v.toJson()).toList();
    }
    if (image != null) {
      data['image'] = image;
    }
    return data;
  }
}
