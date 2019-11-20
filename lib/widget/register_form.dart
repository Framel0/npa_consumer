import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:npa_user/bloc/bloc.dart';
import 'package:http/http.dart' as http;
import 'package:npa_user/model/models.dart';
import 'package:npa_user/page/sign_in_page.dart';
import 'package:npa_user/repositories/district/district.dart';
import 'package:npa_user/repositories/lpgmc/lpgmc.dart';
import 'package:npa_user/repositories/region/region.dart';
import 'package:npa_user/repositories/repositories.dart';
import 'package:npa_user/routes/routes.dart';
import 'package:npa_user/util/util.dart';
import 'package:npa_user/values/color.dart';
import 'package:npa_user/widget/widget.dart';

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

  static var now = new DateTime.now();
  static var formatter = new DateFormat('yyyy-MM-dd hh:mm');
  static String date = ('${now.year}/ ${now.month}/ ${now.day}');
  static String formatedDate = formatter.format(now);

  final _dateController = TextEditingController(text: date);
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _houseNumberController = TextEditingController();
  final _streetNameController = TextEditingController();
  final _residentialAddressController = TextEditingController();
  final _gpsAddressController = TextEditingController();
  final _phoneNumberController = TextEditingController();
  final _consumerIdController = TextEditingController();
  final _passwordController = TextEditingController();
  final _dealerController = TextEditingController();
  final _regionController = TextEditingController();

  Dealer _selectedDealer;

  RegionRepository regionRepository = RegionRepository();
  Region _selectedRegion;

  DistrictRepository districtRepository = DistrictRepository(
      districtApiClient: DistrictApiClient(httpClient: http.Client()));
  District _selectedDistrict;

  LpgmcRepository lpgmcRepository = LpgmcRepository(
      lpgmcApiClient: LpgmcApiClient(httpClient: http.Client()));
  Lpgmc _selectedLpgmc;

  CylinderRepository cylinderRepository = CylinderRepository(
      cylinderApiClient: CylinderApiClient(httpClient: http.Client()));
  Cylinder _selectedCylinder;

  DepositeRepository depositeRepository = DepositeRepository(
      depositeApiClient: DepositeApiClient(httpClient: http.Client()));
  Deposite _selectedDeposite;

  @override
  void initState() {
    // _selectedRegion = regionRepository.getRegions[0];
    // _selectedDistrict = districtRepository.getDistricts[0];
    super.initState();
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
    _phoneNumberController.dispose();
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
      },
      child:
          BlocBuilder<RegisterBloc, RegisterState>(builder: (context, state) {
        if (state is RegisterLoading) {
          return LoadingIndicator();
        } else {
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
                _buildDistrictField(),
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
                _buildLpgmcField(),
                // SizedBox(
                //   height: 20,
                // ),
                _buildDealerField(),
                // SizedBox(
                //   height: 20,
                // ),
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
                      _navigatrToMap(context);
                    },
                  ),
                ),
                // SizedBox(
                //   height: 20,
                // ),
                _buildDepositeField(),
                // SizedBox(
                //   height: 20,
                // ),
                _buildCylinderField(),
                // SizedBox(
                //   height: 20,
                // ),
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
                      } else {
                        _onRegisterButtonPressed();
                        Future.delayed(Duration(seconds: 3));
                        Navigator.pushReplacement(
                            // replcet the curent layout unlike push that just creates new page
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext cotext) => LoginPage(
                                      userRepository: widget.userRepository,
                                    )));
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

  _onRegisterButtonPressed() {
    BlocProvider.of<RegisterBloc>(context)
      ..dispatch(
        RegisterButtonPressed(
            firstName: _firstNameController.text,
            lastName: _lastNameController.text,
            phoneNumber: _phoneNumberController.text.trim(),
            password: _passwordController.text.trim(),
            consumerId: "NPA-${_phoneNumberController.text.trim()}",
            residentialAddress: _residentialAddressController.text,
            dealerId: _selectedDealer.id),
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
      _dealerController.text = _selectedDealer.ventureName;
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

  Widget _buildRegionField() {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: colorPrimaryYellow, width: 2),
          borderRadius: BorderRadius.all(Radius.circular(2)),
          shape: BoxShape.rectangle),
      padding: EdgeInsets.symmetric(
        horizontal: 10.0,
      ),
      child: DropdownButton(
        value: _selectedRegion,
        items: regionRepository.getDropdownMenuItems(_selectedDistrict),
        hint: Text(
          "Select Region",
          style: TextStyle(color: colorPrimary),
        ),
        onChanged: onChangeDropdownItemRegion,
        style: formTextStyle,
        isExpanded: true,
      ),
    );
  }

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

  onChangeDropdownItemDistrict(District selectedDistrict) {
    setState(() {
      _selectedDistrict = selectedDistrict;
      _selectedRegion = regionRepository.getDistrictRegion(_selectedDistrict);
      _regionController.text = _selectedRegion.name;
    });
  }

  Widget _buildDistrictField() {
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
        items: districtRepository.getDropdownMenuItems(),
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

  Widget _buildLpgmcField() {
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
        items: lpgmcRepository.getDropdownMenuItems(),
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

  onChangeDropdownItemCylinder(Cylinder selectedCylinder) {
    setState(() {
      _selectedCylinder = selectedCylinder;
    });
  }

  Widget _buildCylinderField() {
    return Container(
      // decoration: BoxDecoration(
      //     border: Border.all(color: colorPrimaryYellow, width: 2),
      //     borderRadius: BorderRadius.all(Radius.circular(2)),
      //     shape: BoxShape.rectangle),
      padding: EdgeInsets.only(
        top: 15.0,
      ),
      child: DropdownButton(
        value: _selectedCylinder,
        items: cylinderRepository.getDropdownMenuItems(),
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

  Widget _buildDepositeField() {
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
        items: depositeRepository.getDropdownMenuItems(),
        hint: Text(
          "Select Deposite",
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
