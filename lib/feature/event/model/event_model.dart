class EventModel {
  String? responseCode;
  String? message;
  EventContent? eventContent;

  EventModel({this.responseCode, this.message, this.eventContent});

  EventModel.fromJson(Map<String, dynamic> json) {
    responseCode = json['response_code'];
    message = json['message'];
    eventContent = json['content'] != null ? EventContent.fromJson(json['content']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['response_code'] = responseCode;
    data['message'] = message;
    if (eventContent != null) {
      data['content'] = eventContent!.toJson();
    }
    return data;
  }
}

class EventContent {
  int? currentPage;
  List<EventData>? eventData;
  int? lastPage;
  int? perPage;
  int? to;
  int? total;

  EventContent({this.currentPage, this.eventData, this.lastPage, this.perPage, this.to, this.total});

  EventContent.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      eventData = <EventData>[];
      json['data'].forEach((v) {
        eventData!.add(EventData.fromJson(v));
      });
    }
    lastPage = json['last_page'];
    perPage = json['per_page'];
    to = json['to'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['current_page'] = currentPage;
    if (eventData != null) {
      data['data'] = eventData!.map((v) => v.toJson()).toList();
    }
    data['last_page'] = lastPage;
    data['per_page'] = perPage;
    data['to'] = to;
    data['total'] = total;
    return data;
  }
}

class EventData {
  String? id;
  String? readableId;
  String? providerId;
  String? eventName;
  String? institutionName;
  String? contactNo;
  String? typeOfEvent;
  String? eventTime;
  String? venue;
  String? eventDescription;
  String? eventPoster;
  String? eventPosterFullPath;
  String? posterDescription;
  String? bookingStatus;
  int? isPaid;
  String? createdAt;
  String? updatedAt;
  int? isChecked;
  int? isVerified;

  EventData({
    this.id,
    this.readableId,
    this.providerId,
    this.eventName,
    this.institutionName,
    this.contactNo,
    this.typeOfEvent,
    this.eventTime,
    this.venue,
    this.eventDescription,
    this.eventPoster,
    this.eventPosterFullPath,
    this.posterDescription,
    this.bookingStatus,
    this.isPaid,
    this.createdAt,
    this.updatedAt,
    this.isChecked,
    this.isVerified,
  });

  EventData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    readableId = json['readable_id'].toString();
    providerId = json['provider_id'];
    eventName = json['event_name'];
    institutionName = json['institution_name'];
    contactNo = json['contact_no'];
    typeOfEvent = json['type_of_event'];
    eventTime = json['event_time'] != null ? json['event_time'] : null;
    venue = json['venue'];
    eventDescription = json['event_description'];
    eventPoster = json['event_poster'];
    eventPosterFullPath = json['event_poster_full_path'];
    posterDescription = json['poster_description'];
    bookingStatus = json['booking_status'];
    isPaid = int.tryParse(json['is_paid'].toString());
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    isChecked = int.tryParse(json['is_checked'].toString());
    isVerified = int.tryParse(json['is_verified'].toString());
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['readable_id'] = readableId;
    data['provider_id'] = providerId;
    data['event_name'] = eventName;
    data['institution_name'] = institutionName;
    data['contact_no'] = contactNo;
    data['type_of_event'] = typeOfEvent;
    data['event_time'] = eventTime;
    data['venue'] = venue;
    data['event_description'] = eventDescription;
    data['event_poster'] = eventPoster;
    data['eventPosterFullPath'] = eventPosterFullPath;
    data['poster_description'] = posterDescription;
    data['booking_status'] = bookingStatus;
    data['is_paid'] = isPaid;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['is_checked'] = isChecked;
    data['is_verified'] = isVerified;
    return data;
  }
}
