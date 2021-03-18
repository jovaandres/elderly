class NearbySearch {
  NearbySearch({
    this.nextPageToken,
    this.results,
    this.status,
  });

  String? nextPageToken;
  List<NearbyResult>? results;
  String? status;

  factory NearbySearch.fromJson(Map<String, dynamic> json) => NearbySearch(
        nextPageToken:
            json["next_page_token"] == null ? null : json["next_page_token"],
        results: json["results"] == null
            ? null
            : List<NearbyResult>.from(
                json["results"].map((x) => NearbyResult.fromJson(x))),
        status: json["status"] == null ? null : json["status"],
      );

  Map<String, dynamic> toJson() => {
        "next_page_token": nextPageToken == null ? null : nextPageToken,
        "results": results == null
            ? null
            : List<dynamic>.from(
                (results as List<NearbyResult>).map((x) => x.toJson())),
        "status": status == null ? null : status,
      };
}

class NearbyResult {
  NearbyResult({
    this.businessStatus,
    this.icon,
    this.name,
    this.openingHours,
    this.photos,
    this.placeId,
    this.rating,
    this.reference,
    this.scope,
    this.types,
    this.userRatingsTotal,
    this.vicinity,
  });

  String? businessStatus;
  String? icon;
  String? name;
  OpeningHours? openingHours;
  List<Photo>? photos;
  String? placeId;
  double? rating;
  String? reference;
  String? scope;
  List<String>? types;
  int? userRatingsTotal;
  String? vicinity;

  factory NearbyResult.fromJson(Map<String, dynamic> json) => NearbyResult(
        businessStatus:
            json["business_status"] == null ? null : json["business_status"],
        icon: json["icon"] == null ? null : json["icon"],
        name: json["name"] == null ? null : json["name"],
        openingHours: json["opening_hours"] == null
            ? null
            : OpeningHours.fromJson(json["opening_hours"]),
        photos: json["photos"] == null
            ? null
            : List<Photo>.from(json["photos"].map((x) => Photo.fromJson(x))),
        placeId: json["place_id"] == null ? null : json["place_id"],
        rating: json["rating"] == null ? null : json["rating"].toDouble(),
        reference: json["reference"] == null ? null : json["reference"],
        scope: json["scope"] == null ? null : json["scope"],
        types: json["types"] == null
            ? null
            : List<String>.from(json["types"].map((x) => x)),
        userRatingsTotal: json["user_ratings_total"] == null
            ? null
            : json["user_ratings_total"],
        vicinity: json["vicinity"] == null ? null : json["vicinity"],
      );

  Map<String, dynamic> toJson() => {
        "business_status": businessStatus == null ? null : businessStatus,
        "icon": icon == null ? null : icon,
        "name": name == null ? null : name,
        "opening_hours": openingHours == null ? null : openingHours?.toJson(),
        "photos": photos == null
            ? null
            : List<dynamic>.from(
                (photos as List<Photo>).map((x) => x.toJson())),
        "place_id": placeId == null ? null : placeId,
        "rating": rating == null ? null : rating,
        "reference": reference == null ? null : reference,
        "scope": scope == null ? null : scope,
        "types": types == null
            ? null
            : List<String>.from((types as List<String>).map((x) => x)),
        "user_ratings_total":
            userRatingsTotal == null ? null : userRatingsTotal,
        "vicinity": vicinity == null ? null : vicinity,
      };
}

class OpeningHours {
  OpeningHours({
    this.openNow,
  });

  bool? openNow;

  factory OpeningHours.fromJson(Map<String, dynamic> json) => OpeningHours(
        openNow: json["open_now"] == null ? null : json["open_now"],
      );

  Map<String, dynamic> toJson() => {
        "open_now": openNow == null ? null : openNow,
      };
}

class Photo {
  Photo({
    this.height,
    this.photoReference,
    this.width,
  });

  int? height;
  String? photoReference;
  int? width;

  factory Photo.fromJson(Map<String, dynamic> json) => Photo(
        height: json["height"] == null ? null : json["height"],
        photoReference:
            json["photo_reference"] == null ? null : json["photo_reference"],
        width: json["width"] == null ? null : json["width"],
      );

  Map<String, dynamic> toJson() => {
        "height": height == null ? null : height,
        "photo_reference": photoReference == null ? null : photoReference,
        "width": width == null ? null : width,
      };
}
