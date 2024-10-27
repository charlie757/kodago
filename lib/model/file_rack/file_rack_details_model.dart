import 'package:flutter/material.dart';

class FileRackDetailsModel {
  dynamic status;
  dynamic message;
  Data? data;

  FileRackDetailsModel({this.status, this.message, this.data});

  FileRackDetailsModel.fromJson(Map<String, dynamic> json) {
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
  List<SheetFields>? sheetFields;
  SheetData? sheetData;
  MemoryUsed? memoryUsed;
  List<SheetFilters>? sheetFilters;
  List<SheetSorting>? sheetSorting;
  dynamic canDelete;
  dynamic viewHistory;

  Data(
      {this.sheetFields,
      this.sheetData,
      this.memoryUsed,
      this.sheetFilters,
      this.sheetSorting,
      this.canDelete,
      this.viewHistory});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['sheetFields'] != null) {
      sheetFields = <SheetFields>[];
      json['sheetFields'].forEach((v) {
        sheetFields!.add( SheetFields.fromJson(v));
      });
    }
    sheetData = json['sheetData'] != null
        ?  SheetData.fromJson(json['sheetData'])
        : null;
    memoryUsed = json['memoryUsed'] != null
        ?  MemoryUsed.fromJson(json['memoryUsed'])
        : null;
    if (json['sheet_filters'] != null) {
      sheetFilters = <SheetFilters>[];
      json['sheet_filters'].forEach((v) {
        sheetFilters!.add( SheetFilters.fromJson(v));
      });
    }
    if (json['sheet_sorting'] != null) {
      sheetSorting = <SheetSorting>[];
      json['sheet_sorting'].forEach((v) {
        sheetSorting!.add( SheetSorting.fromJson(v));
      });
    }
    canDelete = json['can_delete'];
    viewHistory = json['view_history'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    if (sheetFields != null) {
      data['sheetFields'] = sheetFields!.map((v) => v.toJson()).toList();
    }
    if (sheetData != null) {
      data['sheetData'] = sheetData!.toJson();
    }
    if (memoryUsed != null) {
      data['memoryUsed'] = memoryUsed!.toJson();
    }
    if (sheetFilters != null) {
      data['sheet_filters'] =
          sheetFilters!.map((v) => v.toJson()).toList();
    }
    if (sheetSorting != null) {
      data['sheet_sorting'] =
          sheetSorting!.map((v) => v.toJson()).toList();
    }
    data['can_delete'] = canDelete;
    data['view_history'] = viewHistory;
    return data;
  }
}

class SheetFields {
  dynamic id;
  dynamic name;
  dynamic type;
  dynamic isRequired;
  dynamic sortOrder;
  dynamic dropdownValues;
  dynamic geoTagging;
  dynamic isSearchable;
  dynamic fileRackId;
  dynamic isMultiple;
  dynamic dFOFRFields;
  dynamic valuePrefix;
  dynamic isDefaultValue;
  dynamic isDateAllow;
  dynamic nonEditable;
  dynamic isDependent;
  dynamic dependentFieldId;
  dynamic dependentFileRackFid;
  dynamic dependentFileRackFname;
  TextEditingController controller = TextEditingController();
  List list = [];
  DateTime? selectedDate;
  TimeOfDay?selectedTime;
  dynamic image;
  SheetFields(
      {this.id,
      this.name,
      this.type,
      this.isRequired,
      this.sortOrder,
      this.dropdownValues,
      this.geoTagging,
      this.isSearchable,
      this.fileRackId,
      this.isMultiple,
      this.dFOFRFields,
      this.valuePrefix,
      this.isDefaultValue,
      this.isDateAllow,
      this.nonEditable,
      this.isDependent,
      this.dependentFieldId,
      this.dependentFileRackFid,
      this.dependentFileRackFname});

