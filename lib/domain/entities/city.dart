class City {
  final int? id;
  final String name;
  final double snowiness;
  final String? image;

  City({
    this.id,
    required this.name,
    required this.snowiness,
    this.image,
  });

  City copy({
    int? id,
    String? name,
    double? snowiness,
    String? image,
  }) =>
      City(
        id: id ?? this.id,
        name: name ?? this.name,
        snowiness: snowiness ?? this.snowiness,
        image: image ?? this.image,
      );
}