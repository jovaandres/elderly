class DetailPlaces {
  DetailPlaces({
    this.htmlAttributions,
    this.result,
    this.status,
  });

  List<dynamic>? htmlAttributions;
  DetailResult? result;
  String? status;

  factory DetailPlaces.fromJson(Map<String, dynamic> json) => DetailPlaces(
        htmlAttributions: json["html_attributions"] == null
            ? null
            : List<dynamic>.from(json["html_attributions"].map((x) => x)),
        result: json["result"] == null
            ? null
            : DetailResult.fromJson(json["result"]),
        status: json["status"] == null ? null : json["status"],
      );

  Map<String, dynamic> toJson() => {
        "html_attributions": htmlAttributions == null
            ? null
            : List<dynamic>.from(
                (htmlAttributions as List<dynamic>).map((x) => x)),
        "result": result == null ? null : result?.toJson(),
        "status": status == null ? null : status,
      };
}

class DetailResult {
  DetailResult({
    this.addressComponents,
    this.adrAddress,
    this.businessStatus,
    this.formattedAddress,
    this.formattedPhoneNumber,
    this.icon,
    this.internationalPhoneNumber,
    this.name,
    this.openingHours,
    this.photos,
    this.placeId,
    this.rating,
    this.reference,
    this.types,
    this.url,
    this.userRatingsTotal,
    this.utcOffset,
    this.vicinity,
    this.website,
  });

  List<AddressComponent>? addressComponents;
  String? adrAddress;
  String? businessStatus;
  String? formattedAddress;
  String? formattedPhoneNumber;
  String? icon;
  String? internationalPhoneNumber;
  String? name;
  OpeningHours? openingHours;
  List<PhotoDetail>? photos;
  String? placeId;
  double? rating;
  String? reference;
  List<String>? types;
  String? url;
  int? userRatingsTotal;
  int? utcOffset;
  String? vicinity;
  String? website;

  factory DetailResult.fromJson(Map<String, dynamic> json) => DetailResult(
        addressComponents: json["address_components"] == null
            ? null
            : List<AddressComponent>.from(json["address_components"]
                .map((x) => AddressComponent.fromJson(x))),
        adrAddress: json["adr_address"] == null ? null : json["adr_address"],
        businessStatus:
            json["business_status"] == null ? null : json["business_status"],
        formattedAddress: json["formatted_address"] == null
            ? null
            : json["formatted_address"],
        formattedPhoneNumber: json["formatted_phone_number"] == null
            ? null
            : json["formatted_phone_number"],
        icon: json["icon"] == null ? null : json["icon"],
        internationalPhoneNumber: json["international_phone_number"] == null
            ? null
            : json["international_phone_number"],
        name: json["name"] == null ? null : json["name"],
        openingHours: json["opening_hours"] == null
            ? null
            : OpeningHours.fromJson(json["opening_hours"]),
        photos: json["photos"] == null
            ? null
            : List<PhotoDetail>.from(
                json["photos"].map((x) => PhotoDetail.fromJson(x))),
        placeId: json["place_id"] == null ? null : json["place_id"],
        rating: json["rating"] == null ? null : json["rating"].toDouble(),
        reference: json["reference"] == null ? null : json["reference"],
        types: json["types"] == null
            ? null
            : List<String>.from(json["types"].map((x) => x)),
        url: json["url"] == null ? null : json["url"],
        userRatingsTotal: json["user_ratings_total"] == null
            ? null
            : json["user_ratings_total"],
        utcOffset: json["utc_offset"] == null ? null : json["utc_offset"],
        vicinity: json["vicinity"] == null ? null : json["vicinity"],
        website: json["website"] == null ? null : json["website"],
      );

