import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flushbar/flushbar_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:npa_user/bloc/blocs.dart';
import 'package:npa_user/model/models.dart';
import 'package:npa_user/page/sign_in_page.dart';
import 'package:npa_user/repositories/repositories.dart';
import 'package:npa_user/routes/routes.dart';
import 'package:npa_user/util/util.dart';
import 'package:npa_user/values/color.dart';
import 'package:npa_user/widget/widgets.dart';

class RegisterForm extends StatefulWidget {
  final UserRepository userRepository;

  const RegisterForm({Key key, @required this.userRepository})
      : super(key: key);
  @override
  _RegisterFormState createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextStyle formTextStyle = TextStyle(fontSize: 18.0, color: Colors.black);

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

  static var now = new DateTime.now();
  static var formatter = new DateFormat('yyyy-MM-dd hh:mm');
  static String date = ('${now.year}/${now.month}/${now.day}');
  static String formatedDate = formatter.format(now);

  final _dateController = TextEditingController(text: date);
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _houseNumberController = TextEditingController();
  final _streetNameController = TextEditingController();
  final _residentialAddressController = TextEditingController();
  final _gpsAddressController = TextEditingController();
  static final _phoneNumberController = TextEditingController();
  final _consumerIdController = TextEditingController();
  final _passwordController = TextEditingController();
  final _dealerController = TextEditingController();
  final _regionController = TextEditingController();

  bool _showPassword = true;

  Dealer _selectedDealer;

  List _regions = [];
  Region _selectedRegion;

  List _districts = [];
  District _selectedDistrict;

  List _lpgmcs = [];
  Lpgmc _selectedLpgmc;

  List _products = [];
  Product _selectedProduct;

  List _deposites = [];
  Deposite _selectedDeposite;

  String firebaseToken = "";

  @override
  void initState() {
    super.initState();

    getFirebaseToken();

    BlocProvider.of<RegisterBloc>(context).dispatch(FetchAll());
  }

