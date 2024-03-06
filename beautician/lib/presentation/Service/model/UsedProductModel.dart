class ProductUseData {
  ProductUsed? productUsed;

  ProductUseData({this.productUsed});

  ProductUseData.fromJson(Map<String, dynamic> json) {
    productUsed = json['productUse'] != null
        ? ProductUsed.fromJson(json['productUse'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    if (productUsed != null) {
      data['productUse'] = productUsed!.toJson();
    }
    return data;
  }
}

class ProductUsed {
  int? bookingId;
  List<Service>? services;

  ProductUsed({this.bookingId, this.services});

  ProductUsed.fromJson(Map<String, dynamic> json) {
    bookingId = json['Bookingid'];
    if (json['services'] != null) {
      services = <Service>[];
      json['services'].forEach((v) {
        services!.add(Service.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {'Bookingid': bookingId};
    if (services != null) {
      data['services'] = services!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Service {
  int? serviceId;
  List<Product>? products;

  Service({this.serviceId, this.products});

  Service.fromJson(Map<String, dynamic> json) {
    serviceId = json['serviceID'];
    if (json['products'] != null) {
      products = <Product>[];
      json['products'].forEach((v) {
        products!.add(Product.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {'serviceID': serviceId};
    if (products != null) {
      data['products'] = products!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Product {
  int? productId;
  String? productName;
  int? quantity;
  String? unit;
  String? qualityPresent;

  Product({
    this.productId,
    this.productName,
    this.quantity,
    this.unit,
    this.qualityPresent,
  });

  Product.fromJson(Map<String, dynamic> json) {
    productId = json['productID'];
    productName = json['productName'];
    quantity = json['quantity'];
    unit = json['unit'];
    qualityPresent = json['quality_present'];
  }

  Map<String, dynamic> toJson() {
    return {
      'productID': productId,
      'productName': productName,
      'quantity': quantity,
      'unit': unit,
      'quality_present': qualityPresent,
    };
  }
}