import 'package:purplestage_provider/feature/dashboard/model/dashboard_serviceman_model.dart';
import 'package:purplestage_provider/feature/review/model/review_model.dart';
import 'package:purplestage_provider/feature/serviceman/model/service_man_model.dart';

class BookingDetailsModel {
  String? responseCode;
  String? message;
  BookingDetailsContent? content;

  BookingDetailsModel({this.responseCode, this.message, this.content});

  BookingDetailsModel.fromJson(Map<String, dynamic> json) {
    responseCode = json['response_code'];
    message = json['message'];
    content = json['content'] != null ? BookingDetailsContent.fromJson(json['content']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['response_code'] = responseCode;
    data['message'] = message;
    if (content != null) {
      data['content'] = content!.toJson();
    }
    return data;
  }
}

class BookingDetailsContent {
  String? id;
  int? readableId;
  String? customerId;
  String? providerId;
  String? zoneId;
  String? bookingStatus;
  int? isPaid;
  String? paymentMethod;
  String? transactionId;
  double? totalBookingAmount;
  double? totalTaxAmount;
  double? totalDiscountAmount;
  String? serviceSchedule;
  String? serviceAddressId;
  String? createdAt;
  String? updatedAt;
  String? servicemanId;
  String? categoryId;
  String? subcategoryId;
  List<ItemService>? bookingDetails;
  List<ScheduleHistories>? scheduleHistories;
  List<StatusHistories>? statusHistories;
  List<PartialPayment>? partialPayments;
  ServiceAddress? serviceAddress;
  String? offlinePaymentMethodName;
  List<BookingOfflinePayment>? bookingOfflinePayment;
  Customer? customer;
  Provider? provider;
  BookingDetailsServiceman? serviceman;
  String ? totalCampaignDiscountAmount;
  String ? totalCouponDiscountAmount;
  double ? additionalCharge;
  List<String>? photoEvidence;
  List<String>? photoEvidenceFullPath;
  double? extraFee;
  int? isGuest;
  double ? totalReferralDiscountAmount;

  BookingDetailsContent({
    this.id,
    this.readableId,
    this.customerId,
    this.providerId,
    this.zoneId,
    this.bookingStatus,
    this.isPaid,
    this.paymentMethod,
    this.transactionId,
    this.totalBookingAmount,
    this.totalTaxAmount,
    this.totalDiscountAmount,
    this.serviceSchedule,
    this.serviceAddressId,
    this.createdAt,
    this.updatedAt,
    this.servicemanId,
    this.bookingDetails,
    this.scheduleHistories,
    this.statusHistories,
    this.partialPayments,
    this.serviceAddress,
    this.customer,
    this.provider,
    this.serviceman,
    this.totalCampaignDiscountAmount,
    this.totalCouponDiscountAmount,
    this.additionalCharge,
    this.photoEvidence,
    this.photoEvidenceFullPath,
    this.extraFee,
    this.isGuest,
    this.totalReferralDiscountAmount,
    this.categoryId,
    this.subcategoryId,
    this.bookingOfflinePayment,
    this.offlinePaymentMethodName,
    });

