import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../utils/dimensions.dart';
import '../utils/url_launcher.dart';

class CustomTeamCard extends StatelessWidget {
  final Map<String, dynamic> memberData;
  const CustomTeamCard({super.key, required this.memberData});

  @override
  Widget build(BuildContext context) {
    final String firstName = memberData["FirstName"] ?? "No";
    final String lastName = memberData["LastName"] ?? "Name";
    final String fullName = "$firstName $lastName";
    final String designation = memberData["Designation"] ?? "Team Member";
    final String profession = memberData["Profession"] ?? "";
    final String about = memberData["About"] ?? "";
    final String profilePhotoUrl = memberData["ProfilePhotoUrl"] ?? "";
    final String editorialRole = memberData["EditorialRole"] ?? "";
    final String linkedIn = memberData["LinkedIn"] ?? "";
    final String qualificationLevel = memberData["QualificationLevel"] ?? "";
    final String email = memberData["Email"] ??
        ""; //TODO: Add email (deeplink) to member button next to linkedin

    final Widget imageWidget = profilePhotoUrl.isNotEmpty
        ? ShaderMask(
            shaderCallback: (Rect bounds) {
              return LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.white, Colors.transparent],
                stops: const [0.1, 1.0],
              ).createShader(bounds);
            },
            blendMode: BlendMode.dstIn,
            child: ColorFiltered(
              colorFilter: ColorFilter.mode(Colors.grey, BlendMode.saturation),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  profilePhotoUrl,
                  fit: BoxFit.cover,
                  width: Dimensions.isDesktop(context) ? 328 : 240,
                ),
              ),
            ),
          )
        : Image.asset(
            'assets/person_icon.png',
            fit: BoxFit.cover,
            width: Dimensions.isDesktop(context) ? 328 : 240,
          );

    return Container(
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 244, 241, 237),
        borderRadius: BorderRadius.circular(25),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 50),
        child: Stack(
          children: [
            Positioned(
              right: 0,
              top: 0,
              child: InkWell(
                customBorder: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                onTap: () {
                  launchUrlSafe(Uri.parse(linkedIn));
                },
                child: Container(
                  height: 50,
                  width: 50,
                  padding: const EdgeInsets.all(13),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.grey,
                      width: 0.5,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: SvgPicture.asset('assets/linkedin.svg'),
                ),
              ),
            ),
            if (Dimensions.isMobile(context))
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _ImagePart(
                    imageWidget: imageWidget,
                    editorialRole: editorialRole,
                  ),
                  const SizedBox(height: 16),
                  _TextPart(
                    qualificationLevel: qualificationLevel,
                    fullName: fullName,
                    profession: profession,
                    designation: designation,
                    about: about,
                  ),
                ],
              ),
            if (Dimensions.isTablet(context) || Dimensions.isDesktop(context))
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _ImagePart(
                    imageWidget: imageWidget,
                    editorialRole: editorialRole,
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: _TextPart(
                      qualificationLevel: qualificationLevel,
                      fullName: fullName,
                      designation: designation,
                      profession: profession,
                      about: about,
                    ),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}

class _ImagePart extends StatelessWidget {
  final Widget imageWidget;
  final String editorialRole;
  const _ImagePart({
    required this.imageWidget,
    required this.editorialRole,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        imageWidget,
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(100),
            ),
            child: Text(
              editorialRole,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: Dimensions.isDesktop(context) ? 20 : 16,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _TextPart extends StatelessWidget {
  final String fullName;
  final String profession;
  final String qualificationLevel;
  final String designation;
  final String about;
  const _TextPart({
    required this.fullName,
    required this.profession,
    required this.designation,
    required this.about,
    required this.qualificationLevel,
  });

  List<Widget> _buildAboutParagraphs() {
    final processedAbout = about.replaceAll(r'\n', '\n');
    final paragraphs = processedAbout
        .split(RegExp(r'\r?\n'))
        .where((p) => p.trim().isNotEmpty)
        .toList();

    List<Widget> widgets = [];
    for (int i = 0; i < paragraphs.length; i++) {
      widgets.add(Text(
        paragraphs[i],
        style: const TextStyle(fontSize: 16),
      ));
      if (i < paragraphs.length - 1) {
        widgets.add(const SizedBox(height: 10));
      }
    }
    return widgets;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          qualificationLevel != 'PhD'
              ? '$fullName, $qualificationLevel'
              : 'Dr. $fullName, $qualificationLevel',
          style: TextStyle(
            fontSize: Dimensions.isDesktop(context) ? 32 : 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          '$designation / $profession',
          style: TextStyle(
            fontSize: Dimensions.isDesktop(context) ? 20 : 16,
            color: Colors.grey,
          ),
        ),
        const SizedBox(height: 16),
        ..._buildAboutParagraphs(),
      ],
    );
  }
}
