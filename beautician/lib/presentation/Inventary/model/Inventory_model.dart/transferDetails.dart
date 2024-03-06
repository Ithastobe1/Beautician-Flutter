class TransferDetailsModel {
  String? status;
  List<TransferDetails>? transferDetails;

  TransferDetailsModel({this.status, this.transferDetails});

  TransferDetailsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['transferDetails'] != null) {
      transferDetails = <TransferDetails>[];
      json['transferDetails'].forEach((v) {
        transferDetails!.add(new TransferDetails.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.transferDetails != null) {
      data['transferDetails'] =
          this.transferDetails!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class TransferDetails {
  int? id;
  int? transferId;
  int? productId;
  int? aquantity;
  String? expiryDate;
  String? rate;
  int? tquantity;
  String? total;
  String? createdAt;
  String? updatedAt;
  String? productName;

  TransferDetails(
      {this.id,
      this.transferId,
      this.productId,
      this.aquantity,
      this.expiryDate,
      this.rate,
      this.tquantity,
      this.total,
      this.createdAt,
      this.updatedAt,
      this.productName});

  TransferDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    transferId = json['transfer_id'];
    productId = json['product_id'];
    aquantity = json['aquantity'];
    expiryDate = json['expiry_date'];
    rate = json['rate'];
    tquantity = json['tquantity'];
    total = json['total'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    productName = json['productName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['transfer_id'] = this.transferId;
    data['product_id'] = this.productId;
    data['aquantity'] = this.aquantity;
    data['expiry_date'] = this.expiryDate;
    data['rate'] = this.rate;
    data['tquantity'] = this.tquantity;
    data['total'] = this.total;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['productName'] = this.productName;
    return data;
  }
}
