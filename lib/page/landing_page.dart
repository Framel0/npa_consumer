import 'package:flutter/material.dart';
import 'package:npa_user/page/sign_in_page.dart';
import 'package:npa_user/page/sign_up_page.dart';
import 'package:npa_user/repositories/repositories.dart';
import 'package:npa_user/values/color.dart';

class LandingPage extends StatefulWidget {
  final UserRepository userRepository;

  const LandingPage({Key key, @required this.userRepository})
      : assert(userRepository != null),
        super(key: key);
  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            // padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                    height: 150,
                    width: 150,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/images/npa_logo.png'),
                        fit: BoxFit.fitHeight,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 55.0,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    child: OutlineButton(
                      shape: new RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(2.0)),
                      ),
                      borderSide:
                          BorderSide(color: colorAccentYellow, width: 2),
                      padding: EdgeInsets.symmetric(vertical: 14.0),
                      child: Text(
                        "Register",
                        style: TextStyle(
                            color: colorPrimary,
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold),
                      ),
                      onPressed: () {
                        Navigator.push(
                            // replcet the curent layout unlike push that just creates new page
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext cotext) => RegisterPage(
                                      userRepository: UserRepository(),
                                    )));
                      },
                    ),
                  ),
                  SizedBox(
                    height: 25.0,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    child: RaisedButton(
                      shape: new RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(2.0)),
                          side: BorderSide(color: Colors.white)),
                      padding: EdgeInsets.symmetric(vertical: 14.0),
                      child: Text(
                        "Sign In",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold),
                      ),
                      onPressed: () {
                        Navigator.push(
                            // replcet the curent layout unlike push that just creates new page
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext cotext) => LoginPage(
                                      userRepository: widget.userRepository,
                                    )));
                      },
                    ),
                  ),
                  SizedBox(
                    height: 15.0,
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
