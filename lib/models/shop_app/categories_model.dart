class CategoriesModel {
  bool? status;
  String? message;
  CategoriesDataModel? data;

  CategoriesModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'];
  }
}

class CategoriesDataModel {
  int? currentPage;
  List<CategoryModel> data = [];
  String? firstPageUrl;
  int? from;
  int? lastPage;
  String? lastPageUrl;
  String? nextPageUrl;
  String? path;
  int? perPage;
  String? prevPageUrl;
  int? to;
  dynamic total;

  CategoriesDataModel.fromJson(Map<String, dynamic> json) {
    // data = CategoryModel.fromJson(json['data']);


    currentPage = json['current_page'];
    firstPageUrl = json['first_page_url'];
    from = json['from'];
    lastPage = json['last_page'];
    lastPageUrl = json['last_page_url'];
    nextPageUrl = json['next_page_url'];
    path = json['path'];
    perPage = json['per_page'];
    prevPageUrl = json['prev_page_url'];
    to = json['to'];
    total = json['total'];
  }
}

class CategoryModel {
  int? id;
  String? name;
  String? image;

  CategoryModel.fromJson(Map<String,dynamic> json){
    id = json['id'];
    name = json['name'];
    image = json['image'];
  }
}