  BookingDetailsContent.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    readableId = json['readable_id'];
    customerId = json['customer_id'];
    providerId = json['provider_id'];
    zoneId = json['zone_id'];
    bookingStatus = json['booking_status'];
    isPaid = json['is_paid'];
    paymentMethod = json['payment_method'];
    transactionId = json['transaction_id'];
    totalBookingAmount = double.tryParse(json['total_booking_amount'].toString());
    totalTaxAmount = double.tryParse(json['total_tax_amount'].toString());
    totalDiscountAmount = double.tryParse(json['total_discount_amount'].toString());
    serviceSchedule = json['service_schedule'];
    serviceAddressId = json['service_address_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    servicemanId = json['serviceman_id'];
    categoryId = json['category_id'];
    subcategoryId = json['sub_category_id'];
    if (json['detail'] != null) {
      bookingDetails = <ItemService>[];
      json['detail'].forEach((v) {
        bookingDetails!.add(ItemService.fromJson(v));
      });
    }
    if (json['schedule_histories'] != null) {
      scheduleHistories = <ScheduleHistories>[];
      json['schedule_histories'].forEach((v) {
        scheduleHistories!.add(ScheduleHistories.fromJson(v));
      });
    }
    if (json['status_histories'] != null) {
      statusHistories = <StatusHistories>[];
      json['status_histories'].forEach((v) {

        statusHistories!.add(StatusHistories.fromJson(v));
      });
    }

    if (json['booking_partial_payments'] != null) {
      partialPayments = <PartialPayment>[];
      json['booking_partial_payments'].forEach((v) {
        partialPayments!.add(PartialPayment.fromJson(v));
      });
    }

    serviceAddress = json['service_address'] != null
        ? ServiceAddress.fromJson(json['service_address'])
        : null;


    if (json['booking_offline_payment'] != null) {
      bookingOfflinePayment = <BookingOfflinePayment>[];
      json['booking_offline_payment'].forEach((v) { bookingOfflinePayment!.add(
          BookingOfflinePayment.fromJson(v));
      });
    }


    customer = json['customer'] != null
        ? Customer.fromJson(json['customer'])
        : null;
    provider = json['provider'] != null
        ? Provider.fromJson(json['provider'])
        : null;

    serviceman = json['serviceman'] != null
        ? BookingDetailsServiceman.fromJson(json['serviceman'])
        : null;
    totalCampaignDiscountAmount = json['total_campaign_discount_amount'].toString();
    totalCouponDiscountAmount =json['total_coupon_discount_amount'].toString();
    additionalCharge = double.tryParse(json['additional_charge'].toString());
    totalReferralDiscountAmount = double.tryParse(json['total_referral_discount_amount'].toString());
    photoEvidence = json["evidence_photos"]!=null? json["evidence_photos"].cast<String>(): [];
    photoEvidenceFullPath = json["evidence_photos_full_path"]!=null? json["evidence_photos_full_path"].cast<String>(): [];
    extraFee = double.tryParse(json["extra_fee"].toString());
    isGuest = int.tryParse(json["is_guest"].toString());
    offlinePaymentMethodName = json["booking_offline_payment_method"];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['readable_id'] = readableId;
    data['customer_id'] = customerId;
    data['provider_id'] = providerId;
    data['zone_id'] = zoneId;
    data['booking_status'] = bookingStatus;
    data['is_paid'] = isPaid;
    data['payment_method'] = paymentMethod;
    data['transaction_id'] = transactionId;
    data['total_booking_amount'] = totalBookingAmount;
    data['total_tax_amount'] = totalTaxAmount;
    data['total_discount_amount'] = totalDiscountAmount;
    data['service_schedule'] = serviceSchedule;
    data['service_address_id'] = serviceAddressId;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['serviceman_id'] = servicemanId;
    data['booking_offline_payment_method'] = offlinePaymentMethodName;
    if (bookingDetails != null) {
      data['detail'] = bookingDetails!.map((v) => v.toJson()).toList();
    }
    if (scheduleHistories != null) {
      data['schedule_histories'] =
          scheduleHistories!.map((v) => v.toJson()).toList();
    }
    if (statusHistories != null) {
      data['status_histories'] =
          statusHistories!.map((v) => v.toJson()).toList();
    }
    if (serviceAddress != null) {
      data['service_address'] = serviceAddress!.toJson();
    }
    if (customer != null) {
      data['customer'] = customer!.toJson();
    }
    if (provider != null) {
      data['provider'] = provider!.toJson();
    }

    if (bookingOfflinePayment != null) {
      data['booking_offline_payment'] = bookingOfflinePayment!.map((v) => v.toJson()).toList();
    }

    if (serviceman != null) {
      data['serviceman'] = provider!.toJson();
    }
    return data;
  }
}

class ItemService {
  int? id;
  String? bookingId;
  String? serviceId;
  String? serviceName;
  String? variantKey;
  double? serviceCost;
  int? quantity;
  double? discountAmount;
  double? taxAmount;
  double? totalCost;
  String? createdAt;
  String? updatedAt;
  double? campaignDiscountAmount;
  double? overallCouponDiscountAmount;
  BookingDetailsService? service;


  ItemService.copy(ItemService value) {
    quantity = value.quantity;
  }


