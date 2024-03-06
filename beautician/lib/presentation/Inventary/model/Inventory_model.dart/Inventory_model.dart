class InventoryModel {
  String? status;
  List<TransferList>? transferList;

  InventoryModel({this.status, this.transferList});

  InventoryModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['transferList'] != null) {
      transferList = <TransferList>[];
      json['transferList'].forEach((v) {
        transferList!.add(new TransferList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.transferList != null) {
      data['transferList'] = this.transferList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class TransferList {
  int? id;
  int? locationId;
  int? beauticianId;
  String? transferRef;
  String? transferDate;
  String? status;
  String? createdAt;
  String? updatedAt;

  TransferList(
      {this.id,
      this.locationId,
      this.beauticianId,
      this.transferRef,
      this.transferDate,
      this.status,
      this.createdAt,
      this.updatedAt});

  TransferList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    locationId = json['location_id'];
    beauticianId = json['beautician_id'];
    transferRef = json['transfer_ref'];
    transferDate = json['transfer_date'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['location_id'] = this.locationId;
    data['beautician_id'] = this.beauticianId;
    data['transfer_ref'] = this.transferRef;
    data['transfer_date'] = this.transferDate;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
