class PostMoreDataModel {
  dynamic status;
  dynamic message;
  Data? data;

  PostMoreDataModel({this.status, this.message, this.data});

  PostMoreDataModel.fromJson(Map<String, dynamic> json) {
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
  dynamic addToStory;

  Data({this.sheetFields, this.addToStory});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['sheetFields'] != null) {
      sheetFields = <SheetFields>[];
      json['sheetFields'].forEach((v) {
        sheetFields!.add(new SheetFields.fromJson(v));
      });
    }
    addToStory = json['add_to_story'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    if (sheetFields != null) {
      data['sheetFields'] = sheetFields!.map((v) => v.toJson()).toList();
    }
    data['add_to_story'] = addToStory;
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
  ExistData? existData;
  dynamic fieldPermission;
  List<Sheetmembers>? sheetmembers;

  SheetFields(
      {this.id,
      this.name,
      this.type,
      this.isRequired,
      this.sortOrder,
      this.dropdownValues,
      this.geoTagging,
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
      this.dependentFileRackFname,
      this.existData,
      this.fieldPermission,
      this.sheetmembers});

  SheetFields.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    type = json['type'];
    isRequired = json['is_required'];
    sortOrder = json['sort_order'];
    dropdownValues = json['dropdown_values'];
    geoTagging = json['geo_tagging'];
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
    existData = json['exist_data'] != null
        ? new ExistData.fromJson(json['exist_data'])
        : null;
    fieldPermission = json['field_permission'];
    if (json['sheetmembers'] != null) {
      sheetmembers = <Sheetmembers>[];
      json['sheetmembers'].forEach((v) {
        sheetmembers!.add(new Sheetmembers.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    data['id'] = id;
    data['name'] = name;
    data['type'] = type;
    data['is_required'] = isRequired;
    data['sort_order'] = sortOrder;
    data['dropdown_values'] = dropdownValues;
    data['geo_tagging'] = geoTagging;
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
    if (existData != null) {
      data['exist_data'] = existData!.toJson();
    }
    data['field_permission'] = fieldPermission;
    if (sheetmembers != null) {
      data['sheetmembers'] = sheetmembers!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ExistData {
  dynamic id;
  dynamic fieldValue;
  dynamic extraFieldValue;
  dynamic depdntFieldIdValue;
  dynamic sheetDataId;
  dynamic dValue;
  List<FilesData>? filesData;
  dynamic geoTagging;

  ExistData(
      {this.id,
      this.fieldValue,
      this.extraFieldValue,
      this.depdntFieldIdValue,
      this.sheetDataId,
      this.dValue,
      this.filesData,
      this.geoTagging});

  ExistData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fieldValue = json['field_value'];
    extraFieldValue = json['extra_field_value'];
    depdntFieldIdValue = json['depdnt_field_id_value'];
    sheetDataId = json['sheet_data_id'];
    dValue = json['d_value'];
    if (json['files_data'] != null) {
      filesData = <FilesData>[];
      json['files_data'].forEach((v) {
        filesData!.add(new FilesData.fromJson(v));
      });
    }
    geoTagging = json['geo_tagging'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['field_value'] = fieldValue;
    data['extra_field_value'] = extraFieldValue;
    data['depdnt_field_id_value'] = depdntFieldIdValue;
    data['sheet_data_id'] = sheetDataId;
    data['d_value'] = dValue;
    if (filesData != null) {
      data['files_data'] = filesData!.map((v) => v.toJson()).toList();
    }
      data['geo_tagging'] = geoTagging!.map((v) => v.toJson()).toList();
  
    return data;
  }
}

class FilesData {
  dynamic fileType;
  dynamic fileName;
  dynamic extensionFile;
  dynamic mainUrl;
  dynamic imageUrl;
  dynamic mimeType;

  FilesData(
      {this.fileType,
      this.fileName,
      this.extensionFile,
      this.mainUrl,
      this.imageUrl,
      this.mimeType});

  FilesData.fromJson(Map<String, dynamic> json) {
    fileType = json['file_type'];
    fileName = json['file_name'];
    extensionFile = json['extension'];
    mainUrl = json['mainUrl'];
    imageUrl = json['imageUrl'];
    mimeType = json['mime_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['file_type'] = fileType;
    data['file_name'] = fileName;
    data['extension'] = extensionFile;
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
