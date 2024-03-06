class StockModel {
  String? status;
  List<Data>? data;

  StockModel({this.status, this.data});

  StockModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int? id;
  String? beauticianId;
  String? productId;
  String? quantity;
  String? createdAt;
  String? updatedAt;
  String? productName;

  Data(
      {this.id,
      this.beauticianId,
      this.productId,
      this.quantity,
      this.createdAt,
      this.updatedAt,
      this.productName});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    beauticianId = json['beautician_id'];
    productId = json['product_id'];
    quantity = json['quantity'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    productName = json['productName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['beautician_id'] = this.beauticianId;
    data['product_id'] = this.productId;
    data['quantity'] = this.quantity;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['productName'] = this.productName;
    return data;
  }
}
