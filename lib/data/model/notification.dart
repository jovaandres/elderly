class NotificationModel {
  NotificationModel({
    this.id,
    this.name,
    this.message,
    this.sender,
  });

  String? id;
  String? name;
  String? message;
  String? sender;

  factory NotificationModel.fromJson(Map<String, dynamic> json) =>
      NotificationModel(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
        message: json["message"] == null ? null : json["message"],
        sender: json["sender"] == null ? null : json["sender"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "name": name == null ? null : name,
        "message": message == null ? null : message,
        "sender": sender == null ? null : sender,
      };
}
