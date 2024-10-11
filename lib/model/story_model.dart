// To parse this JSON data, do
//
//     final storyModel = storyModelFromJson(jsonString);

import 'dart:convert';

List<StoryModel> storyModelFromJson(String str) =>
    List<StoryModel>.from(json.decode(str).map((x) => StoryModel.fromJson(x)));

String storyModelToJson(List<StoryModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class StoryModel {
  dynamic name;
  dynamic imageLink;
  List<Story> stories;

  StoryModel({
    required this.name,
    required this.imageLink,
    required this.stories,
  });

  factory StoryModel.fromJson(Map<String, dynamic> json) => StoryModel(
        name: json["name"],
        imageLink: json["imageLink"],
        stories:
            List<Story>.from(json["stories"].map((x) => Story.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "imageLink": imageLink,
        "stories": List<dynamic>.from(stories.map((x) => x.toJson())),
      };
}

class Story {
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
  DateTime lastUpdate;
  String dateText;
  List<Video>? video;
  String? signature;
  List<Document>? document;
  List<StoryImage>? image;

  Story(
      {required this.storyId,
      required this.sheetId,
      required this.sheetDataId,
      required this.groupId,
      required this.name,
      required this.imageLink,
      required this.groupName,
      required this.sheetName,
      required this.fieldType,
      required this.fieldName,
      required this.text,
      required this.lastUpdate,
      required this.dateText,
      this.video,
      this.signature,
      this.document,
      this.image});

  factory Story.fromJson(Map<String, dynamic> json) => Story(
        storyId: json["story_id"],
        sheetId: json["sheet_id"],
        sheetDataId: json["sheet_data_id"],
        groupId: json["group_id"],
        name: json["name"],
        imageLink: json["imageLink"],
        groupName: json["group_name"],
        sheetName: json["sheet_name"],
        fieldType: json["field_type"],
        fieldName: json["field_name"],
        text: json["text"],
        lastUpdate: DateTime.parse(json["last_update"]),
        dateText: json["date_text"],
        video: json["video"] == null
            ? []
            : List<Video>.from(json["video"]!.map((x) => Video.fromJson(x))),
        signature: json["signature"],
        document: json["document"] == null
            ? []
            : List<Document>.from(
                json["document"]!.map((x) => Document.fromJson(x))),
        image: json["image"] == null
            ? []
            : List<StoryImage>.from(
                json["image"]!.map((x) => StoryImage.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "story_id": storyId,
        "sheet_id": sheetId,
        "sheet_data_id": sheetDataId,
        "group_id": groupId,
        "name": name,
        "imageLink": imageLink,
        "group_name": groupName,
        "sheet_name": sheetName,
        "field_type": fieldType,
        "field_name": fieldName,
        "text": text,
        "last_update": lastUpdate.toIso8601String(),
        "date_text": dateText,
        "video": video == null
            ? []
            : List<dynamic>.from(video!.map((x) => x.toJson())),
        "signature": signature,
        "document": document == null
            ? []
            : List<dynamic>.from(document!.map((x) => x.toJson())),
        "image": image == null
            ? []
            : List<dynamic>.from(image!.map((x) => x.toJson())),
      };
}

class StoryImage {
  dynamic mainUrl;
  dynamic thumbUrl;
  dynamic fileName;

  StoryImage({
    this.mainUrl,
    this.thumbUrl,
    this.fileName,
  });

  factory StoryImage.fromJson(Map<String, dynamic> json) => StoryImage(
        mainUrl: json["mainURL"],
        thumbUrl: json["thumbURL"],
        fileName: json["file_name"],
      );

  Map<String, dynamic> toJson() => {
        "mainURL": mainUrl,
        "thumbURL": thumbUrl,
        "file_name": fileName,
      };
}

class Video {
  dynamic mainUrl;
  dynamic thumbUrl;
  dynamic fileName;

  Video({
    required this.mainUrl,
    required this.thumbUrl,
    required this.fileName,
  });

  factory Video.fromJson(Map<String, dynamic> json) => Video(
        mainUrl: json["mainURL"],
        thumbUrl: json["thumbURL"],
        fileName: json["file_name"],
      );

  Map<String, dynamic> toJson() => {
        "mainURL": mainUrl,
        "thumbURL": thumbUrl,
        "file_name": fileName,
      };
}

class Document {
  dynamic mainUrl;
  dynamic thumbUrl;
  dynamic fileName;

  Document({
    required this.mainUrl,
    required this.thumbUrl,
    required this.fileName,
  });

  factory Document.fromJson(Map<String, dynamic> json) => Document(
        mainUrl: json["mainURL"],
        thumbUrl: json["thumbURL"],
        fileName: json["file_name"],
      );

  Map<String, dynamic> toJson() => {
        "mainURL": mainUrl,
        "thumbURL": thumbUrl,
        "file_name": fileName,
      };
}