  ItemService(
      {this.id,
        this.bookingId,
        this.serviceId,
        this.serviceName,
        this.variantKey,
        this.serviceCost,
        this.quantity,
        this.discountAmount,
        this.taxAmount,
        this.totalCost,
        this.createdAt,
        this.updatedAt,
        this.service,
        this.campaignDiscountAmount,
        this.overallCouponDiscountAmount,});

  ItemService.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    bookingId = json['booking_id'];
    serviceId = json['service_id'];
    serviceName = json['service_name'];
    variantKey = json['variant_key'];
    serviceCost = double.tryParse(json['service_cost'].toString());
    quantity = json['quantity'];
    discountAmount = double.tryParse(json['discount_amount'].toString());
    taxAmount = double.tryParse(json['tax_amount'].toString());
    totalCost = double.tryParse(json['total_cost'].toString());
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    campaignDiscountAmount = double.tryParse(json['campaign_discount_amount'].toString());
    service =
    json['service'] != null ? BookingDetailsService.fromJson(json['service']) : null;
    overallCouponDiscountAmount = double.tryParse(json['overall_coupon_discount_amount'].toString());
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['booking_id'] = bookingId;
    data['service_id'] = serviceId;
    data['service_name'] = serviceName;
    data['variant_key'] = variantKey;
    data['service_cost'] = serviceCost;
    data['quantity'] = quantity;
    data['discount_amount'] = discountAmount;
    data['tax_amount'] = taxAmount;
    data['total_cost'] = totalCost;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['campaign_discount_amount'] = campaignDiscountAmount;
    if (service != null) {
      data['service'] = service!.toJson();
    }
    return data;
  }
}

class BookingDetailsService {
  String? id;
  String? name;
  String? shortDescription;
  String? description;
  String? coverImage;
  String? thumbnail;
  String? thumbnailFullPath;
  String? categoryId;
  String? subCategoryId;
  double? tax;
  int? orderCount;
  int? isActive;
  int? ratingCount;
  String? createdAt;
  String? updatedAt;

  BookingDetailsService(
      {this.id,
      this.name,
      this.shortDescription,
      this.description,
      this.coverImage,
      this.thumbnail,
      this.thumbnailFullPath,
      this.categoryId,
      this.subCategoryId,
      this.tax,
      this.orderCount,
      this.isActive,
      this.ratingCount,
      this.createdAt,
      this.updatedAt});

  BookingDetailsService.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    shortDescription = json['short_description'];
    description = json['description'];
    coverImage = json['cover_image'];
    thumbnail = json['thumbnail'];
    thumbnailFullPath = json['thumbnail_full_path'];
    categoryId = json['category_id'];
    subCategoryId = json['sub_category_id'];
    tax = double.tryParse(json['tax'].toString());
    orderCount = json['order_count'];
    isActive = json['is_active'];
    ratingCount = json['rating_count'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['short_description'] = shortDescription;
    data['description'] = description;
    data['cover_image'] = coverImage;
    data['thumbnail'] = thumbnail;
    data['thumbnail_full_path'] = thumbnailFullPath;
    data['category_id'] = categoryId;
    data['sub_category_id'] = subCategoryId;
    data['tax'] = tax;
    data['order_count'] = orderCount;
    data['is_active'] = isActive;
    data['rating_count'] = ratingCount;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}


class ScheduleHistories {
  int? id;
  String? bookingId;
  String? changedBy;
  String? schedule;
  String? createdAt;
  String? updatedAt;
  User? user;

  ScheduleHistories(
      {this.id,
        this.bookingId,
        this.changedBy,
        this.schedule,
        this.createdAt,
        this.updatedAt,
        this.user});

  ScheduleHistories.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    bookingId = json['booking_id'];
    changedBy = json['changed_by'];
    schedule = json['schedule'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['booking_id'] = bookingId;
    data['changed_by'] = changedBy;
    data['schedule'] = schedule;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    return data;
  }
}


class StatusHistories {
  int? id;
  String? bookingId;
  String? changedBy;
  String? bookingStatus;
  String? createdAt;
  String? updatedAt;
  Serviceman1? user;

