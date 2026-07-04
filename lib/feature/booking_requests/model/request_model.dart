import 'dart:convert';
import 'package:purplestage_provider/feature/custom_post/model/post_model.dart';

BookingRequestModel bookingRequestModelFromJson(String str) => BookingRequestModel.fromJson(json.decode(str));

String bookingRequestModelToJson(BookingRequestModel data) => json.encode(data.toJson());

class BookingRequestModel {
  BookingRequestModel({
    this.id,
    this.readableId,
    this.customerId,
    this.providerId,
    this.zoneId,
    this.bookingStatus,
    this.isPaid,
    this.paymentMethod,
    this.transactionId,
    required this.totalBookingAmount,
    this.totalTaxAmount,
    this.totalDiscountAmount,
    this.serviceSchedule,
    this.serviceAddressId,
    this.createdAt,
    this.updatedAt,
    this.categoryId,
    this.subCategoryId,
    this.servicemanId,
    this.subCategory

  });

  String? id;
  int? readableId;
  String? customerId;
  String? providerId;
  String? zoneId;
  String? bookingStatus;
  int? isPaid;
  String? paymentMethod;
  String? transactionId;
  String totalBookingAmount;
  String? totalTaxAmount;
  String? totalDiscountAmount;
  String? serviceSchedule;
  String? serviceAddressId;
  String? createdAt;
  String? updatedAt;
  String? categoryId;
  String? subCategoryId;
  String? servicemanId;
  SubCategory? subCategory;


  factory BookingRequestModel.fromJson(Map<String, dynamic> json) => BookingRequestModel(
    id: json["id"],
    readableId: json['readable_id'],
    customerId: json["customer_id"],
    providerId: json["provider_id"],
    zoneId: json["zone_id"],
    bookingStatus: json["booking_status"],
    isPaid: json["is_paid"],
    paymentMethod: json["payment_method"],
    transactionId: json["transaction_id"],
    totalBookingAmount: json["total_booking_amount"].toString(),
    totalTaxAmount: json["total_tax_amount"].toString(),
    totalDiscountAmount: json["total_discount_amount"].toString(),
    serviceSchedule: json["service_schedule"],
    serviceAddressId: json["service_address_id"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
    categoryId: json["category_id"],
    subCategoryId: json["sub_category_id"],
    servicemanId: json["serviceman_id"],
    subCategory : json['sub_category'] != null
        ? SubCategory.fromJson(json['sub_category'])
        : null,

  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "readable_id": readableId,
    "customer_id": customerId,
    "provider_id": providerId,
    "zone_id": zoneId,
    "booking_status": bookingStatus,
    "is_paid": isPaid,
    "payment_method": paymentMethod,
    "transaction_id": transactionId,
    "total_booking_amount": totalBookingAmount,
    "total_tax_amount": totalTaxAmount,
    "total_discount_amount": totalDiscountAmount,
    "service_schedule": serviceSchedule,
    "service_address_id": serviceAddressId,
    "created_at": createdAt,
    "updated_at": updatedAt,
    "category_id": categoryId,
    "sub_category_id": subCategoryId,
    "serviceman_id": servicemanId,
    "sub_category": subCategory?.toJson()
  };
}

//