  getFirebaseToken() async {
    await _firebaseMessaging.getToken().then((_key) {
      print(_key);
      firebaseToken = _key;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<RegisterBloc, RegisterState>(
      listener: (context, state) {
        if (state is RegisterFailuer) {
          FlushbarHelper.createError(
            title: "Error",
            message: "${state.error}",
          )..show(context).then((result) {
              Navigator.pop(context);
              // Navigator.pushReplacement(
              //     context,
              //     MaterialPageRoute(
              //         builder: (BuildContext cotext) => LoginPage(
              //               userRepository: widget.userRepository,
              //             )));
            });
        }

        if (state is RegisterSuccess) {
          FlushbarHelper.createSuccess(
            title: "Success",
            message: "Registration Successful",
            duration: Duration(seconds: 2),
          )..show(context).then((result) {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext cotext) => LoginPage(
                            userRepository: widget.userRepository,
                          )));
            });
        }
      },
      child:
          BlocBuilder<RegisterBloc, RegisterState>(builder: (context, state) {
        if (state is RegisterApiLoading) {
          return Center(child: LoadingIndicator());
        }

        if (state is RegisterApiLoaded) {
          final districts = state.districts;
          _districts = districts;

          final regions = state.regions;
          _regions = regions;

          final lpgmcs = state.lpgmcs;
          _lpgmcs = lpgmcs;

          final deposites = state.deposites;
          _deposites = deposites;

          final cylinderSizes = state.products;
          _products = cylinderSizes;

          return Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                _buildDateField(),
                // SizedBox(
                //   height: 20,
                // ),
                _buildFirstNameField(),
                // SizedBox(
                //   height: 10,
                // ),
                _buildLastNameField(),
                // SizedBox(
                //   height: 10,
                // ),
                _buildHouseNumberField(),
                // SizedBox(
                //   height: 10,
                // ),
                _buildStreetNameField(),
                // SizedBox(
                //   height: 20,
                // ),
                _buildAreaField(),
                // SizedBox(
                //   height: 20,
                // ),
                _buildDistrictField(dropdownMenuItems: _districts),
                // SizedBox(
                //   height: 20,
                // ),
                _buildRegionsField(),
                // SizedBox(
                //   height: 20,
                // ),
                _buildGhanaPostGpsAddressField(),
                // SizedBox(
                //   height: 20,
                // ),
                _buildPhoneNumberField(),
                // SizedBox(
                //   height: 20,
                // ),
                _buildPasswordField(),
                // SizedBox(
                //   height: 20,
                // ),
                _buildLpgmcField(dropdownMenuItems: _lpgmcs),
                // SizedBox(
                //   height: 20,
                // ),
                _buildDealerField(),
                SizedBox(
                  height: 20,
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  child: RaisedButton(
                    shape: new RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(0.0)),
                        side: BorderSide(color: Colors.white)),
                    padding: EdgeInsets.symmetric(vertical: 12.0),
                    // color: Theme.of(context).buttonColor,
                    textColor: Colors.white,
                    child: Text(
                      'Choose Dealer',
                      style: TextStyle(fontSize: 18),
                    ),
                    onPressed: () {
                      if (_selectedLpgmc != null) {
                        _navigatrToMap(context);
                      } else {
                        FlushbarHelper.createInformation(
                            message: "Please Select LPGMC")
                          ..show(context);
                      }
                    },
                  ),
                ),
                // SizedBox(
                //   height: 20,
                // ),
                _buildDepositeField(dropdownMenuItems: _deposites),
                // SizedBox(
                //   height: 20,
                // ),
                _buildProductField(dropdownMenuItems: _products),
                SizedBox(
                  height: 30,
                ),
                Container(
                  child: state is RegisterLoading ? LoadingIndicator() : null,
                ),
                SizedBox(
                  height: 30,
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  child: RaisedButton(
                    shape: new RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(0.0)),
                        side: BorderSide(color: Colors.white)),
                    padding: EdgeInsets.symmetric(vertical: 12.0),
                    // color: Theme.of(context).buttonColor,
                    textColor: Colors.white,
                    child: Text(
                      'Register',
                      style: TextStyle(fontSize: 18),
                    ),
                    onPressed: () {
                      _formKey.currentState.save();

                      if (!_formKey.currentState.validate()) {
                        FlushbarHelper.createInformation(
                            message: "Please enter values for required fields")
                          ..show(context);
                        return;
                      } else if (_selectedDistrict == null) {
                        FlushbarHelper.createInformation(
                            message: "Please Select District")
                          ..show(context);
                        return;
                      } else if (_selectedDeposite == null) {
                        FlushbarHelper.createInformation(
                            message: "Please Select Deposit Type")
                          ..show(context);
                        return;
                      } else if (_selectedProduct == null) {
                        FlushbarHelper.createInformation(
                            message: "Please Select Product")
                          ..show(context);
                        return;
                      } else {
                        onRegisterButtonPressed();
                      }
                    },
                  ),
                ),
                SizedBox(
                  height: 25,
                ),
                FlatButton(
                  child: Text(
                    'Already have an account, Login',
                    style: TextStyle(
                      // color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                  onPressed: () {
                    Navigator.pushReplacement(
                        // replcet the curent layout unlike push that just creates new page
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext cotext) => LoginPage(
                                  userRepository: widget.userRepository,
                                )));
                  },
                ),
              ],
            ),
          );
        }

        if (state is RegisterFailuer) {
          return Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                _buildDateField(),
                // SizedBox(
                //   height: 20,
                // ),
                _buildFirstNameField(),
                // SizedBox(
                //   height: 10,
                // ),
                _buildLastNameField(),
                // SizedBox(
                //   height: 10,
                // ),
                _buildHouseNumberField(),
                // SizedBox(
                //   height: 10,
                // ),
                _buildStreetNameField(),
                // SizedBox(
                //   height: 20,
                // ),
                _buildAreaField(),
                // SizedBox(
                //   height: 20,
                // ),
                _buildDistrictField(dropdownMenuItems: _districts),
                // SizedBox(
                //   height: 20,
                // ),
                _buildRegionsField(),
                // SizedBox(
                //   height: 20,
                // ),
                _buildGhanaPostGpsAddressField(),
                // SizedBox(
                //   height: 20,
                // ),
                _buildPhoneNumberField(),
                // SizedBox(
                //   height: 20,
                // ),
                _buildPasswordField(),
                // SizedBox(
                //   height: 20,
                // ),
                _buildLpgmcField(dropdownMenuItems: _lpgmcs),
                // SizedBox(
                //   height: 20,
                // ),
                _buildDealerField(),
                SizedBox(
                  height: 20,
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  child: RaisedButton(
                    shape: new RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(0.0)),
                        side: BorderSide(color: Colors.white)),
                    padding: EdgeInsets.symmetric(vertical: 12.0),
                    // color: Theme.of(context).buttonColor,
                    textColor: Colors.white,
                    child: Text(
                      'Choose Dealer',
                      style: TextStyle(fontSize: 18),
                    ),
                    onPressed: () {
                      if (_selectedLpgmc != null) {
                        _navigatrToMap(context);
                      } else {
                        FlushbarHelper.createInformation(
                            message: "Please Select LPGMC")
                          ..show(context);
                      }
                    },
                  ),
                ),
                // SizedBox(
                //   height: 20,
                // ),
                _buildDepositeField(dropdownMenuItems: _deposites),
                // SizedBox(
                //   height: 20,
                // ),
                _buildProductField(dropdownMenuItems: _products),
                SizedBox(
                  height: 30,
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  child: RaisedButton(
                    shape: new RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(0.0)),
                        side: BorderSide(color: Colors.white)),
                    padding: EdgeInsets.symmetric(vertical: 12.0),
                    // color: Theme.of(context).buttonColor,
                    textColor: Colors.white,
                    child: Text(
                      'Register',
                      style: TextStyle(fontSize: 18),
                    ),
                    onPressed: () {
                      _formKey.currentState.save();

                      if (!_formKey.currentState.validate()) {
                        FlushbarHelper.createInformation(
                            message: "Please enter values for required fields")
                          ..show(context);
                        return;
                      } else if (_selectedDistrict == null) {
                        FlushbarHelper.createInformation(
                            message: "Please Select District")
                          ..show(context);
                        return;
                      } else if (_selectedDeposite == null) {
                        FlushbarHelper.createInformation(
                            message: "Please Select Deposit Type")
                          ..show(context);
                        return;
                      } else if (_selectedProduct == null) {
                        FlushbarHelper.createInformation(
                            message: "Please Select Product")
                          ..show(context);
                        return;
                      } else {
                        onRegisterButtonPressed();
                      }
                    },
                  ),
                ),
                SizedBox(
                  height: 25,
                ),
                FlatButton(
                  child: Text(
                    'Already have an account, Login',
                    style: TextStyle(
                      // color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                  onPressed: () {
                    Navigator.pushReplacement(
                        // replcet the curent layout unlike push that just creates new page
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext cotext) => LoginPage(
                                  userRepository: widget.userRepository,
                                )));
                  },
                ),
              ],
            ),
          );
        }
      }),
    );
  }

  _clearTextField() {
    _dateController.text = "";
    _firstNameController.text = "";
    _lastNameController.text = "";
    _residentialAddressController.text = "";
    _gpsAddressController.text = "";
    _phoneNumberController.text = "";
    _consumerIdController.text = "";
    _passwordController.text = "";
    _dealerController.text = "";
  }

  @override
  void dispose() {
    _dateController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _houseNumberController.dispose();
    _streetNameController.dispose();
    _residentialAddressController.dispose();
    _gpsAddressController.dispose();
    // _phoneNumberController.dispose();
    _consumerIdController.dispose();
    _passwordController.dispose();
    _dealerController.dispose();
    super.dispose();
  }

  onRegisterButtonPressed() {
    BlocProvider.of<RegisterBloc>(context)
      ..dispatch(
        RegisterButtonPressed(
          firstName: _firstNameController.text,
          lastName: _lastNameController.text,
          dealerId: _selectedDealer.id,
          phoneNumber: _phoneNumberController.text.trim(),
          password: _passwordController.text.trim(),
          houseNumber: _houseNumberController.text,
          streetName: _streetNameController.text,
          residentialAddress: _residentialAddressController.text,
          ghanaPostGpsaddress: _residentialAddressController.text,
          districtId: _selectedDistrict.id,
          depositeId: _selectedDeposite.id,
          productId: _selectedProduct.id,
          registrationType: 1,
          firebaseToken: firebaseToken,
          // latitude: _residentialAddressController.text,
          // longitude: _residentialAddressController.text,
        ),
      );
  }

  _navigatrToMap(BuildContext context) async {
    // Navigator.push returns a Future that completes after calling
    // Navigator.pop on the Selection Screen.
    var result = await Navigator.pushNamed(context, dealersMapRoute,
        arguments: _selectedLpgmc);
    print(" result from map: $result");
    if (result != null) {
      _selectedDealer = result;
      _dealerController.text =
          _selectedDealer.firstName + " " + _selectedDealer.lastName;
    }
  }

  Widget _buildDateField() {
    return TextFormField(
      // autovalidate: true,
      enabled: false,
      style: formTextStyle,
      textInputAction: TextInputAction.done,
      keyboardType: TextInputType.datetime,
      decoration: inputDecoration('Date'),
      controller: _dateController,
      onSaved: (String value) {},
    );
  }

  Widget _buildFirstNameField() {
    return TextFormField(
      validator: (String value) {
        if (value.trim().isEmpty) return 'Please enter First Name.';
        return null;
      },
      style: formTextStyle,
      textInputAction: TextInputAction.done,
      keyboardType: TextInputType.text,
      decoration: inputDecoration("First Name"),
      controller: _firstNameController,
    );
  }

  Widget _buildLastNameField() {
    return TextFormField(
      validator: (String value) {
        if (value.trim().isEmpty) return 'Please enter Last Name.';
        return null;
      },
      style: formTextStyle,
      textInputAction: TextInputAction.done,
      keyboardType: TextInputType.text,
      decoration: inputDecoration("Last Name"),
      controller: _lastNameController,
    );
  }

  Widget _buildHouseNumberField() {
    return TextFormField(
      validator: (String value) {
        if (value.trim().isEmpty) return 'Please enter House Number';
        return null;
      },
      style: formTextStyle,
      textInputAction: TextInputAction.done,
      keyboardType: TextInputType.text,
      decoration: inputDecoration("House Number"),
      controller: _houseNumberController,
    );
  }

  Widget _buildStreetNameField() {
    return TextFormField(
      validator: (String value) {
        if (value.trim().isEmpty) return 'Please enter Street Name';
        return null;
      },
      style: formTextStyle,
      textInputAction: TextInputAction.done,
      keyboardType: TextInputType.text,
      decoration: inputDecoration("Street Name"),
      controller: _streetNameController,
    );
  }

  Widget _buildAreaField() {
    return TextFormField(
      validator: (String value) {
        if (value.trim().isEmpty) return 'Please enter Residential Area';
        return null;
      },
      style: formTextStyle,
      textInputAction: TextInputAction.done,
      keyboardType: TextInputType.text,
      decoration: inputDecoration("Residential Area"),
      controller: _residentialAddressController,
    );
  }

  onChangeDropdownItemRegion(Region selectedRgion) {
    setState(() {
      _selectedRegion = selectedRgion;
    });
  }

  // Widget _buildRegionField() {
  //   return Container(
  //     decoration: BoxDecoration(
  //         border: Border.all(color: colorPrimaryYellow, width: 2),
  //         borderRadius: BorderRadius.all(Radius.circular(2)),
  //         shape: BoxShape.rectangle),
  //     padding: EdgeInsets.symmetric(
  //       horizontal: 10.0,
  //     ),
  //     child: DropdownButton(
  //       value: _selectedRegion,
  //       items: regionRepository.getDropdownMenuItems(_selectedDistrict),
  //       hint: Text(
  //         "Select Region",
  //         style: TextStyle(color: colorPrimary),
  //       ),
  //       onChanged: onChangeDropdownItemRegion,
  //       style: formTextStyle,
  //       isExpanded: true,
  //     ),
  //   );
  // }

  Widget _buildRegionsField() {
    return TextFormField(
      validator: (String value) {
        if (value.trim().isEmpty) return 'Please select District';
        return null;
      },
      style: formTextStyle,
      textInputAction: TextInputAction.done,
      keyboardType: TextInputType.text,
      decoration: inputDecoration("Region"),
      controller: _regionController,
      enabled: false,
    );
  }

  Region getDistrictRegion(District district) {
    final region = _regions.firstWhere((r) {
      return r.id == district.regionId;
    });

    return region;
  }

  onChangeDropdownItemDistrict(District selectedDistrict) {
    setState(() {
      _selectedDistrict = selectedDistrict;
      _selectedRegion = getDistrictRegion(_selectedDistrict);
      _regionController.text = _selectedRegion.name;
    });
  }

  Widget _buildDistrictField(
      {@required List<DropdownMenuItem<District>> dropdownMenuItems}) {
    return Container(
      // decoration: BoxDecoration(
      //     border: Border.all(color: colorPrimaryYellow, width: 2),
      //     borderRadius: BorderRadius.all(Radius.circular(2)),
      //     shape: BoxShape.rectangle),
      padding: EdgeInsets.only(
        top: 15.0,
      ),
      child: DropdownButton(
        value: _selectedDistrict,
        items: dropdownMenuItems,
        hint: Text(
          "Select District",
          style: TextStyle(color: colorPrimary),
        ),
        onChanged: onChangeDropdownItemDistrict,
        style: formTextStyle,
        isExpanded: true,
      ),
    );
  }

  Widget _buildGhanaPostGpsAddressField() {
    return TextFormField(
      validator: (String value) {
        if (value.trim().isEmpty) return 'Please enter GPS Address.';
        return null;
      },
      style: formTextStyle,
      textInputAction: TextInputAction.done,
      keyboardType: TextInputType.text,
      decoration: inputDecoration("Ghana Post GPS Address"),
      controller: _gpsAddressController,
    );
  }

  Widget _buildGpsAddressLocationField() {
    return TextFormField(
      validator: (String value) {
        if (value.trim().isEmpty) return 'Please select GPS Location.';
        return null;
      },
      style: formTextStyle,
      textInputAction: TextInputAction.done,
      keyboardType: TextInputType.text,
      decoration: inputDecoration("Ghana Post GPS Location"),
      controller: _gpsAddressController,
    );
  }

  Widget _buildPhoneNumberField() {
    return TextFormField(
      validator: (String value) {
        if (value.trim().length < 10 || value.trim().isEmpty)
          return 'Please enter valid Phone Number.';
        return null;
      },
      style: formTextStyle,
      textInputAction: TextInputAction.done,
      keyboardType: TextInputType.phone,
      decoration: inputDecoration('Phone Number'),
      controller: _phoneNumberController,
    );
  }

  onChangeDropdownItemLpgmc(Lpgmc selectedLpgmc) {
    setState(() {
      _selectedLpgmc = selectedLpgmc;
    });
  }

  Widget _buildLpgmcField(
      {@required List<DropdownMenuItem<Lpgmc>> dropdownMenuItems}) {
    return Container(
      // decoration: BoxDecoration(
      //     border: Border.all(color: colorPrimaryYellow, width: 2),
      //     borderRadius: BorderRadius.all(Radius.circular(2)),
      //     shape: BoxShape.rectangle),
      padding: EdgeInsets.only(
        top: 15.0,
      ),
      child: DropdownButton(
        value: _selectedLpgmc,
        items: dropdownMenuItems,
        hint: Text(
          "Select LPGMC",
          style: TextStyle(color: colorPrimary),
        ),
        onChanged: onChangeDropdownItemLpgmc,
        style: formTextStyle,
        isExpanded: true,
      ),
    );
  }

  Widget _buildDealerField() {
    return TextFormField(
      // used to set the initial value
      enabled: false,
      validator: (String value) {
        if (value.trim().isEmpty) return 'Please Choose Dealer.';
        return null;
      },
      style: formTextStyle,
      keyboardType: TextInputType.text,
      decoration: inputDecoration('Dealer'),
      controller: _dealerController,
    );
  }

  onChangeDropdownItemProduct(Product selectedProduct) {
    setState(() {
      _selectedProduct = selectedProduct;
    });
  }

  Widget _buildProductField(
      {@required List<DropdownMenuItem<Product>> dropdownMenuItems}) {
    return Container(
      // decoration: BoxDecoration(
      //     border: Border.all(color: colorPrimaryYellow, width: 2),
      //     borderRadius: BorderRadius.all(Radius.circular(2)),
      //     shape: BoxShape.rectangle),
      padding: EdgeInsets.only(
        top: 15.0,
      ),
      child: DropdownButton(
        value: _selectedProduct,
        items: dropdownMenuItems,
        hint: Text(
          "Select Cylinder Type",
          style: TextStyle(color: colorPrimary),
        ),
        onChanged: onChangeDropdownItemProduct,
        style: formTextStyle,
        isExpanded: true,
      ),
    );
  }

  onChangeDropdownItemDeposite(Deposite selectedDeposite) {
    setState(() {
      _selectedDeposite = selectedDeposite;
    });
  }

  Widget _buildDepositeField(
      {@required List<DropdownMenuItem<Deposite>> dropdownMenuItems}) {
    return Container(
      // decoration: BoxDecoration(
      //     border: Border.all(color: colorPrimaryYellow, width: 2),
      //     borderRadius: BorderRadius.all(Radius.circular(2)),
      //     shape: BoxShape.rectangle),
      padding: EdgeInsets.only(
        top: 15.0,
      ),
      child: DropdownButton(
        value: _selectedDeposite,
        items: dropdownMenuItems,
        hint: Text(
          "Select Deposit",
          style: TextStyle(color: colorPrimary),
        ),
        onChanged: onChangeDropdownItemDeposite,
        style: formTextStyle,
        isExpanded: true,
      ),
    );
  }

  _toggleVisibility() {
    setState(() {
      _showPassword = !_showPassword;
    });
  }

  Widget _buildPasswordField() {
    return TextFormField(
      obscureText: true, // used to set the initial value
      validator: (String value) {
        if (value.trim().isEmpty) return 'Please enter Password.';
        return null;
      },
      style: formTextStyle,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
          labelStyle: TextStyle(color: colorPrimary),
          errorStyle: TextStyle(
            color: Colors.red,
          ),
          labelText: "Password",
          suffixIcon: IconButton(
            icon: Icon(_showPassword ? Icons.visibility_off : Icons.visibility),
            onPressed: _toggleVisibility,
          )),
      controller: _passwordController,
    );
  }
}
