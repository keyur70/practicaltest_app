class PropertyDataModel {
  String? status;
  String? message;
  PropertyData? propertyData;

  PropertyDataModel({this.status, this.message, this.propertyData});

  PropertyDataModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    propertyData =
        json['data'] != null ? PropertyData.fromJson(json['data']) : null;
  }
}

class PropertyData {
  List<Properties>? properties;
  int? count;
  List<int>? propertyIds;

  PropertyData({this.properties, this.count, this.propertyIds});

  PropertyData.fromJson(Map<String, dynamic> json) {
    if (json['properties'] != null) {
      properties = <Properties>[];
      json['properties'].forEach((v) {
        properties!.add(Properties.fromJson(v));
      });
    }
    count = json['count'];
    propertyIds = json['property_ids'].cast<int>();
  }
}

class Properties {
  int? id;
  int? userId;
  String? addressStreetName;
  String? addressArea;
  String? addressCity;
  String? addressPostcode;
  String? addressCountry;
  String? addressCityCode;
  String? addressCountryCode;
  double? latitude;
  double? longitude;
  String? propertyType;
  String? listingType;
  String? roomType;
  int? monthlyPrice;
  int? personPrice;
  int? bedrooms;
  int? bathrooms;
  String? moveInDate;
  String? lengthOfStay;
  String? type;
  int? isSuitableForStudent;
  int? depositAmount;
  int? currentFlatmates;
  String? flatmateGender;
  String? floorPlan;
  String? description;
  String? slug;
  double? nearestLatitude;
  double? nearestLongitude;
  String? nearestLocation;
  String? nearestLocationTime;
  String? nearestLocationType;
  int? createdBy;
  int? updatedBy;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;
  String? propertyUrl;
  String? status;
  bool? isFreeToContact;
  String? freeToContact;
  String? freeWithinDays;
  User? user;
  List<PropertyVideos>? propertyVideos;
  List<PropertyVideos>? propertyImages;
  List<KeyFeatures>? keyFeatures;

  Properties({
    this.id,
    this.userId,
    this.addressStreetName,
    this.addressArea,
    this.addressCity,
    this.addressPostcode,
    this.addressCountry,
    this.addressCityCode,
    this.addressCountryCode,
    this.latitude,
    this.longitude,
    this.propertyType,
    this.listingType,
    this.roomType,
    this.monthlyPrice,
    this.personPrice,
    this.bedrooms,
    this.bathrooms,
    this.moveInDate,
    this.lengthOfStay,
    this.type,
    this.isSuitableForStudent,
    this.depositAmount,
    this.currentFlatmates,
    this.flatmateGender,
    this.floorPlan,
    this.description,
    this.slug,
    this.nearestLatitude,
    this.nearestLongitude,
    this.nearestLocation,
    this.nearestLocationTime,
    this.nearestLocationType,
    this.createdBy,
    this.updatedBy,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.propertyUrl,
    this.status,
    this.isFreeToContact,
    this.freeToContact,
    this.freeWithinDays,
    this.user,
    this.propertyVideos,
    this.propertyImages,
    this.keyFeatures,
  });

  Properties.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    addressStreetName = json['address_street_name'];
    addressArea = json['address_area'];
    addressCity = json['address_city'];
    addressPostcode = json['address_postcode'];
    addressCountry = json['address_country'];
    addressCityCode = json['address_city_code'];
    addressCountryCode = json['address_country_code'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    propertyType = json['property_type'];
    listingType = json['listing_type'];
    roomType = json['room_type'];
    monthlyPrice = json['monthly_price'];
    personPrice = json['person_price'];
    bedrooms = json['bedrooms'];
    bathrooms = json['bathrooms'];
    moveInDate = json['move_in_date'];
    lengthOfStay = json['length_of_stay'];
    type = json['type'];
    isSuitableForStudent = json['is_suitable_for_student'];
    depositAmount = json['deposit_amount'];
    currentFlatmates = json['current_flatmates'];
    flatmateGender = json['flatmate_gender'];
    floorPlan = json['floor_plan'];
    description = json['description'];
    slug = json['slug'];
    nearestLatitude = json['nearest_latitude'];
    nearestLongitude = json['nearest_longitude'];
    nearestLocation = json['nearest_location'];
    nearestLocationTime = json['nearest_location_time'];
    nearestLocationType = json['nearest_location_type'];
    createdBy = json['created_by'];
    updatedBy = json['updated_by'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
    propertyUrl = json['property_url'];
    status = json['status'];
    isFreeToContact = json['is_free_to_contact'];
    freeToContact = json['free_to_contact'];
    freeWithinDays = json['free_within_days'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
    if (json['property_videos'] != null) {
      propertyVideos = <PropertyVideos>[];
      json['property_videos'].forEach((v) {
        propertyVideos!.add(PropertyVideos.fromJson(v));
      });
    }
    if (json['property_images'] != null) {
      propertyImages = <PropertyVideos>[];
      json['property_images'].forEach((v) {
        propertyImages!.add(PropertyVideos.fromJson(v));
      });
    }

    if (json['key_features'] != null) {
      keyFeatures = <KeyFeatures>[];
      json['key_features'].forEach((v) {
        keyFeatures!.add(KeyFeatures.fromJson(v));
      });
    }
  }
}

class User {
  int? id;
  String? profileImage;
  String? name;
  String? profileImageUrl;

  User({this.id, this.profileImage, this.name, this.profileImageUrl});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    profileImage = json['profile_image'];
    name = json['name'];
    profileImageUrl = json['profile_image_url'];
  }
}

class PropertyVideos {
  int? id;
  int? userId;
  int? propertyId;
  String? path;
  String? type;
  String? thumbnail;

  PropertyVideos({
    this.id,
    this.userId,
    this.propertyId,
    this.path,
    this.type,
    this.thumbnail,
  });

  PropertyVideos.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    propertyId = json['property_id'];
    path = json['path'];
    type = json['type'];
    thumbnail = json['thumbnail'];
  }
}

class KeyFeatures {
  int? id;
  String? type;
  String? name;
  String? darkIcon;
  String? colorIcon;
  String? darkIconUrl;
  String? colorIconUrl;
  Pivot? pivot;

  KeyFeatures({
    this.id,
    this.type,
    this.name,
    this.darkIcon,
    this.colorIcon,
    this.darkIconUrl,
    this.colorIconUrl,
    this.pivot,
  });

  KeyFeatures.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    type = json['type'];
    name = json['name'];
    darkIcon = json['dark_icon'];
    colorIcon = json['color_icon'];
    darkIconUrl = json['dark_icon_url'];
    colorIconUrl = json['color_icon_url'];
    pivot = json['pivot'] != null ? Pivot.fromJson(json['pivot']) : null;
  }
}

class Pivot {
  int? propertyId;
  int? keyFeatureId;

  Pivot({this.propertyId, this.keyFeatureId});

  Pivot.fromJson(Map<String, dynamic> json) {
    propertyId = json['property_id'];
    keyFeatureId = json['key_feature_id'];
  }
}
