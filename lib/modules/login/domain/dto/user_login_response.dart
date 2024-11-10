class UserLoginResponse {
  int id;
  String username;
  String email;
  String firstName;
  String lastName;
  String gender;
  String image;
  String accesToken;
  String refreshToken;

  UserLoginResponse({
    required this.id,
    required this.username,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.gender,
    required this.image,
    required this.accesToken,
    required this.refreshToken,
  });

  factory UserLoginResponse.fromJson(Map<String, dynamic> json) {
    return UserLoginResponse(
      id: json['id'],
      username: json['username'],
      email: json['email'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      gender: json['gender'],
      image: json["image"],
      accesToken: json["accessToken"],
      refreshToken: json['refreshToken'],
    );
  }
}
