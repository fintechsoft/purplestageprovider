class ArtisticModel {
  String? responseCode;
  String? message;
  ArtisticInfo? artisticinfo;

  ArtisticModel({this.responseCode, this.message, this.artisticinfo});

  ArtisticModel.fromJson(Map<String, dynamic> json) {
    responseCode = json['response_code'];
    message = json['message'];
    artisticinfo = json['content']?['provider_profile'] != null
        ? ArtisticInfo.fromJson(json['content']['provider_profile'])
        : null;
    print("artisticInfo--${artisticinfo}");
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['response_code'] = responseCode;
    data['message'] = message;
    if (artisticinfo!= null) {
      data['content'] = artisticinfo!.toJson();
    }
    return data;
  }
}

class ArtisticInfo {
  String? id;
  String? userId;
  String? cName;
  String? cPhone;
  String? rpName;
  String? category;
  String? categoryName;
  String? bio;
  String? achievements;
  String? socialId1;
  String? socialId2;
  String? socialId3;
  String? logoFullPath;
  List<String>? promoServices; // New field for promo services
  String? other_deliverable; // Single selection for honorarium
  String? cashHonorarium; // Single selection for honorarium
  List<String>? benefitsInKind; // Multiple selection for benefits
  String? createdAt;
  String? updatedAt;


  // Constructor
  ArtisticInfo({
    this.id,
    this.userId,
    this.cName,
    this.cPhone,
    this.rpName,
    this.category,
    this.categoryName,
    this.bio,
    this.achievements,
    this.socialId1,
    this.socialId2,
    this.socialId3,
    this.logoFullPath,
    this.promoServices,
    this.other_deliverable,
    this.cashHonorarium,
    this.benefitsInKind,
    this.createdAt,
    this.updatedAt,
  });

  // From JSON factory method
  factory ArtisticInfo.fromJson(Map<String, dynamic> json) {
    return ArtisticInfo(
      id: json['id'] as String?,
      userId: json['user_id'] as String?,
      cName: json['name'] as String?,
      cPhone: json['phone'] as String?,
      rpName: json['rp_name'] as String?,
      category: json['category'] as String?,
      categoryName: json['category_name'] as String?,
      bio: json['bio'] as String?,
      achievements: json['achievements'] as String?,
      socialId1: json['social_id_1'] as String?,
      socialId2: json['social_id_2'] as String?,
      socialId3: json['social_id_3'] as String?,
      logoFullPath: json['logoFullPath'] as String?,
      promoServices: (json['promo_services'] as String?)?.split(',') ?? [],
      other_deliverable:json['other_deliverable'] as String?,
      cashHonorarium: json['Cash_honorarium'] as String?,
      benefitsInKind: (json['benefits'] as String?)?.split(',') ?? [],
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
    );
  }

  // To JSON method
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'cName': cName,
      'cPhone': cPhone,
      'rpName': rpName,
      'category': category,
      'categoryName': categoryName,
      'bio': bio,
      'achievements': achievements,
      'social_id_1': socialId1,
      'social_id_2': socialId2,
      'social_id_3': socialId3,
      'logoFullPath': logoFullPath,
      'promo_services': promoServices?.join(','),
      'other_deliverable': other_deliverable,
      'cash_honorarium': cashHonorarium,
      'benefits_in_kind': benefitsInKind?.join(','),
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }
}



