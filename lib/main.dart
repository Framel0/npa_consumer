import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:npa_user/bloc/authentication/authentication.dart';
import 'package:npa_user/bloc/bloc.dart';
import 'package:npa_user/bloc/counter_bloc.dart';
import 'package:npa_user/bloc/dealer/dealer.dart';
import 'package:npa_user/bloc/district/district.dart';
import 'package:npa_user/bloc/filtered_districts/filtered_districts.dart';
import 'package:npa_user/bloc/region/region.dart';
import 'package:npa_user/bloc/upcoming_request/upcoming_request.dart';
import 'package:npa_user/page/home_page.dart';
import 'package:npa_user/page/landing_page.dart';
import 'package:npa_user/page/splash_page.dart';
import 'package:npa_user/repositories/repositories.dart';
import 'package:npa_user/routes/route_generator.dart';
import 'package:npa_user/routes/routes.dart';
import 'package:npa_user/values/color.dart';
import 'package:npa_user/widget/widget.dart';

void main() {
  BlocSupervisor.delegate = SimpleBlocDelegate();
  final userRepository = UserRepository();
  // final districtRepository = DistrictRepository(
  //     districtApiClient: DistrictApiClient(httpClient: http.Client()));
  // final regionRepository = RegionRepository(
  //     regionApiClient: RegionApiClient(httpClient: http.Client()));
  final dealerRepository = DealerRepository(
      dealerApiClient: DealerApiClient(
    httpClient: http.Client(),
  ));
  final upcomingRequestRepository = UpcomingRequestRepository(
      upcomingRequestApiClient: UpcomingRequestApiClient(
    httpClient: http.Client(),
  ));

  runApp(MultiBlocProvider(
    providers: [
      BlocProvider<AuthenticationBloc>(
        builder: (context) {
          return AuthenticationBloc(userRepository: userRepository)
            ..dispatch(AppStarted());
        },
      ),
      BlocProvider<DealerBloc>(
        builder: (context) {
          return DealerBloc(dealerRepository: dealerRepository);
          // ..dispatch(FetchDealers());
        },
      ),
      BlocProvider<UpcomingRequestBloc>(
        builder: (context) {
          return UpcomingRequestBloc(
              upcomingRequestRepository: upcomingRequestRepository);
        },
      ),
      // BlocProvider<RegionBloc>(
      //   builder: (context) {
      //     return RegionBloc(regionRepository: regionRepository);
      //   },
      // ),
      // BlocProvider<DistrictBloc>(
      //   builder: (context) {
      //     return DistrictBloc(districtRepository: districtRepository);
      //   },
      // ),
      // BlocProvider<FiltereddistrictBloc>(
      //   builder: (context) {
      //     return FiltereddistrictBloc(
      //         districtBloc: BlocProvider.of<DistrictBloc>(context));
      //   },
      // ),
    ],
    child: MyApp(
      userRepository: userRepository,
    ),
  ));
}

class MyApp extends StatelessWidget {
  final UserRepository userRepository;

  const MyApp({Key key, @required this.userRepository}) : super(key: key);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider<CounterBloc>(
      builder: (context) {
        return CounterBloc();
      },
      child: MaterialApp(
        title: 'NPA User',
        theme: _buildTheme(),
        onGenerateRoute: RouteGenerator.generateRoute,
        home: BlocListener<AuthenticationBloc, AuthenticationState>(
          listener: (context, state) {
            if (state is AuthenticationAuthenticated) {
              Navigator.pushNamedAndRemoveUntil(
                  context, homeRoute, (Route<dynamic> route) => false);
            }
          },
          child: BlocBuilder<AuthenticationBloc, AuthenticationState>(
            builder: (context, state) {
              if (state is AuthenticationUninitialized) {
                return SplashPage();
              }
              if (state is AuthenticationAuthenticated) {
                return MyHomePage();
              }
              if (state is AuthenticationUnauthenticated) {
                // return HomePage();
                return LandingPage(
                  userRepository: userRepository,
                );
              }
              if (state is AuthenticationLoading) {
                return LoadingIndicator();
              }
            },
          ),
        ),
      ),
    );
  }
}

ThemeData _buildTheme() {
  final ThemeData base = ThemeData.light();

  return base.copyWith(
    accentColor: colorAccentYellow,
    primaryColor: colorPrimary,
    buttonTheme: base.buttonTheme.copyWith(
      buttonColor: colorPrimaryYellow,
      textTheme: ButtonTextTheme.normal,
    ),
    scaffoldBackgroundColor: Colors.white,
    cardColor: Colors.white,
    errorColor: kShrineErrorRed,
  );
}
