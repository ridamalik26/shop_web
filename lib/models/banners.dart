class BannerModel {
  final String id;
  final String image;

  BannerModel({
    required this.id,
    required this.image,
  });

  /// Convert BannerModel → Map (USED FOR API POST)
  Map<String, dynamic> toJson() {
    return {
      "image": image,
    };
  }

  /// Convert Map → BannerModel (USED FOR API GET)
  factory BannerModel.fromJson(Map<String, dynamic> json) {
    return BannerModel(
      id: json['_id'] ?? '',
      image: json['image'] ?? '',
    );
  }
}
