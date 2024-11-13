class UserModel {
  final String userId;
  final String email;
  final String firstName;
  final String lastName;
  final String gender;
  final String country;
  final String dateOfBirth;

  UserModel({
    required this.userId,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.gender,
    required this.country,
    required this.dateOfBirth,
  });

  static List<String> nameParts(fullName) => fullName.split(" ");

  factory UserModel.fromMap(Map<String, dynamic> data) {
    return UserModel(
      userId: data['userId'],
      email: data['email'],
      firstName: data['firstName'],
      lastName: data['lastName'],
      gender: data['gender'],
      country: data['country'],
      dateOfBirth: data['dateOfBirth'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'email': email,
      'firstName': firstName,
      'lastName': lastName,
      'gender': gender,
      'country': country,
      'dateOfBirth': dateOfBirth,
    };
  }
}
