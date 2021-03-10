class Medical {
  Medical({
    this.id,
    this.name,
    this.time,
  });

  int id;
  String name;
  String time;

  factory Medical.fromJson(Map<String, dynamic> json) => Medical(
        id: json["id"],
        name: json["name"],
        time: json["time"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "time": time,
      };
}