  StatusHistories(
      {this.id,
      this.bookingId,
      this.changedBy,
      this.bookingStatus,
      this.createdAt,
      this.updatedAt,
      this.user});

  StatusHistories.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    bookingId = json['booking_id'];
    changedBy = json['changed_by'];
    bookingStatus = json['booking_status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    user = json['user'] != null ? Serviceman1.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['booking_id'] = bookingId;
    data['changed_by'] = changedBy;
    data['booking_status'] = bookingStatus;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    return data;
  }
}

// class User {
//   String? id;
//   String? firstName;
//   String? lastName;
//   String? email;
//   String? phone;
//   String? identificationNumber;
//   String? identificationType;
//   String? gender;
//   String? profileImage;
//   int? isPhoneVerified;
//   int? isEmailVerified;
//   int? isActive;
//   String? userType;
//   String? createdAt;
//   String? updatedAt;
//
//   User(
//       {this.id,
//       this.firstName,
//       this.lastName,
//       this.email,
//       this.phone,
//       this.identificationNumber,
//       this.identificationType,
//       this.gender,
//       this.profileImage,
//       this.isPhoneVerified,
//       this.isEmailVerified,
//       this.isActive,
//       this.userType,
//       this.createdAt,
//       this.updatedAt});
//
//   User.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     firstName = json['first_name'];
//     lastName = json['last_name'];
//     email = json['email'];
//     phone = json['phone'];
//     identificationNumber = json['identification_number'];
//     identificationType = json['identification_type'];
//     gender = json['gender'];
//     profileImage = json['profile_image'];
//     isPhoneVerified = json['is_phone_verified'];
//     isEmailVerified = json['is_email_verified'];
//     isActive = json['is_active'];
//     userType = json['user_type'];
//     createdAt = json['created_at'];
//     updatedAt = json['updated_at'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['id'] = id;
//     data['first_name'] = firstName;
//     data['last_name'] = lastName;
//     data['email'] = email;
//     data['phone'] = phone;
//     data['identification_number'] = identificationNumber;
//     data['identification_type'] = identificationType;
//
//     data['gender'] = gender;
//     data['profile_image'] = profileImage;
//     data['is_phone_verified'] = isPhoneVerified;
//     data['is_email_verified'] = isEmailVerified;
//     data['is_active'] = isActive;
//     data['user_type'] = userType;
//     data['created_at'] = createdAt;
//     data['updated_at'] = updatedAt;
//     return data;
//   }
// }

class ServiceAddress {
  int? id;
  String? userId;
  String? lat;
  String? lon;
  String? city;
  String? street;
  String? zipCode;
  String? country;
  String? address;
  String? createdAt;
  String? updatedAt;
  String? addressType;
  String? contactPersonName;
  String? contactPersonNumber;
  String? addressLabel;

  ServiceAddress(
      {this.id,
      this.userId,
      this.lat,
      this.lon,
      this.city,
      this.street,
      this.zipCode,
      this.country,
      this.address,
      this.createdAt,
      this.updatedAt,
      this.addressType,
      this.contactPersonName,
      this.contactPersonNumber,
      this.addressLabel});

  ServiceAddress.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    lat = json['lat'];
    lon = json['lon'];
    city = json['city'];
    street = json['street'];
    zipCode = json['zip_code'];
    country = json['country'];
    address = json['address'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    addressType = json['address_type'];
    contactPersonName = json['contact_person_name'];
    contactPersonNumber = json['contact_person_number'];
    addressLabel = json['address_label'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user_id'] = userId;
    data['lat'] = lat;
    data['lon'] = lon;
    data['city'] = city;
    data['street'] = street;
    data['zip_code'] = zipCode;
    data['country'] = country;
    data['address'] = address;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['address_type'] = addressType;
    data['contact_person_name'] = contactPersonName;
    data['contact_person_number'] = contactPersonNumber;
    data['address_label'] = addressLabel;
    return data;
  }
}

class Customer {
  String? id;
  String? firstName;
  String? lastName;
  String? email;
  String? phone;
  String? identificationType;
  String? gender;
  String? profileImage;
  String? profileImageFullPath;
  int? isPhoneVerified;
  int? isEmailVerified;
  int? isActive;
  String? userType;
  String? createdAt;
  String? updatedAt;

