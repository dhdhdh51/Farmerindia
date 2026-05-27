class FarmField {
  final String id;
  final String name;
  final String cropType;
  final String soilType;
  final double lat;
  final double lng;
  final String sizeUnit;
  final double size;
  final String notes;
  final String imagePath;

  FarmField({required this.id, required this.name, required this.cropType, required this.soilType, required this.lat, required this.lng, required this.sizeUnit, required this.size, required this.notes, required this.imagePath});

  Map<String, dynamic> toMap() => {
        'id': id,
        'name': name,
        'cropType': cropType,
        'soilType': soilType,
        'lat': lat,
        'lng': lng,
        'sizeUnit': sizeUnit,
        'size': size,
        'notes': notes,
        'imagePath': imagePath,
      };
}
