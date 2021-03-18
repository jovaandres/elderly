class Exercise {
  Exercise({
    this.name,
    this.video,
  });

  String? name;
  Video? video;

  factory Exercise.fromJson(Map<String, dynamic> json) => Exercise(
        name: json["name"] == null ? null : json["name"],
        video: json["video"] == null ? null : Video.fromJson(json["video"]),
      );

  Map<String, dynamic> toJson() => {
        "name": name == null ? null : name,
        "video": video == null ? null : (video as Video).toJson(),
      };
}

class Video {
  Video({
    this.description,
    this.link,
  });

  List<String>? description;
  List<String>? link;

  factory Video.fromJson(Map<String, dynamic> json) => Video(
        link: json["link"] == null
            ? null
            : List<String>.from(json["link"].map((x) => x)),
        description: json["description"] == null
            ? null
            : List<String>.from(json["description"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "link": link == null
            ? null
            : List<dynamic>.from((link as List<String>).map((x) => x)),
        "description": description == null
            ? null
            : List<dynamic>.from((description as List<String>).map((x) => x)),
      };
}
