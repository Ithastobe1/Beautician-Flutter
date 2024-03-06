class DashboardModel {
  String? status;
  int? totalbooking;
  int? saledone;
  String? incentiveTarget;
  int? incentiveAmount;
  String? location;
  List<Todaybooking>? todaybooking;

  DashboardModel(
      {this.status,
      this.totalbooking,
      this.saledone,
      this.incentiveTarget,
      this.incentiveAmount,
      this.location,
      this.todaybooking});

  DashboardModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    totalbooking = json['totalbooking'];
    saledone = json['saledone'];
    incentiveTarget = json['incentiveTarget'];
    incentiveAmount = json['incentiveAmount'];
    location = json['location'];
    if (json['todaybooking'] != null) {
      todaybooking = <Todaybooking>[];
      json['todaybooking'].forEach((v) {
        todaybooking!.add(new Todaybooking.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['totalbooking'] = this.totalbooking;
    data['saledone'] = this.saledone;
    data['incentiveTarget'] = this.incentiveTarget;
    data['incentiveAmount'] = this.incentiveAmount;
    data['location'] = this.location;
    if (this.todaybooking != null) {
      data['todaybooking'] = this.todaybooking!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Todaybooking {
  int? sr;
  int? assignedBookingID;
  String? beauticianName;
  String? beauticianPhone;
  int? customerID;
  String? customerMobile;
  String? customerName;
  List<Useraddress>? useraddress;
  String? bookingDate;
  String? bookingDay;
  String? bookingTime;
  double? price;
  String? paymentStatus;

  Todaybooking(
      {this.sr,
      this.assignedBookingID,
      this.beauticianName,
      this.beauticianPhone,
      this.customerID,
      this.customerMobile,
      this.customerName,
      this.useraddress,
      this.bookingDate,
      this.bookingDay,
      this.bookingTime,
      this.price,
      this.paymentStatus});

  Todaybooking.fromJson(Map<String, dynamic> json) {
  sr = json['sr'];
  assignedBookingID = json['assignedBookingID'];
  beauticianName = json['beauticianName'];
  beauticianPhone = json['beautician_phone'];
  customerID = json['CustomerID'];
  customerMobile = json['customerMobile'];
  customerName = json['customerName'];
  if (json['useraddress'] != null) {
    useraddress = <Useraddress>[];
    json['useraddress'].forEach((v) {
      useraddress!.add(new Useraddress.fromJson(v));
    });
  }
  bookingDate = json['booking_date'];
  bookingDay = json['booking_day'];
  bookingTime = json['booking_time'];
  
  // Check if the value is not null before assigning
  price = json['price']?.toDouble(); // Convert to double or keep it as null
  
  paymentStatus = json['payment_status'];
}

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['sr'] = this.sr;
    data['assignedBookingID'] = this.assignedBookingID;
    data['beauticianName'] = this.beauticianName;
    data['beautician_phone'] = this.beauticianPhone;
    data['CustomerID'] = this.customerID;
    data['customerMobile'] = this.customerMobile;
    data['customerName'] = this.customerName;
    if (this.useraddress != null) {
      data['useraddress'] = this.useraddress!.map((v) => v.toJson()).toList();
    }
    data['booking_date'] = this.bookingDate;
    data['booking_day'] = this.bookingDay;
    data['booking_time'] = this.bookingTime;
    data['price'] = this.price;
    data['payment_status'] = this.paymentStatus;
    return data;
  }
}

class Useraddress {
  int? addressId;
  int? userId;
  String? addressHeading;
  String? address;
  String? street;
  String? pincode;
  double? lattitude;
  double? longitude;
  String? mobileNumber;
  String? callingCode;
  int? isPrimary;
  String? createdAt;
  String? updatedAt;

  Useraddress(
      {this.addressId,
      this.userId,
      this.addressHeading,
      this.address,
      this.street,
      this.pincode,
      this.lattitude,
      this.longitude,
      this.mobileNumber,
      this.callingCode,
      this.isPrimary,
      this.createdAt,
      this.updatedAt});

Useraddress.fromJson(Map<String, dynamic> json) {
  addressId = json['address_id'];
  userId = json['user_id'];
  addressHeading = json['address_heading'];
  address = json['address'];
  street = json['street'];
  pincode = json['pincode'];
  
  // Check if the values are not null before assigning
  lattitude = json['lattitude']?.toDouble(); // Convert to double or keep it as null
  longitude = json['longitude']?.toDouble(); // Convert to double or keep it as null
  
  mobileNumber = json['mobile_number'];
  callingCode = json['calling_code'];
  isPrimary = json['is_primary'];
  createdAt = json['created_at'];
  updatedAt = json['updated_at'];
}


  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['address_id'] = this.addressId;
    data['user_id'] = this.userId;
    data['address_heading'] = this.addressHeading;
    data['address'] = this.address;
    data['street'] = this.street;
    data['pincode'] = this.pincode;
    data['lattitude'] = this.lattitude;
    data['longitude'] = this.longitude;
    data['mobile_number'] = this.mobileNumber;
    data['calling_code'] = this.callingCode;
    data['is_primary'] = this.isPrimary;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
