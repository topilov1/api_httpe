// To parse this JSON data, do
//
//     final odam = odamFromJson(jsonString);

import 'dart:convert';

List<Odam> odamFromJson(String str) =>
    List<Odam>.from(json.decode(str).map((x) => Odam.fromJson(x)));

String odamToJson(List<Odam> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Odam {
  Odam({
    required this.name,
    required this.id,
  });

  String name;
  String id;

  factory Odam.fromJson(Map<String, dynamic> json) => Odam(
        name: json["name"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "id": id,
      };
}
