class DataModel {
  String? locId;
  String? locX;
  String? locY;
  String? title1;
  String? snippet1;

  DataModel({this.locId, this.locX, this.locY, this.title1, this.snippet1});
  DataModel.fromJson(Map<String, dynamic> json) {
    locId = json['loc_id'];
    locX = json['loc_x'];
    locY = json['loc_y'];
    title1 = json['title_1'];
    snippet1 = json['snippet_1'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['loc_id'] = locId;
    data['loc_x'] = locX;
    data['loc_y'] = locY;
    data['title_1'] = title1;
    data['snippet_1'] = snippet1;
    return data;
  }
}

//========================================================
class ListDataModel {
  List<DataModel>? data;
  ListDataModel({this.data});

  ListDataModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <DataModel>[];
      json['data'].forEach((v) {
        data!.add(DataModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
