class Exercise {
  Exercise({
    this.name,
    this.video,
  });

  String name;
  Video video;

  factory Exercise.fromJson(Map<String, dynamic> json) => Exercise(
        name: json["name"],
        video: Video.fromJson(json["video"]),
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "video": video.toJson(),
      };
}

class Video {
  Video({
    this.description,
    this.link,
  });

  List<String> description;
  List<String> link;

  factory Video.fromJson(Map<String, dynamic> json) => Video(
        description: List<String>.from(json["description"].map((x) => x)),
        link: List<String>.from(json["link"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "description": List<dynamic>.from(description.map((x) => x)),
        "link": List<dynamic>.from(link.map((x) => x)),
      };
}
