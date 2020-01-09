import 'package:firebase_messaging/firebase_messaging.dart';
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

  Dealer _selectedDealer;

  List _regions = [];
  Region _selectedRegion;

  District _selectedDistrict;

  Lpgmc _selectedLpgmc;

  CylinderSize _selectedCylinderSize;

  Deposite _selectedDeposite;

  String firebaseToken = "";

  @override
  void initState() {

    _firebaseMessaging.getToken().then((_key) {
      print(_key);
      firebaseToken = _key;
    });

    super.initState();
    BlocProvider.of<RegisterBloc>(context).dispatch(FetchAll());
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

  @override
  Widget build(BuildContext context) {
    final registerBloc = BlocProvider.of<RegisterBloc>(context);
    return BlocListener<RegisterBloc, RegisterState>(
      listener: (context, state) {
        if (state is RegisterFailuer) {
          Scaffold.of(context).showSnackBar(
            SnackBar(
              content: Text('${state.error}'),
              backgroundColor: Colors.red,
            ),
          );
        }

        if (state is RegisterSuccess) {
          Scaffold.of(context).showSnackBar(
            SnackBar(
              content: Text('Registration successful'),
              backgroundColor: Colors.green,
              duration: Duration(seconds: 3),
            ),
          );

          Future.delayed(Duration(seconds: 4));
          Navigator.pushReplacement(
              // replcet the curent layout unlike push that just creates new page
              context,
              MaterialPageRoute(
                  builder: (BuildContext cotext) => LoginPage(
                        userRepository: widget.userRepository,
                      )));
        }
      },
      child:
          BlocBuilder<RegisterBloc, RegisterState>(builder: (context, state) {
        if (state is RegisterApiLoading) {
          return Center(child: LoadingIndicator());
        }

        if (state is RegisterApiLoaded) {
          final districts = state.districts;
          final regions = state.regions;
          _regions = regions;
          final lpgmcs = state.lpgmcs;
          final deposites = state.deposites;
          final cylinderSizes = state.cylinderSizes;
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
                _buildDistrictField(dropdownMenuItems: districts),
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
                _buildLpgmcField(dropdownMenuItems: lpgmcs),
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
                        _showSnackbar(
                            mContext: context, text: "Please Select LPGMC");
                      }
                    },
                  ),
                ),
                // SizedBox(
                //   height: 20,
                // ),
                _buildDepositeField(dropdownMenuItems: deposites),
                // SizedBox(
                //   height: 20,
                // ),
                _buildCylinderField(dropdownMenuItems: cylinderSizes),
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
                        return;
                      } else if (_selectedDistrict == null) {
                        _showSnackbar(
                            mContext: context, text: "Please Select District");
                        return;
                      } else if (_selectedDeposite == null) {
                        _showSnackbar(
                            mContext: context, text: "Please Select Deposite");
                        return;
                      } else if (_selectedCylinderSize == null) {
                        _showSnackbar(
                            mContext: context,
                            text: "Please Select Cylinder Size");
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

  onRegisterButtonPressed() {
    BlocProvider.of<RegisterBloc>(context)
      ..dispatch(
        RegisterButtonPressed(
          firstName: _firstNameController.text,
          lastName: _lastNameController.text,
          dealerId: _selectedDealer.id,
          phoneNumber: _phoneNumberController.text.trim(),
          password: _passwordController.text.trim(),
          consumerId: getConsumerId(),
          houseNumber: _houseNumberController.text,
          streetName: _streetNameController.text,
          residentialAddress: _residentialAddressController.text,
          ghanaPostGpsaddress: _residentialAddressController.text,
          districtId: _selectedDistrict.id,
          depositeId: _selectedDeposite.id,
          cylinderSizeId: _selectedCylinderSize.id,
          statusId: 1,
          // latitude: _residentialAddressController.text,
          // longitude: _residentialAddressController.text,
        ),
      );
  }

  getConsumerId() {
    var phoneNumber = _phoneNumberController.text;

    var newNumber = phoneNumber.substring(phoneNumber.length - 4);
    var yer = now.year.toString().substring(now.year.toString().length - 3);

    return "NPACR-${newNumber + yer}";
  }

  _showSnackbar({@required BuildContext mContext, @required String text}) {
    final snackBar = SnackBar(
      content: Text(text,
          style: TextStyle(
            color: Colors.white,
          )),
      backgroundColor: Colors.redAccent,
      elevation: 10,
    );

    Scaffold.of(context).showSnackBar(snackBar);
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

  onChangeDropdownItemCylinder(CylinderSize selectedCylinderSize) {
    setState(() {
      _selectedCylinderSize = selectedCylinderSize;
    });
  }

  Widget _buildCylinderField(
      {@required List<DropdownMenuItem<CylinderSize>> dropdownMenuItems}) {
    return Container(
      // decoration: BoxDecoration(
      //     border: Border.all(color: colorPrimaryYellow, width: 2),
      //     borderRadius: BorderRadius.all(Radius.circular(2)),
      //     shape: BoxShape.rectangle),
      padding: EdgeInsets.only(
        top: 15.0,
      ),
      child: DropdownButton(
        value: _selectedCylinderSize,
        items: dropdownMenuItems,
        hint: Text(
          "Select Cylinder Type",
          style: TextStyle(color: colorPrimary),
        ),
        onChanged: onChangeDropdownItemCylinder,
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

  Widget _buildPasswordField() {
    return TextFormField(
      obscureText: true, // used to set the initial value
      validator: (String value) {
        if (value.trim().isEmpty) return 'Please enter Password.';
        return null;
      },
      style: formTextStyle,
      keyboardType: TextInputType.text,
      decoration: inputDecoration('Password'),
      controller: _passwordController,
    );
  }
}
