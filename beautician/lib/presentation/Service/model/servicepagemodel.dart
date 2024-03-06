class StartJourneyModel {
  String? status;
  String? bookingId;
  String? startTime;
  int? bookingReportId;

  StartJourneyModel(
      {this.status, this.bookingId, this.startTime, this.bookingReportId});

  StartJourneyModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    bookingId = json['booking_id'];
    startTime = json['start_time'];
    bookingReportId = json['booking_report_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['booking_id'] = this.bookingId;
    data['start_time'] = this.startTime;
    data['booking_report_id'] = this.bookingReportId;
    return data;
  }
}

class ReachedDestinationModel {
  String? status;
  String? bookingId;
  int? bookingReportId;
  String? reachedTime;

  ReachedDestinationModel(
      {this.status, this.bookingId, this.bookingReportId, this.reachedTime});

  ReachedDestinationModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    bookingId = json['booking_id'];
    bookingReportId = json['booking_report_id'];
    reachedTime = json['reached_time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['booking_id'] = this.bookingId;
    data['booking_report_id'] = this.bookingReportId;
    data['reached_time'] = this.reachedTime;
    return data;
  }
}

class StartServiceModel {
  String? status;
  String? startServiceTime;

  StartServiceModel({this.status, this.startServiceTime});

  StartServiceModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    startServiceTime = json['start_service_time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['start_service_time'] = this.startServiceTime;
    return data;
  }
}

class StopServiceModel {
  String? status;
  Data? data;
  String? stopServiceTime;

  StopServiceModel({this.status, this.data, this.stopServiceTime});

  StopServiceModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    stopServiceTime = json['stop_service_time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['stop_service_time'] = this.stopServiceTime;
    return data;
  }
}

class Data {
  int? id;
  String? beauticainId;
  String? bookingId;
  String? startService;
  String? stopService;
  String? hygienePhoto;
  String? selfPhoto;
  String? payment;
  String? rating;
  String? review;
  String? conversation;
  String? amountPaid;
  String? createdAt;
  String? updatedAt;

  Data(
      {this.id,
      this.beauticainId,
      this.bookingId,
      this.startService,
      this.stopService,
      this.hygienePhoto,
      this.selfPhoto,
      this.payment,
      this.rating,
      this.review,
      this.conversation,
      this.amountPaid,
      this.createdAt,
      this.updatedAt});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    beauticainId = json['beauticain_id'];
    bookingId = json['booking_id'];
    startService = json['start_service'];
    stopService = json['stop_service'];
    hygienePhoto = json['hygiene_photo'];
    selfPhoto = json['self_photo'];
    payment = json['payment'];
    rating = json['rating'];
    review = json['review'];
    conversation = json['conversation'];
    amountPaid = json['amount_paid'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['beauticain_id'] = this.beauticainId;
    data['booking_id'] = this.bookingId;
    data['start_service'] = this.startService;
    data['stop_service'] = this.stopService;
    data['hygiene_photo'] = this.hygienePhoto;
    data['self_photo'] = this.selfPhoto;
    data['payment'] = this.payment;
    data['rating'] = this.rating;
    data['review'] = this.review;
    data['conversation'] = this.conversation;
    data['amount_paid'] = this.amountPaid;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

// class Booking {
//   String? status;
//   String? time;
//   String? date;
//   String? name;
//   List<BookingsItems>? bookingsItems;
//   int? sumTime;
//   int? totalAmount;
//   String? paymentType;
//   Address? address;

//   Booking(
//       {this.status,
//       this.time,
//       this.date,
//       this.name,
//       this.bookingsItems,
//       this.sumTime,
//       this.totalAmount,
//       this.paymentType,
//       this.address});

//   Booking.fromJson(Map<String, dynamic> json) {
//     status = json['status'];
//     time = json['Time'];
//     date = json['Date'];
//     name = json['name'];
//     if (json['bookings_items'] != null) {
//       bookingsItems = <BookingsItems>[];
//       json['bookings_items'].forEach((v) {
//         bookingsItems!.add(new BookingsItems.fromJson(v));
//       });
//     }
//     sumTime = json['sumTime'];
//     totalAmount = json['total_amount'];
//     paymentType = json['payment_type'];
//     address =
//         json['address'] != null ? new Address.fromJson(json['address']) : null;
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['status'] = this.status;
//     data['Time'] = this.time;
//     data['Date'] = this.date;
//     data['name'] = this.name;
//     if (this.bookingsItems != null) {
//       data['bookings_items'] =
//           this.bookingsItems!.map((v) => v.toJson()).toList();
//     }
//     data['sumTime'] = this.sumTime;
//     data['total_amount'] = this.totalAmount;
//     data['payment_type'] = this.paymentType;
//     if (this.address != null) {
//       data['address'] = this.address!.toJson();
//     }
//     return data;
//   }
// }

// class BookingsItems {
//   String? service;
//   int? time;
//   String? timeType;
//   int? qunitity;
//   int? unitPrice;
//   int? amount;

//   BookingsItems(
//       {this.service,
//       this.time,
//       this.timeType,
//       this.qunitity,
//       this.unitPrice,
//       this.amount});

//   BookingsItems.fromJson(Map<String, dynamic> json) {
//     service = json['service'];
//     time = json['time'];
//     timeType = json['time_type'];
//     qunitity = json['qunitity'];
//     unitPrice = json['unit_price'];
//     amount = json['amount'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['service'] = this.service;
//     data['time'] = this.time;
//     data['time_type'] = this.timeType;
//     data['qunitity'] = this.qunitity;
//     data['unit_price'] = this.unitPrice;
//     data['amount'] = this.amount;
//     return data;
//   }
// }

// class Address {
//   String? addressHeading;
//   String? address;
//   String? street;
//   String? pincode;
//   double? lattitude;
//   double? longitude;
//   String? mobileNumber;
//   String? callingCode;

//   Address(
//       {this.addressHeading,
//       this.address,
//       this.street,
//       this.pincode,
//       this.lattitude,
//       this.longitude,
//       this.mobileNumber,
//       this.callingCode});

//   Address.fromJson(Map<String, dynamic> json) {
//     addressHeading = json['address_heading'];
//     address = json['address'];
//     street = json['street'];
//     pincode = json['pincode'];
//     lattitude = json['lattitude'];
//     longitude = json['longitude'];
//     mobileNumber = json['mobile_number'];
//     callingCode = json['calling_code'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['address_heading'] = this.addressHeading;
//     data['address'] = this.address;
//     data['street'] = this.street;
//     data['pincode'] = this.pincode;
//     data['lattitude'] = this.lattitude;
//     data['longitude'] = this.longitude;
//     data['mobile_number'] = this.mobileNumber;
//     data['calling_code'] = this.callingCode;
//     return data;
//   }
// }

class Booking {
  String? status;
  int? bookingId;
  String? time;
  String? date;
  String? name;
  List<BookingsItems>? bookingsItems;
  int? sumTime;
  int? totalAmount;
  String? paymentType;
  Address? address;

  Booking({
    this.status,
    this.bookingId,
    this.time,
    this.date,
    this.name,
    this.bookingsItems,
    this.sumTime,
    this.totalAmount,
    this.paymentType,
    this.address,
  });

  Booking.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    bookingId = json['bookinId'];
    time = json['Time'];
    date = json['Date'];
    name = json['name'];
    if (json['bookings_items'] != null) {
      bookingsItems = <BookingsItems>[];
      json['bookings_items'].forEach((v) {
        bookingsItems!.add(BookingsItems.fromJson(v));
      });
    }
    sumTime = json['sumTime'] ?? 0;
    totalAmount = json['total_amount'] ?? 0;
    paymentType = json['payment_type'];
    address =
        json['address'] != null ? Address.fromJson(json['address']) :null;
  }
}

class BookingsItems {
  String? service;
  int? serviceID;
  List<ProductUse>? productUse;
  int? time;
  String? timeType;
  int? qunitity;
  int? unitPrice;
  int? amount;

