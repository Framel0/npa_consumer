import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:npa_user/bloc/authentication/authentication.dart';
import 'package:npa_user/bloc/blocs.dart';
import 'package:npa_user/bloc/dealer/dealer.dart';
import 'package:npa_user/bloc/upcoming_request/upcoming_request.dart';
import 'package:npa_user/page/home_page.dart';
import 'package:npa_user/page/pages.dart';
import 'package:npa_user/page/splash_page.dart';
import 'package:npa_user/repositories/repositories.dart';
import 'package:npa_user/routes/route_generator.dart';
import 'package:npa_user/routes/routes.dart';
import 'package:npa_user/values/color.dart';
import 'package:npa_user/widget/widgets.dart';

void main() {
  BlocSupervisor.delegate = SimpleBlocDelegate();
  final userRepository = UserRepository();
  final refillRequestRepository = RefillRequestRepository(
      refillRequestApiClient:
          RefillRequestApiClient(httpClient: http.Client()));

  final refillRequestHistoryRepository = RefillRequestHistoryRepository(
      refillRequestHistoryApiClient:
          RefillRequestHistoryApiClient(httpClient: http.Client()));

  final productRepository = ProductRepository(
      productApiClient: ProductApiClient(httpClient: http.Client()));

  final paymentMethodRepository = PaymentMethodRepository(
      paymentMethodApiClient:
          PaymentMethodApiClient(httpClient: http.Client()));

  final deliveryMethodRepository = DeliveryMethodRepository(
      deliveryMethodApiClient:
          DeliveryMethodApiClient(httpClient: http.Client()));

  final dealerRepository = DealerRepository(
      dealerApiClient: DealerApiClient(
    httpClient: http.Client(),
  ));

  final upcomingRequestRepository = UpcomingRequestRepository(
      upcomingRequestApiClient: UpcomingRequestApiClient(
    httpClient: http.Client(),
  ));

  final addressRepository = AddressRepository(
      addressApiClient: AddressApiClient(
    httpClient: http.Client(),
  ));

  final districtRepository = DistrictRepository(
      districtApiClient: DistrictApiClient(
    httpClient: http.Client(),
  ));

  final regionRepository = RegionRepository(
      regionApiClient: RegionApiClient(
    httpClient: http.Client(),
  ));

  final firebaseRepository = FirebaseRepository(
      firebaseApiClient: FirebaseApiClient(
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
      BlocProvider<ProductBloc>(
        builder: (context) {
          return ProductBloc(productRepository: productRepository);
        },
      ),
      BlocProvider<AddressBloc>(
        builder: (context) {
          return AddressBloc(
              addressRepository: addressRepository,
              districtRepository: districtRepository,
              regionRepository: regionRepository);
        },
      ),
      BlocProvider<AddNewAddressBloc>(
        builder: (context) {
          return AddNewAddressBloc(
              addressRepository: addressRepository,
              districtRepository: districtRepository,
              regionRepository: regionRepository);
        },
      ),
      BlocProvider<RefillRequestBloc>(
        builder: (context) {
          return RefillRequestBloc(
              refillRequestRepository: refillRequestRepository,
              productRepository: productRepository,
              paymentMethodRepository: paymentMethodRepository,
              deliveryMethodRepository: deliveryMethodRepository);
        },
      ),
      BlocProvider<RefillRequestHistoryBloc>(
        builder: (context) {
          return RefillRequestHistoryBloc(
              refillRequestHistoryRepository: refillRequestHistoryRepository);
        },
      ),
      BlocProvider<FirebaseBloc>(
        builder: (context) {
          return FirebaseBloc(firebaseRepository: firebaseRepository);
        },
      ),
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
    return MaterialApp(
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
              // return MyHomePage();
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
