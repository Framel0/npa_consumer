import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:npa_user/bloc/blocs.dart';
import 'package:npa_user/data/consumer_info.dart';
import 'package:npa_user/model/models.dart';
import 'package:npa_user/util/text_input_util.dart';
import 'package:npa_user/values/color.dart';
import 'package:npa_user/widget/widgets.dart';

class NewAddressForm extends StatefulWidget {
  @override
  _NewAddressFormState createState() => _NewAddressFormState();
}

class _NewAddressFormState extends State<NewAddressForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextStyle formTextStyle = TextStyle(fontSize: 18.0, color: Colors.black);

  final _houseNumberController = TextEditingController();
  final _streetNameController = TextEditingController();
  final _residentialAddressController = TextEditingController();
  final _regionController = TextEditingController();
  final _gpsAddressController = TextEditingController();

  List<Region> _regions = [];

  Region _selectedRegion;

  District _selectedDistrict;
  User user;
  int userId;

  @override
  void dispose() {
    _houseNumberController.dispose();
    _streetNameController.dispose();
    _residentialAddressController.dispose();
    _regionController.dispose();
    _gpsAddressController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    BlocProvider.of<AddressBloc>(context).dispatch(FetchAddresseApis());
    getUser();
  }

  getUser() {
    readUserData().then((value) {
      setState(() {
        user = value;
        userId = user.id;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AddressBloc, AddressState>(
      listener: (context, state) {
        if (state is AddressSuccess) {
          BlocProvider.of<AddressBloc>(context)
              .dispatch(FetchAddresses(id: userId));
          Navigator.pop(context);
        }
      },
      child: BlocBuilder<AddressBloc, AddressState>(builder: (context, state) {
        if (state is AddressApiLoading) {
          return Center(
            child: LoadingIndicator(),
          );
        }

        if (state is AddressLoading) {
          return Center(
            child: LoadingIndicator(),
          );
        }

        if (state is AddressApiLoaded) {
          final districts = state.districts;
          _regions = state.regions;
          return Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                _buildHouseNumberField(),
                _buildStreetNameField(),
                _buildResidentialAddressField(),
                SizedBox(
                  height: 15,
                ),
                _buildDistrictField(dropdownMenuItems: districts),
                _buildRegionsField(),
                _buildGpsAddressField(),
                SizedBox(
                  height: 35,
                ),
                buildButton(context),
              ],
            ),
          );
        }

        if (state is AddressApiLoading) {
          return Center(
            child: Column(
              children: <Widget>[
                Text("Please try again"),
                IconButton(
                  icon: Icon(Icons.refresh),
                  onPressed: () {
                    BlocProvider.of<AddressBloc>(context)
                        .dispatch(FetchAddresseApis());
                  },
                )
              ],
            ),
          );
        }
      }),
    );
  }

  Container buildButton(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: RaisedButton(
        shape: new RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(0.0)),
            side: BorderSide(color: Colors.white)),
        padding: EdgeInsets.symmetric(vertical: 12.0),
        // color: Theme.of(context).buttonColor,
        textColor: Colors.white,
        child: Text(
          'Add Address',
          style: TextStyle(fontSize: 18),
        ),
        onPressed: () {
          _formKey.currentState.save();

          if (!_formKey.currentState.validate()) {
            return;
          } else {
            onAddAddressButtonPressed();
          }
        },
      ),
    );
  }

  onAddAddressButtonPressed() {
    BlocProvider.of<AddressBloc>(context)
      ..dispatch(
        AddNewAddress(
          consumerId: userId,
          houseNumber: _houseNumberController.text.trim(),
          streetName: _streetNameController.text.trim(),
          residentialAddress: _residentialAddressController.text.trim(),
          districtId: _selectedDistrict.id,
          ghanaPostGpsaddress: _gpsAddressController.text.trim(),
        ),
      );
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

  Region getDistrictRegion(District district) {
    final region = _regions.firstWhere((r) {
      return r.id == district.regionId;
    });

    return region;
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

  Widget _buildResidentialAddressField() {
    return TextFormField(
      validator: (String value) {
        if (value.trim().isEmpty) return 'Please enter Residential Address.';
        return null;
      },
      style: formTextStyle,
      textInputAction: TextInputAction.done,
      keyboardType: TextInputType.text,
      decoration: inputDecoration("Residential Address"),
      controller: _residentialAddressController,
    );
  }

  Widget _buildGpsAddressField() {
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
}
