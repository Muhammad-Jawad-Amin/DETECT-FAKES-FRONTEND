class VideoModel {
  String userId;
  String videoId;
  String videoUrl;
  String thumbnailUrl;
  final String detectionDateTime;
  final String predictedLabel;
  final double confidenceReal;
  final double confidenceFake;
  final double videoDuration;
  final double videoSize;
  final double processingTime;
  final int totalFrames;
  final int processedFrames;
  final bool isDeleted;

  VideoModel({
    required this.userId,
    required this.videoId,
    required this.videoUrl,
    required this.thumbnailUrl,
    required this.detectionDateTime,
    required this.predictedLabel,
    required this.confidenceReal,
    required this.confidenceFake,
    required this.videoDuration,
    required this.videoSize,
    required this.processingTime,
    required this.totalFrames,
    required this.processedFrames,
    this.isDeleted = false,
  });

  /// Factory constructor to create a `VideoModel` instance from Firestore data.
  factory VideoModel.fromMap(Map<String, dynamic> data) {
    return VideoModel(
      userId: data['userId'] ?? "",
      videoId: data['videoId'] ?? '',
      videoUrl: data['videoUrl'] ?? '',
      thumbnailUrl: data['thumbnailUrl'] ?? '',
      detectionDateTime: data['detectionDateTime'] ?? '',
      predictedLabel: data['predictedLabel'] ?? '',
      confidenceReal: data['confidenceReal'] ?? 0.0,
      confidenceFake: data['confidenceFake'] ?? 0.0,
      videoDuration: (data['videoDuration'] as num?)?.toDouble() ?? 0.0,
      videoSize: (data['videoSize'] as num?)?.toDouble() ?? 0.0,
      processingTime: (data['processingTime'] as num?)?.toDouble() ?? 0.0,
      totalFrames: data['totalFrames'] ?? 0,
      processedFrames: data['processedFrames'] ?? 0,
      isDeleted: data['isDeleted'] ?? false,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'videoId': videoId,
      'videoUrl': videoUrl,
      'thumbnailUrl': thumbnailUrl,
      'detectionDateTime': detectionDateTime,
      'predictedLabel': predictedLabel,
      'confidenceReal': confidenceReal,
      'confidenceFake': confidenceFake,
      'videoDuration': videoDuration,
      'videoSize': videoSize,
      'processingTime': processingTime,
      'totalFrames': totalFrames,
      'processedFrames': processedFrames,
      'isDeleted': isDeleted,
    };
  }
}