  BookingsItems({
    this.service,
    this.serviceID,
    this.productUse,
    this.time,
    this.timeType,
    this.qunitity,
    this.unitPrice,
    this.amount,
  });

  BookingsItems.fromJson(Map<String, dynamic> json) {
    service = json['service'];
    serviceID = json['serviceID'] ?? 0; // Handle nullable case
    if (json['productUse'] != null) {
      productUse = <ProductUse>[];
      json['productUse'].forEach((v) {
        productUse!.add(ProductUse.fromJson(v));
      });
    }
    time = json['time'] ?? 0;
    timeType = json['time_type'];
    qunitity = json['qunitity'] ?? 0;
    unitPrice = json['unit_price'] ?? 0;
    amount = json['amount'] ?? 0;
  }
}

class ProductUse {
  int? productID;
  String? productName;
  String? quantity;
  String? unit;

  ProductUse({
    this.productID,
    this.productName,
    this.quantity,
    this.unit,
  });

  ProductUse.fromJson(Map<String, dynamic> json) {
    productID = json['productID'];
    productName = json['productName'];
    quantity = json['quantity'] ?? "0";
    unit = json['unit'];
  }
}

class Address {
  String? addressHeading;
  String? address;
  String? street;
  String? pincode;
  double? lattitude;
  double? longitude;
  String? mobileNumber;
  String? callingCode;

  Address(
      {this.addressHeading,
      this.address,
      this.street,
      this.pincode,
      this.lattitude,
      this.longitude,
      this.mobileNumber,
      this.callingCode});

  Address.fromJson(Map<String, dynamic> json) {
    addressHeading = json['address_heading'];
    address = json['address'];
    street = json['street'];
    pincode = json['pincode'];
    lattitude = json['lattitude'];
    longitude = json['longitude'];
    mobileNumber = json['mobile_number'];
    callingCode = json['calling_code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['address_heading'] = this.addressHeading;
    data['address'] = this.address;
    data['street'] = this.street;
    data['pincode'] = this.pincode;
    data['lattitude'] = this.lattitude;
    data['longitude'] = this.longitude;
    data['mobile_number'] = this.mobileNumber;
    data['calling_code'] = this.callingCode;
    return data;
  }
}