  Customer(
      {this.id,
      this.firstName,
      this.lastName,
      this.email,
      this.phone,
      this.identificationType,
      this.gender,
      this.profileImage,
      this.profileImageFullPath,
      this.isPhoneVerified,
      this.isEmailVerified,
      this.isActive,
      this.userType,
      this.createdAt,
      this.updatedAt});

  Customer.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    email = json['email'];
    phone = json['phone'];
    identificationType = json['identification_type'];
    gender = json['gender'];
    profileImage = json['profile_image'];
    profileImageFullPath = json['profile_image_full_path'];
    isPhoneVerified = json['is_phone_verified'];
    isEmailVerified = json['is_email_verified'];
    isActive = json['is_active'];
    userType = json['user_type'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['email'] = email;
    data['phone'] = phone;
    data['identification_type'] = identificationType;
    data['gender'] = gender;
    data['profile_image'] = profileImage;
    data['profile_image_full_path'] = profileImageFullPath;
    data['is_phone_verified'] = isPhoneVerified;
    data['is_email_verified'] = isEmailVerified;
    data['is_active'] = isActive;
    data['user_type'] = userType;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}

// class Provider {
//   String? id;
//   String? userId;
//   String? companyName;
//   String? companyPhone;
//   String? companyAddress;
//   String? companyEmail;
//   String? logo;
//   String? contactPersonName;
//   String? contactPersonPhone;
//   String? contactPersonEmail;
//   int? orderCount;
//   int? serviceManCount;
//   int? serviceCapacityPerDay;
//   int? ratingCount;
//   double? avgRating;
//   int? commissionStatus;
//   int? commissionPercentage;
//   int? isActive;
//   String? createdAt;
//   String? updatedAt;
//   int? isApproved;
//   String? zoneId;
//
//   Provider(
//       {this.id,
//       this.userId,
//       this.companyName,
//       this.companyPhone,
//       this.companyAddress,
//       this.companyEmail,
//       this.logo,
//       this.contactPersonName,
//       this.contactPersonPhone,
//       this.contactPersonEmail,
//       this.orderCount,
//       this.serviceManCount,
//       this.serviceCapacityPerDay,
//       this.ratingCount,
//       this.avgRating,
//       this.commissionStatus,
//       this.commissionPercentage,
//       this.isActive,
//       this.createdAt,
//       this.updatedAt,
//       this.isApproved,
//       this.zoneId});
//
//   Provider.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     userId = json['user_id'];
//     companyName = json['company_name'];
//     companyPhone = json['company_phone'];
//     companyAddress = json['company_address'];
//     companyEmail = json['company_email'];
//     logo = json['logo'];
//     contactPersonName = json['contact_person_name'];
//     contactPersonPhone = json['contact_person_phone'];
//     contactPersonEmail = json['contact_person_email'];
//     orderCount = json['order_count'];
//     serviceManCount = json['service_man_count'];
//     serviceCapacityPerDay = json['service_capacity_per_day'];
//     ratingCount = int.tryParse(json['rating_count'].toString());
//     avgRating = double.tryParse(json['avg_rating'].toString());
//     commissionStatus = int.tryParse(json['commission_status'].toString());
//    // commissionPercentage = json['commission_percentage'];
//     isActive = json['is_active'];
//     createdAt = json['created_at'];
//     updatedAt = json['updated_at'];
//     isApproved = json['is_approved'];
//     zoneId = json['zone_id'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['id'] = id;
//     data['user_id'] = userId;
//     data['company_name'] = companyName;
//     data['company_phone'] = companyPhone;
//     data['company_address'] = companyAddress;
//     data['company_email'] = companyEmail;
//     data['logo'] = logo;
//     data['contact_person_name'] = contactPersonName;
//     data['contact_person_phone'] = contactPersonPhone;
//     data['contact_person_email'] = contactPersonEmail;
//     data['order_count'] = orderCount;
//     data['service_man_count'] = serviceManCount;
//     data['service_capacity_per_day'] = serviceCapacityPerDay;
//     data['rating_count'] = ratingCount;
//     data['avg_rating'] = avgRating;
//     data['commission_status'] = commissionStatus;
//     data['commission_percentage'] = commissionPercentage;
//     data['is_active'] = isActive;
//     data['created_at'] = createdAt;
//     data['updated_at'] = updatedAt;
//     data['is_approved'] = isApproved;
//     data['zone_id'] = zoneId;
//     return data;
//   }
// }

class BookingDetailsServiceman {
  String? id;
  String? providerId;
  String? userId;
  String? createdAt;
  String? updatedAt;
  ServicemanModel? user;

