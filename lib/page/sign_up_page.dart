import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:npa_user/bloc/blocs.dart';
import 'package:http/http.dart' as http;
import 'package:npa_user/repositories/repositories.dart';
import 'package:npa_user/widget/widgets.dart';

class RegisterPage extends StatefulWidget {
  final UserRepository userRepository;

  const RegisterPage({Key key, @required this.userRepository})
      : super(key: key);
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextStyle style = TextStyle(fontSize: 18.0, color: Colors.black);

  @override
  Widget build(BuildContext context) {
    final _width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: BlocProvider(
        builder: (context) {
          return RegisterBloc(
            // authenticationBloc: BlocProvider.of<AuthenticationBloc>(context),
            userRepository: widget.userRepository,
            districtRepository: DistrictRepository(
                districtApiClient:
                    DistrictApiClient(httpClient: http.Client())),

            regionRepository: RegionRepository(
                regionApiClient: RegionApiClient(httpClient: http.Client())),
            lpgmcRepository: LpgmcRepository(
                lpgmcApiClient: LpgmcApiClient(httpClient: http.Client())),
            depositeRepository: DepositeRepository(
                depositeApiClient:
                    DepositeApiClient(httpClient: http.Client())),
            productRepository: ProductRepository(
                productApiClient: ProductApiClient(httpClient: http.Client())),
          );
        },
        child: new SingleChildScrollView(
            child: new Container(
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
              // color: Colors.indigoAccent,

              ),
          child: SafeArea(
            child: Center(
              child: ListView(shrinkWrap: true, children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: _width / 17, vertical: 10.0),
                  child: new Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      FormLogo(),
                      SizedBox(
                        height: 30,
                      ),
                      RegisterForm(
                        userRepository: UserRepository(),
                      )
                    ],
                  ),
                ),
              ]),
            ),
          ),
        )),
      ),
    );
  }
}
