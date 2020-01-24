import 'package:flutter/material.dart';
import 'package:npa_user/page/address_select_page.dart';
import 'package:npa_user/page/pages.dart';
import 'package:npa_user/repositories/repositories.dart';
import 'package:npa_user/routes/routes.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case addressesRoute:
        return MaterialPageRoute(builder: (_) => AddressesPage());
        break;
      case contactUsRoute:
        return MaterialPageRoute(builder: (_) => ContactPage());
        break;
      case requestHistoryRoute:
        return MaterialPageRoute(builder: (_) => RequestHistoryPage());
        break;
      case requestHistoryDetailRoute:
        return MaterialPageRoute(
            builder: (_) => RequestHistoryDetailPage(
                  requestHistory: args,
                ));
        break;
      case homeRoute:
        return MaterialPageRoute(builder: (_) => MyHomePage());
        break;
      case newAddressRoute:
        return MaterialPageRoute(builder: (_) => NewAddressPage());
        break;
      case profileEditRoute:
        return MaterialPageRoute(builder: (_) => ProfileEditPage());
        break;
      case profileRoute:
        return MaterialPageRoute(builder: (_) => ProfilePage());
        break;
      case requestRoute:
        return MaterialPageRoute(builder: (_) => RequestPage());
        break;
      case safetyTipRoute:
        return MaterialPageRoute(builder: (_) => SafetyTipPage());
        break;
      case landingRoute:
        return MaterialPageRoute(
            builder: (_) => LandingPage(
                  userRepository: UserRepository(),
                ));
        break;
      case loginRoute:
        return MaterialPageRoute(
            builder: (_) => LoginPage(userRepository: UserRepository()));
        break;
      case registerRoute:
        return MaterialPageRoute(
            builder: (_) => RegisterPage(
                  userRepository: UserRepository(),
                ));
        break;
      case summaryRoute:
        return MaterialPageRoute(builder: (_) => SummaryPage());
        break;
      case upcomingOrderRoute:
        return MaterialPageRoute(builder: (_) => UpcomingRequestPage());
        break;
      case upcomingRequestDetailRoute:
        return MaterialPageRoute(
            builder: (_) => UpcomingRequestDetailPage(
                  upcomingRequest: args,
                ));
        break;
      case addressChangeRoute:
        return MaterialPageRoute(builder: (_) => AddressSelectPage());
        break;
      case dealersMapRoute:
        return MaterialPageRoute(
            builder: (_) => DealersMapPage(
                  lpgmc: args,
                ));
        break;
      case notificationRoute:
        return MaterialPageRoute(builder: (_) => NotifiactionPage());
        break;
      case requestTrackingMapRoute:
        return MaterialPageRoute(builder: (_) => RequestTrackingMapPage());
        break;
      default:
    }
  }
}
