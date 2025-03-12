class Global {
  static int pageIdx = 0;
  static bool isLoggedIn = false;
  static late UserDetail userDetails;
}

class UserDetail {
  final String firstName;
  final String lastName;
  final String userId;
  final String email;
  final String profilePhotoUrl;
  final bool isVerified;
  final bool isAdmin;

  UserDetail({
    required this.firstName,
    required this.lastName,
    required this.userId,
    required this.email,
    required this.profilePhotoUrl,
    required this.isVerified,
    required this.isAdmin,
  });
}
