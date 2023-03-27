class ImageModel {
  final String images;
  final String texts;
  final int id;

  ImageModel({required this.images, required this.texts, required this.id});

  factory ImageModel.fromJson(Map<String, dynamic> json) {
    return ImageModel(
      images: json['images'],
      texts: json['texts'],
      id: json['id'],
    );
  }
}
