class City {
  final int? id;
  final String name;
  final double snowiness;
  final String? image;
  final DateTime time;

  City({
    this.id,
    required this.name,
    required this.snowiness,
    this.image,
    required this.time,
  });

  City copy({
    int? id,
    String? name,
    double? snowiness,
    String? image,
    DateTime? time,
  }) =>
      City(
        id: id ?? this.id,
        name: name ?? this.name,
        snowiness: snowiness ?? this.snowiness,
        image: image ?? this.image,
        time: time ?? this.time,
      );
}