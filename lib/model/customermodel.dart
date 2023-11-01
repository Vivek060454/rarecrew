// To parse this JSON data, do
//
//     final customerlist = customerlistFromJson(jsonString);

import 'dart:convert';

List<Customerlist> customerlistFromJson(String str) => List<Customerlist>.from(json.decode(str).map((x) => Customerlist.fromJson(x)));

String customerlistToJson(List<Customerlist> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Customerlist {
  String id;
  String ?name;
  String ?state;
  String ?city;
  String ?addrese;
  String ?dob;
  String ?image;

  Customerlist({
    required this.id,
     this.name,
     this.state,
     this.city,
     this.addrese,
     this.dob,
    this.image
  });

  factory Customerlist.fromJson(Map<String, dynamic> json) => Customerlist(
    id: json["_id"],
    name: json["name"],
    state: json["state"],
    city: json["city"],
    addrese: json["addrese"],
    dob: json["dob"],
    image: json["image"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "name": name,
    "state": state,
    "city": city,
    "addrese": addrese,
    "dob": dob,
    "image": image,
  };
}
