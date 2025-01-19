class JobModel {
  final String id;
  final String category;
  final String title;
  final String description;
  final String vehicleType;
  final double maxLoadCapacity;
  final String plateNumber;
  final String currentLocation;
  final String destination;
  final String materialType;
  final double latitude;
  final double longitude;
  final String type; // Yeni alan

  JobModel({
    required this.id,
    required this.category,
    required this.title,
    required this.description,
    this.vehicleType = '',
    this.maxLoadCapacity = 0.0,
    this.plateNumber = '',
    this.currentLocation = '',
    this.destination = '',
    this.materialType = '',
    this.latitude = 0.0,
    this.longitude = 0.0,
    this.type = '', // Varsayılan değer
  });

  factory JobModel.fromJson(Map<String, dynamic> json) {
    return JobModel(
      id: json['id'] ?? '',
      category: json['category'] ?? '',
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      vehicleType: json['vehicleType'] ?? '',
      maxLoadCapacity: (json['maxLoadCapacity'] ?? 0.0).toDouble(),
      plateNumber: json['plateNumber'] ?? '',
      currentLocation: json['currentLocation'] ?? '',
      destination: json['destination'] ?? '',
      materialType: json['materialType'] ?? '',
      latitude: (json['latitude'] ?? 0.0).toDouble(),
      longitude: (json['longitude'] ?? 0.0).toDouble(),
      type: json['type'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'category': category,
      'title': title,
      'description': description,
      'vehicleType': vehicleType,
      'maxLoadCapacity': maxLoadCapacity,
      'plateNumber': plateNumber,
      'currentLocation': currentLocation,
      'destination': destination,
      'materialType': materialType,
      'latitude': latitude,
      'longitude': longitude,
      'type': type,
    };
  }
}