  BookingDetailsServiceman(
      {this.id,
        this.providerId,
        this.userId,
        this.createdAt,
        this.updatedAt,
        this.user});

  BookingDetailsServiceman.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    providerId = json['provider_id'];
    userId = json['user_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    user = json['user'] != null ? ServicemanModel.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['provider_id'] = providerId;
    data['user_id'] = userId;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    return data;
  }
}

class Serviceman1 {
  String? id;
  String? firstName;
  String? lastName;
  String? email;
  String? phone;
  String? identificationNumber;
  String? identificationType;
  List<String>? identificationImage;
  String? gender;
  String? profileImage;
  int? isPhoneVerified;
  int? isEmailVerified;
  int? isActive;
  String? userType;
  String? createdAt;
  String? updatedAt;

  Serviceman1(
      {this.id,
        this.firstName,
        this.lastName,
        this.email,
        this.phone,
        this.identificationNumber,
        this.identificationType,
        this.identificationImage,
        this.gender,
        this.profileImage,
        this.isPhoneVerified,
        this.isEmailVerified,
        this.isActive,
        this.userType,
        this.createdAt,
        this.updatedAt});

  Serviceman1.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    email = json['email'];
    phone = json['phone'];
    identificationNumber = json['identification_number'];
    identificationType = json['identification_type'];
    gender = json['gender'];
    profileImage = json['profile_image'];
    isPhoneVerified = json['is_phone_verified'];
    isEmailVerified = json['is_email_verified'];
    isActive = json['is_active'];
    userType = json['user_type'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['email'] = email;
    data['phone'] = phone;
    data['identification_number'] = identificationNumber;
    data['identification_type'] = identificationType;
    data['identification_image'] = identificationImage;
    data['gender'] = gender;
    data['profile_image'] = profileImage;
    data['is_phone_verified'] = isPhoneVerified;
    data['is_email_verified'] = isEmailVerified;
    data['is_active'] = isActive;
    data['user_type'] = userType;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}

class PartialPayment {
  String? id;
  String? bookingId;
  String? paidWith;
  double? paidAmount;
  double? dueAmount;
  String? createdAt;
  String? updatedAt;

  PartialPayment(
      {this.id,
        this.bookingId,
        this.paidWith,
        this.paidAmount,
        this.dueAmount,
        this.createdAt,
        this.updatedAt});

  PartialPayment.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    bookingId = json['booking_id'];
    paidWith = json['paid_with'];
    paidAmount = double.tryParse(json['paid_amount'].toString());
    dueAmount = double.tryParse(json['due_amount'].toString());
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['booking_id'] = bookingId;
    data['paid_with'] = paidWith;
    data['paid_amount'] = paidAmount;
    data['due_amount'] = dueAmount;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}


class BookingOfflinePayment {
  String? key;
  String? value;

  BookingOfflinePayment({String? key, String? value}) {
    if (key != null) {
      key = key;
    }
    if (value != null) {
      value = value;
    }
  }


  BookingOfflinePayment.fromJson(Map<String, dynamic> json) {
    key = json['key'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['key'] = key;
    data['value'] = value;
    return data;
  }
}

class CustomerInformation {
  String? paymentNote;
  String? paymentBy;
  String? transactionId;
  String? refNo;

  CustomerInformation(
      {this.paymentNote, this.paymentBy, this.transactionId, this.refNo});

  CustomerInformation.fromJson(Map<String, dynamic> json) {
    paymentNote = json['payment_note'];
    paymentBy = json['payment_by'];
    transactionId = json['transaction_id'];
    refNo = json['ref_no'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['payment_note'] = paymentNote;
    data['payment_by'] = paymentBy;
    data['transaction_id'] = transactionId;
    data['ref_no'] = refNo;
    return data;
  }
}