class AllCategoryModel {
  bool? response;
  List<Data>? data;
  String? message;

  AllCategoryModel({this.response, this.data, this.message});

  AllCategoryModel.fromJson(Map<String, dynamic> json) {
    response = json['response'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['response'] = this.response;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['message'] = this.message;
    return data;
  }

  // Method to add a new category at the zero index
  void addCategoryAtZeroIndex(String catId, String categoryName, [String? categoryImage]) {
    if (data == null) {
      data = [];
    }
    data!.insert(0, Data(catId: catId, categoryName: categoryName, categoryImage: categoryImage));
  }
}

class Data {
  String? catId;
  String? categoryName;
  String? categoryImage;

  Data({this.catId, this.categoryName, this.categoryImage});

  Data.fromJson(Map<String, dynamic> json) {
    catId = json['cat_id'];
    categoryName = json['category_name'];
    categoryImage = json['category_image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['cat_id'] = this.catId;
    data['category_name'] = this.categoryName;
    data['category_image'] = this.categoryImage;
    return data;
  }
}
