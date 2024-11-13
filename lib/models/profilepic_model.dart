class ProfilePicModel {
  final String userId;
  String currentImageUrl;
  final List<String> previousImageUrls;

  ProfilePicModel({
    required this.userId,
    required this.currentImageUrl,
    required this.previousImageUrls,
  });

  factory ProfilePicModel.fromMap(Map<String, dynamic> data) {
    return ProfilePicModel(
      userId: data['userId'],
      currentImageUrl: data['currentImageUrl'],
      previousImageUrls: List<String>.from(data['previousImageUrls'] ?? []),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'currentImageUrl': currentImageUrl,
      'previousImageUrls': previousImageUrls,
    };
  }

  void updateProfilePicture(String newImageUrl) {
    previousImageUrls.add(currentImageUrl);
    currentImageUrl = newImageUrl;
  }

  ProfilePicModel copyWith({
    String? userId,
    String? currentImageUrl,
    List<String>? previousImageUrls,
  }) {
    return ProfilePicModel(
      userId: userId ?? this.userId,
      currentImageUrl: currentImageUrl ?? this.currentImageUrl,
      previousImageUrls: previousImageUrls ?? this.previousImageUrls,
    );
  }
}
