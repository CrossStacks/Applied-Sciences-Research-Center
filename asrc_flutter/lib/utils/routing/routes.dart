import 'package:flutter/material.dart';
import '../../models/reading_page_model.dart';
import '../../pages/about_page.dart';
import '../../pages/add_or_modify_event.dart';
import '../../pages/admin_page.dart';
import '../../pages/event_page.dart';
import '../../pages/home_page.dart';
import '../../pages/index.dart';
import '../../pages/manage_events_page.dart';
import '../../pages/manage_users_page.dart';
import '../../pages/publication_page.dart';
import '../../pages/reading_page.dart';
import '../../pages/signin_page.dart';
import '../../pages/signup_page.dart';
import 'routes_name.dart';

class Routes {
  static Widget getPage(String routeName, {Object? arguments}) {
    switch (routeName) {
      case RouteName.index:
        return const Index();
      case RouteName.homePage:
        return const HomePage();
      case RouteName.aboutPage:
        return const AboutPage();
      case RouteName.addOrModifyEvent:
        return const AddOrModifyEvent();
      case RouteName.eventPage:
        return EventPage();
      case RouteName.publicationPage:
        return PublicationPage();
      case RouteName.signinPage:
        return SignInPage();
      case RouteName.signupPage:
        return const SignUpPage();
      case RouteName.adminPage:
        return const AdminPage();
      case RouteName.manageUsersPage:
        return const ManageUsersPage();
      case RouteName.manageEventsPage:
        return const ManageEventsPage();
      case RouteName.readingPage:
        return ReadingPage(
          url: Uri.parse('https://flutter.dev'),
          previousPageTitle: "Publications",
          title: "Music and Sleep – Does Music Help You Sleep?",
          description:
              "Music uniquely syncs with your brain, slowing your heart rate and reducing cortisol - the stress hormone.",
          content: [
            ReadingContent(
                type: "paragraph",
                content:
                    'The connection between music and sleep is real—and backed by science. Listening to calming music before bed can help lower stress, relax your body, and create the perfect environment for sleep. Music uniquely syncs with your brain, slowing your heart rate and reducing cortisol (the stress hormone). Certain types of music, especially classical or soothing instrumental pieces, are often recommended to help you unwind. But not all music works the same for everyone. So now you’re wondering, “Does classical music improve sleep quality?” “Is it safe to sleep with music on?” and “Does music really help with insomnia?” Well, stick around as we tackle all that and much more!'),
            ReadingContent(
                type: "image",
                content: "",
                imageUrl:
                    "https://images.unsplash.com/photo-1518770660439-4636190af475?auto=format&fit=crop&w=800&q=80"),
            ReadingContent(
                type: "heading", content: "How Music Helps You Sleep"),
            ReadingContent(
                type: "paragraph",
                content:
                    "These quick adjustments will be completed before January 5th and will greatly improve the experience of the mask as we gear up for Beta production."),
            ReadingContent(
                type: "paragraph",
                content:
                    "We’re thrilled with how far we’ve come and can’t wait to bring you the ultimate sleep experience."),
          ],
        );
      default:
        return const Scaffold(
          body: Center(
            child: Text('No route defined'),
          ),
        );
    }
  }

  static Route<dynamic> generateRoute(RouteSettings settings) {
    return MaterialPageRoute(
      builder: (context) => getPage(
        settings.name!,
        arguments: settings.arguments,
      ),
    );
  }
}