  SheetFields.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    type = json['type'];
    isRequired = json['is_required'];
    sortOrder = json['sort_order'];
    dropdownValues = json['dropdown_values'];
    geoTagging = json['geo_tagging'];
    isSearchable = json['is_searchable'];
    fileRackId = json['file_rack_id'];
    isMultiple = json['is_multiple'];
    dFOFRFields = json['DFOFR_Fields'];
    valuePrefix = json['value_prefix'];
    isDefaultValue = json['is_default_value'];
    isDateAllow = json['is_date_allow'];
    nonEditable = json['non_editable'];
    isDependent = json['is_dependent'];
    dependentFieldId = json['dependent_Field_id'];
    dependentFileRackFid = json['dependent_fileRack_Fid'];
    dependentFileRackFname = json['dependent_fileRack_Fname'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['name'] = name;
    data['type'] = type;
    data['is_required'] = isRequired;
    data['sort_order'] = sortOrder;
    data['dropdown_values'] = dropdownValues;
    data['geo_tagging'] = geoTagging;
    data['is_searchable'] = isSearchable;
    data['file_rack_id'] = fileRackId;
    data['is_multiple'] = isMultiple;
    data['DFOFR_Fields'] = dFOFRFields;
    data['value_prefix'] = valuePrefix;
    data['is_default_value'] = isDefaultValue;
    data['is_date_allow'] = isDateAllow;
    data['non_editable'] = nonEditable;
    data['is_dependent'] = isDependent;
    data['dependent_Field_id'] = dependentFieldId;
    data['dependent_fileRack_Fid'] = dependentFileRackFid;
    data['dependent_fileRack_Fname'] = dependentFileRackFname;
    return data;
  }
}

class SheetData {
  dynamic total;
  List<Dbdata>? dbdata;

  SheetData({this.total, this.dbdata});

