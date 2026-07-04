class BookingSettingResponseModel {
  String? responseCode;
  String? message;
  List<BookingSettingContent>? settingsList;


  BookingSettingResponseModel({this.responseCode, this.message, this.settingsList});

  BookingSettingResponseModel.fromJson(Map<String, dynamic> json) {
    responseCode = json['response_code'];
    message = json['message'];
    if (json['content'] != null) {
      settingsList = <BookingSettingContent>[];
      json['content'].forEach((v) {
        settingsList!.add(BookingSettingContent.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['response_code'] = responseCode;
    data['message'] = message;
    if (settingsList != null) {
      data['content'] = settingsList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class BookingSettingContent {
  String? keyName;
  int? liveValues;
  int? testValues;
  String? mode;

  BookingSettingContent({this.keyName, this.liveValues, this.testValues, this.mode});

  BookingSettingContent.fromJson(Map<String, dynamic> json) {
    keyName = json['key_name'];
    liveValues = int.tryParse(json['live_values'].toString());
    testValues = int.tryParse(json['test_values'].toString());
    mode = json['mode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['key_name'] = keyName;
    data['live_values'] = liveValues;
    data['test_values'] = testValues;
    data['mode'] = mode;
    return data;
  }
}
