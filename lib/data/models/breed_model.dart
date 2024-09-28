class BreedModel {
  final String id;
  final String name;
  final String origin;
  final int intelligence;
  final int adaptability;
  final String description;
  final String lifeSpan;
  final String imageUrl;

  BreedModel(
      {required this.id,
      required this.name,
      required this.origin,
      required this.intelligence,
      required this.description,
      required this.adaptability,
      required this.lifeSpan,
      required this.imageUrl});

  factory BreedModel.fromJson(Map<String, dynamic> json) {
    return BreedModel(
      id: json['id'],
      name: json['name'] ?? '',
      origin: json['origin'] ?? '',
      intelligence: json['intelligence'] ?? '',
      adaptability: json['adaptability'] ?? '',
      description: json['description'] ?? '',
      lifeSpan: json['life_span'] ?? '',
      imageUrl: json['image'] != null ? json['image']['url'] ?? '' : '',
    );
  }
}
