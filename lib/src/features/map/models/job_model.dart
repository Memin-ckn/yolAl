class JobModel {
  final String id; // 1: İş veren, 2: Taşıyıcı
  final String category; // "carrier" veya "employer"
  final String title; // Harita için kısa açıklama
  final String description; // Genel açıklama
  final String vehicleType; // Taşıyıcı için
  final double maxLoadCapacity; // Taşıyıcı için
  final String plateNumber; // Taşıyıcı için
  final String currentLocation; // Taşıyıcı için
  final String destination; // İş veren için
  final String materialType; // İş veren için (katı/sıvı)
  final double latitude; // Harita için
  final double longitude; // Harita için

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
  });

  factory JobModel.fromJson(Map<String, dynamic> json) {
    return JobModel(
      id: json['id'],
      category: json['category'],
      title: json['title'],
      description: json['description'],
      vehicleType: json['vehicleType'] ?? '',
      maxLoadCapacity: json['maxLoadCapacity']?.toDouble() ?? 0.0,
      plateNumber: json['plateNumber'] ?? '',
      currentLocation: json['currentLocation'] ?? '',
      destination: json['destination'] ?? '',
      materialType: json['materialType'] ?? '',
      latitude: json['latitude']?.toDouble() ?? 0.0,
      longitude: json['longitude']?.toDouble() ?? 0.0,
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
    };
  }
}
