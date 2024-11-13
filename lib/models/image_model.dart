class ImageModel {
  String userId;
  String imageId;
  String imageUrl;
  final String detectionDateTime;
  final String predictedLabel;
  final double confidenceReal;
  final double confidenceFake;
  final double imageSize;
  final double processingTime;
  final bool isDeleted;

  ImageModel({
    required this.userId,
    required this.imageId,
    required this.imageUrl,
    required this.detectionDateTime,
    required this.predictedLabel,
    required this.confidenceReal,
    required this.confidenceFake,
    required this.imageSize,
    required this.processingTime,
    this.isDeleted = false,
  });

  factory ImageModel.fromMap(Map<String, dynamic> data) {
    return ImageModel(
      userId: data['userId'] ?? "",
      imageId: data["imageId"] ?? "",
      imageUrl: data['imageUrl'] ?? '',
      detectionDateTime: data['detectionDateTime'] ?? '',
      predictedLabel: data['predictedLabel'] ?? '',
      confidenceReal: (data['confidenceReal'] as num?)?.toDouble() ?? 0.0,
      confidenceFake: (data['confidenceFake'] as num?)?.toDouble() ?? 0.0,
      imageSize: (data['imageSize'] as num?)?.toDouble() ?? 0.0,
      processingTime: (data['processingTime'] as num?)?.toDouble() ?? 0.0,
      isDeleted: data['isDeleted'] ?? false,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'imageId': imageId,
      'imageUrl': imageUrl,
      'detectionDateTime': detectionDateTime,
      'predictedLabel': predictedLabel,
      'confidenceReal': confidenceReal,
      'confidenceFake': confidenceFake,
      'imageSize': imageSize,
      'processingTime': processingTime,
      'isDeleted': isDeleted,
    };
  }
}