  SheetData.fromJson(Map<String, dynamic> json) {
    total = json['total'];
    if (json['dbdata'] != null) {
      dbdata = <Dbdata>[];
      json['dbdata'].forEach((v) {
        dbdata!.add(new Dbdata.fromJson(v));
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
  dynamic sheetId;
  dynamic viewPermissions;
  dynamic qrcode;
  dynamic isShow;
  dynamic createdAt;
  dynamic updatedAt;
  dynamic lastUpdate;
  dynamic username;
  dynamic userImage;
  dynamic editedByUsername;
  dynamic addedByUsername;
  dynamic imageLink;
  List<SheetFieldData>? data;
  SheetData? comments;
  dynamic actionUserId;
  dynamic actionUserName;
  dynamic actionUserImage;
  dynamic actionType;
  dynamic actionCreatedAt;

  Dbdata(
      {this.id,
      this.userId,
      this.sheetId,
      this.viewPermissions,
      this.qrcode,
      this.isShow,
      this.createdAt,
      this.updatedAt,
      this.lastUpdate,
      this.username,
      this.userImage,
      this.editedByUsername,
      this.addedByUsername,
      this.imageLink,
      this.data,
      this.comments,
      this.actionUserId,
      this.actionUserName,
      this.actionUserImage,
      this.actionType,
      this.actionCreatedAt});

  Dbdata.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    sheetId = json['sheet_id'];
    viewPermissions = json['view_permissions'];
    qrcode = json['qrcode'];
    isShow = json['is_show'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    lastUpdate = json['last_update'];
    username = json['username'];
    userImage = json['user_image'];
    editedByUsername = json['edited_by_username'];
    addedByUsername = json['added_by_username'];
    imageLink = json['imageLink'];
    if (json['data'] != null) {
      data = <SheetFieldData>[];
      json['data'].forEach((v) {
        data!.add(new SheetFieldData.fromJson(v));
      });
    }
    comments = json['comments'] != null
        ? new SheetData.fromJson(json['comments'])
        : null;
    actionUserId = json['action_user_id'];
    actionUserName = json['action_user_name'];
    actionUserImage = json['action_user_image'];
    actionType = json['action_type'];
    actionCreatedAt = json['action_created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['user_id'] = userId;
    data['sheet_id'] = sheetId;
    data['view_permissions'] = viewPermissions;
    data['qrcode'] = qrcode;
    data['is_show'] = isShow;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['last_update'] = lastUpdate;
    data['username'] = username;
    data['user_image'] = userImage;
    data['edited_by_username'] = editedByUsername;
    data['added_by_username'] = addedByUsername;
    data['imageLink'] = imageLink;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    if (comments != null) {
      data['comments'] = comments!.toJson();
    }
    data['action_user_id'] = actionUserId;
    data['action_user_name'] = actionUserName;
    data['action_user_image'] = actionUserImage;
    data['action_type'] = actionType;
    data['action_created_at'] = actionCreatedAt;
    return data;
  }
}

class SheetFieldData {
  dynamic id;
  dynamic sheetId;
  dynamic sheetDataId;
  dynamic fieldId;
  dynamic fieldValue;
  dynamic extraFieldValue;
  dynamic imageCaption;
  dynamic depdntFieldIdValue;
  dynamic fieldName;
  dynamic fieldType;
  dynamic sortOrder;
  dynamic nonEditable;
  dynamic dropdownValues;
  dynamic listColsValues;
  dynamic geoTagging;
  dynamic fileRackId;
  dynamic isMultiple;
  dynamic dFOFRFields;
  dynamic isDependent;
  dynamic valuePrefix;
  dynamic isDefaultValue;
  dynamic isDateAllow;
  dynamic unserializeData;
  dynamic dValue;
  dynamic fieldPermission;
  dynamic extraFieldValueArray;
  List<FilesData>? filesData;
  dynamic fullURL;
  dynamic dofValue;
  List<Sheetmembers>? sheetmembers;

  SheetFieldData(
      {this.id,
      this.sheetId,
      this.sheetDataId,
      this.fieldId,
      this.fieldValue,
      this.extraFieldValue,
      this.imageCaption,
      this.depdntFieldIdValue,
      this.fieldName,
      this.fieldType,
      this.sortOrder,
      this.nonEditable,
      this.dropdownValues,
      this.listColsValues,
      this.geoTagging,
      this.fileRackId,
      this.isMultiple,
      this.dFOFRFields,
      this.isDependent,
      this.valuePrefix,
      this.isDefaultValue,
      this.isDateAllow,
      this.unserializeData,
      this.dValue,
      this.fieldPermission,
      this.extraFieldValueArray,
      this.filesData,
      this.fullURL,
      this.dofValue,
      this.sheetmembers});

  SheetFieldData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    sheetId = json['sheet_id'];
    sheetDataId = json['sheet_data_id'];
    fieldId = json['field_id'];
    fieldValue = json['field_value'];
    extraFieldValue = json['extra_field_value'];
    imageCaption = json['image_caption'];
    depdntFieldIdValue = json['depdnt_field_id_value'];
    fieldName = json['field_name'];
    fieldType = json['field_type'];
    sortOrder = json['sort_order'];
    nonEditable = json['non_editable'];
    dropdownValues = json['dropdown_values'];
    listColsValues = json['list_cols_values'];
    geoTagging = json['geo_tagging'];
    fileRackId = json['file_rack_id'];
    isMultiple = json['is_multiple'];
    dFOFRFields = json['DFOFR_Fields'];
    isDependent = json['is_dependent'];
    valuePrefix = json['value_prefix'];
    isDefaultValue = json['is_default_value'];
    isDateAllow = json['is_date_allow'];
    unserializeData = json['unserialize_data'];
    dValue = json['d_value'];
    fieldPermission = json['field_permission'];
    extraFieldValueArray = json['extra_field_value_array'];
    if (json['files_data'] != null) {
      filesData = <FilesData>[];
      json['files_data'].forEach((v) {
        filesData!.add(new FilesData.fromJson(v));
      });
    }
    fullURL = json['full_URL'];
    json['dof_value'] = dofValue;
    // if (json['dof_value'] != null) {
    //   dofValue = <Null>[];
    //   json['dof_value'].forEach((v) {
    //     dofValue!.add(new Null.fromJson(v));
    //   });
    // }
    if (json['sheetmembers'] != null) {
      sheetmembers = <Sheetmembers>[];
      json['sheetmembers'].forEach((v) {
        sheetmembers!.add(new Sheetmembers.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['sheet_id'] = sheetId;
    data['sheet_data_id'] = sheetDataId;
    data['field_id'] = fieldId;
    data['field_value'] = fieldValue;
    data['extra_field_value'] = extraFieldValue;
    data['image_caption'] = imageCaption;
    data['depdnt_field_id_value'] = depdntFieldIdValue;
    data['field_name'] = fieldName;
    data['field_type'] = fieldType;
    data['sort_order'] = sortOrder;
    data['non_editable'] = nonEditable;
    data['dropdown_values'] = dropdownValues;
    data['list_cols_values'] = listColsValues;
    data['geo_tagging'] = geoTagging;
    data['file_rack_id'] = fileRackId;
    data['is_multiple'] = isMultiple;
    data['DFOFR_Fields'] = dFOFRFields;
    data['is_dependent'] = isDependent;
    data['value_prefix'] = valuePrefix;
    data['is_default_value'] = isDefaultValue;
    data['is_date_allow'] = isDateAllow;
    data['unserialize_data'] = unserializeData;
    data['d_value'] = dValue;
    data['field_permission'] = fieldPermission;
    data['extra_field_value_array'] = extraFieldValueArray;
    if (filesData != null) {
      data['files_data'] = filesData!.map((v) => v.toJson()).toList();
    }
    data['full_URL'] = fullURL;
    
      data['dof_value'] = dofValue!;
    
    if (sheetmembers != null) {
      data['sheetmembers'] = sheetmembers!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class FilesData {
  dynamic fileType;
  dynamic fileName;
  dynamic imageExtension;
  dynamic galleryType;
  dynamic mainUrl;
  dynamic imageUrl;
  dynamic mimeType;

  FilesData(
      {this.fileType,
      this.fileName,
      this.imageExtension,
      this.galleryType,
      this.mainUrl,
      this.imageUrl,
      this.mimeType});

  FilesData.fromJson(Map<String, dynamic> json) {
    fileType = json['file_type'];
    fileName = json['file_name'];
    imageExtension = json['extension'];
    galleryType = json['gallery_type'];
    mainUrl = json['mainUrl'];
    imageUrl = json['imageUrl'];
    mimeType = json['mime_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['file_type'] = fileType;
    data['file_name'] = fileName;
    data['extension'] = imageExtension;
    data['gallery_type'] = galleryType;
    data['mainUrl'] = mainUrl;
    data['imageUrl'] = imageUrl;
    data['mime_type'] = mimeType;
    return data;
  }
}

class Sheetmembers {
  dynamic id;
  dynamic name;
  dynamic userImage;
  dynamic isMemberJoin;
  dynamic joinDate;

  Sheetmembers(
      {this.id, this.name, this.userImage, this.isMemberJoin, this.joinDate});

  Sheetmembers.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    userImage = json['user_image'];
    isMemberJoin = json['is_member_join'];
    joinDate = json['join_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['name'] = name;
    data['user_image'] = userImage;
    data['is_member_join'] = isMemberJoin;
    data['join_date'] = joinDate;
    return data;
  }
}

// class Dbdata {
//   dynamic id;
//   dynamic userId;
//   dynamic sheetDataId;
//   dynamic comment;
//   dynamic createdAt;
//   dynamic updatedAt;
//   dynamic username;
//   dynamic userImage;
//   dynamic imageLink;

//   Dbdata(
//       {this.id,
//       this.userId,
//       this.sheetDataId,
//       this.comment,
//       this.createdAt,
//       this.updatedAt,
//       this.username,
//       this.userImage,
//       this.imageLink});

//   Dbdata.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     userId = json['user_id'];
//     sheetDataId = json['sheet_data_id'];
//     comment = json['comment'];
//     createdAt = json['created_at'];
//     updatedAt = json['updated_at'];
//     username = json['username'];
//     userImage = json['user_image'];
//     imageLink = json['imageLink'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['user_id'] = this.userId;
//     data['sheet_data_id'] = this.sheetDataId;
//     data['comment'] = this.comment;
//     data['created_at'] = this.createdAt;
//     data['updated_at'] = this.updatedAt;
//     data['username'] = this.username;
//     data['user_image'] = this.userImage;
//     data['imageLink'] = this.imageLink;
//     return data;
//   }
// }

class MemoryUsed {
  dynamic memoryUsed;

  MemoryUsed({this.memoryUsed});

  MemoryUsed.fromJson(Map<String, dynamic> json) {
    memoryUsed = json['memory_used'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['memory_used'] = memoryUsed;
    return data;
  }
}

class SheetFilters {
  dynamic id;
  dynamic name;
  dynamic fieldType;
  dynamic values;

  SheetFilters({this.id, this.name, this.fieldType, this.values});

  SheetFilters.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    fieldType = json['field_type'];
    json['values'] = values;
   }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['name'] = name;
    data['field_type'] = fieldType;
      data['values'] = values;
    return data;
  }
}

class Values {
  dynamic userId;
  dynamic name;

  Values({this.userId, this.name});

  Values.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = userId;
    data['name'] =name;
    return data;
  }
}



class SheetSorting {
  dynamic id;
  dynamic type;
  dynamic name;

  SheetSorting({this.id, this.type, this.name});

  SheetSorting.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    type = json['type'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['type'] = type;
    data['name'] = name;
    return data;
  }
}
