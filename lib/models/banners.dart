import 'dart:convert';

class BannerModel {
  final String id;
  final String image;

  BannerModel({
    required this.id,
    required this.image,
  });

  // convert model → Map
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'image': image,
    };
  }

  // convert Map → model
  factory BannerModel.fromMap(Map<String, dynamic> map) {
    return BannerModel(
      id: map['_id'] as String,
      image: map['image'] as String,
    );
  }

  // OPTIONAL (if you use JSON string)
  String toJson() => json.encode(toMap());

  factory BannerModel.fromJson(String source) =>
      BannerModel.fromMap(json.decode(source));
}
