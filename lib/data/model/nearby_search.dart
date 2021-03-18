class NearbySearch {
  NearbySearch({
    this.htmlAttributions,
    this.results,
    this.status,
  });

  List<dynamic> htmlAttributions;
  List<NearbyResult> results;
  String status;

  factory NearbySearch.fromJson(Map<String, dynamic> json) => NearbySearch(
        htmlAttributions:
            List<dynamic>.from(json["html_attributions"].map((x) => x)),
        results: List<NearbyResult>.from(
            json["results"].map((x) => NearbyResult.fromJson(x))),
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "html_attributions": List<dynamic>.from(htmlAttributions.map((x) => x)),
        "results": List<dynamic>.from(results.map((x) => x.toJson())),
        "status": status,
      };
}

class NearbyResult {
  NearbyResult({
    this.geometry,
    this.icon,
    this.id,
    this.name,
    this.openingHours,
    // this.photos,
    this.placeId,
    this.reference,
    this.types,
    this.vicinity,
  });

  NearbyGeometry geometry;
  String icon;
  String id;
  String name;
  OpeningHours openingHours;
  // List<Photo> photos;
  String placeId;
  String reference;
  List<String> types;
  String vicinity;

  factory NearbyResult.fromJson(Map<String, dynamic> json) => NearbyResult(
        geometry: NearbyGeometry.fromJson(json["geometry"]),
        icon: json["icon"],
        id: json["id"],
        name: json["name"],
        openingHours: json["opening_hours"] == null
            ? null
            : OpeningHours.fromJson(json["opening_hours"]),
        // photos: List<Photo>.from(json["photos"].map((x) => Photo.fromJson(x))),
        placeId: json["place_id"],
        reference: json["reference"],
        types: List<String>.from(json["types"].map((x) => x)),
        vicinity: json["vicinity"],
      );

  Map<String, dynamic> toJson() => {
        "geometry": geometry.toJson(),
        "icon": icon,
        "id": id,
        "name": name,
        "opening_hours": openingHours == null ? null : openingHours.toJson(),
        // "photos": List<dynamic>.from(photos.map((x) => x.toJson())),
        "place_id": placeId,
        "reference": reference,
        "types": List<dynamic>.from(types.map((x) => x)),
        "vicinity": vicinity,
      };
}

class NearbyGeometry {
  NearbyGeometry({
    this.location,
  });

  NearbyLocation location;

  factory NearbyGeometry.fromJson(Map<String, dynamic> json) => NearbyGeometry(
        location: NearbyLocation.fromJson(json["location"]),
      );

  Map<String, dynamic> toJson() => {
        "location": location.toJson(),
      };
}

class NearbyLocation {
  NearbyLocation({
    this.lat,
    this.lng,
  });

  double lat;
  double lng;

  factory NearbyLocation.fromJson(Map<String, dynamic> json) => NearbyLocation(
        lat: json["lat"].toDouble(),
        lng: json["lng"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "lat": lat,
        "lng": lng,
      };
}

class OpeningHours {
  OpeningHours({
    this.openNow,
  });

  bool openNow;

  factory OpeningHours.fromJson(Map<String, dynamic> json) => OpeningHours(
        openNow: json["open_now"],
      );

  Map<String, dynamic> toJson() => {
        "open_now": openNow,
      };
}

class Photo {
  Photo({
    this.height,
    this.htmlAttributions,
    this.photoReference,
    this.width,
  });

  int height;
  List<dynamic> htmlAttributions;
  String photoReference;
  int width;

  factory Photo.fromJson(Map<String, dynamic> json) => Photo(
        height: json["height"],
        htmlAttributions:
            List<dynamic>.from(json["html_attributions"].map((x) => x)),
        photoReference: json["photo_reference"],
        width: json["width"],
      );

  Map<String, dynamic> toJson() => {
        "height": height,
        "html_attributions": List<dynamic>.from(htmlAttributions.map((x) => x)),
        "photo_reference": photoReference,
        "width": width,
      };
}
