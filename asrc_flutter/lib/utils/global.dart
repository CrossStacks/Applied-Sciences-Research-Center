// ignore_for_file: public_member_api_docs, sort_constructors_first
class Global {
  static int pageIdx = 0;
  static bool isLoggedIn = false;
  static late UserDetail userDetails;
}

class UserDetail {
  final String firstName;
  final String lastName;
  final String designation;
  final String editorialRole;
  final String linkedIn;
  final String profession;
  final String about;
  final String qualificationLevel;
  final String userId;
  final String email;
  final String profilePhotoUrl;
  final bool isVerified;
  final bool isAdmin;

  UserDetail({
    required this.firstName,
    required this.lastName,
    required this.designation,
    required this.editorialRole,
    required this.linkedIn,
    required this.profession,
    required this.about,
    required this.qualificationLevel,
    required this.userId,
    required this.email,
    required this.profilePhotoUrl,
    required this.isVerified,
    required this.isAdmin,
  });
}