  Map<String, dynamic> toJson() => {
        "address_components": addressComponents == null
            ? null
            : List<dynamic>.from((addressComponents as List<AddressComponent>)
                .map((x) => x.toJson())),
        "adr_address": adrAddress == null ? null : adrAddress,
        "business_status": businessStatus == null ? null : businessStatus,
        "formatted_address": formattedAddress == null ? null : formattedAddress,
        "formatted_phone_number":
            formattedPhoneNumber == null ? null : formattedPhoneNumber,
        "icon": icon == null ? null : icon,
        "international_phone_number":
            internationalPhoneNumber == null ? null : internationalPhoneNumber,
        "name": name == null ? null : name,
        "opening_hours": openingHours == null ? null : openingHours?.toJson(),
        "photos": photos == null
            ? null
            : List<dynamic>.from(
                (photos as List<PhotoDetail>).map((x) => x.toJson())),
        "place_id": placeId == null ? null : placeId,
        "rating": rating == null ? null : rating,
        "reference": reference == null ? null : reference,
        "types": types == null
            ? null
            : List<dynamic>.from((types as List<String>).map((x) => x)),
        "url": url == null ? null : url,
        "user_ratings_total":
            userRatingsTotal == null ? null : userRatingsTotal,
        "utc_offset": utcOffset == null ? null : utcOffset,
        "vicinity": vicinity == null ? null : vicinity,
        "website": website == null ? null : website,
      };
}

class AddressComponent {
  AddressComponent({
    this.longName,
    this.shortName,
    this.types,
  });

  String? longName;
  String? shortName;
  List<String>? types;

  factory AddressComponent.fromJson(Map<String, dynamic> json) =>
      AddressComponent(
        longName: json["long_name"] == null ? null : json["long_name"],
        shortName: json["short_name"] == null ? null : json["short_name"],
        types: json["types"] == null
            ? null
            : List<String>.from(json["types"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "long_name": longName == null ? null : longName,
        "short_name": shortName == null ? null : shortName,
        "types": types == null
            ? null
            : List<dynamic>.from((types as List<String>).map((x) => x)),
      };
}

class OpeningHours {
  OpeningHours({
    this.openNow,
    this.periods,
    this.weekdayText,
  });

  bool? openNow;
  List<Period>? periods;
  List<String>? weekdayText;

  factory OpeningHours.fromJson(Map<String, dynamic> json) => OpeningHours(
        openNow: json["open_now"] == null ? null : json["open_now"],
        periods: json["periods"] == null
            ? null
            : List<Period>.from(json["periods"].map((x) => Period.fromJson(x))),
        weekdayText: json["weekday_text"] == null
            ? null
            : List<String>.from(json["weekday_text"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "open_now": openNow == null ? null : openNow,
        "periods": periods == null
            ? null
            : List<dynamic>.from(
                (periods as List<Period>).map((x) => x.toJson())),
        "weekday_text": weekdayText == null
            ? null
            : List<dynamic>.from((weekdayText as List<String>).map((x) => x)),
      };
}

class Period {
  Period({
    this.close,
    this.open,
  });

  Close? close;
  Close? open;

  factory Period.fromJson(Map<String, dynamic> json) => Period(
        close: json["close"] == null ? null : Close.fromJson(json["close"]),
        open: json["open"] == null ? null : Close.fromJson(json["open"]),
      );

  Map<String, dynamic> toJson() => {
        "close": close == null ? null : close?.toJson(),
        "open": open == null ? null : open?.toJson(),
      };
}

class Close {
  Close({
    this.day,
    this.time,
  });

  int? day;
  String? time;

  factory Close.fromJson(Map<String, dynamic> json) => Close(
        day: json["day"] == null ? null : json["day"],
        time: json["time"] == null ? null : json["time"],
      );

  Map<String, dynamic> toJson() => {
        "day": day == null ? null : day,
        "time": time == null ? null : time,
      };
}

class PhotoDetail {
  PhotoDetail({
    this.height,
    this.htmlAttributions,
    this.photoReference,
    this.width,
  });

  int? height;
  List<String>? htmlAttributions;
  String? photoReference;
  int? width;

  factory PhotoDetail.fromJson(Map<String, dynamic> json) => PhotoDetail(
        height: json["height"] == null ? null : json["height"],
        htmlAttributions: json["html_attributions"] == null
            ? null
            : List<String>.from(json["html_attributions"].map((x) => x)),
        photoReference:
            json["photo_reference"] == null ? null : json["photo_reference"],
        width: json["width"] == null ? null : json["width"],
      );

  Map<String, dynamic> toJson() => {
        "height": height == null ? null : height,
        "html_attributions": htmlAttributions == null
            ? null
            : List<dynamic>.from(
                (htmlAttributions as List<String>).map((x) => x)),
        "photo_reference": photoReference == null ? null : photoReference,
        "width": width == null ? null : width,
      };
}
