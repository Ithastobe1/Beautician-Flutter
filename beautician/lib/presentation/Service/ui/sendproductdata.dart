class ProductUse {
  int? bookingId;
  List<Service>? services;

  ProductUse({this.bookingId, this.services});

  ProductUse.fromJson(Map<String, dynamic> json) {
    bookingId = json['Bookingid'];
    if (json['services'] != null) {
      services = <Service>[];
      json['services'].forEach((v) {
        services!.add(Service.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {
      'Bookingid': bookingId,
      'services': services?.map((service) => service.toJson()).toList(),
    };
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
    final Map<String, dynamic> data = {
      'serviceID': serviceId,
      'products': products?.map((product) => product.toJson()).toList(),
    };
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
    final Map<String, dynamic> data = {
      'productID': productId,
      'productName': productName,
      'quantity': quantity,
      'unit': unit,
      'quality_present': qualityPresent,
    };
    return data;
  }
}