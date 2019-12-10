import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:npa_user/bloc/blocs.dart';
import 'package:npa_user/model/models.dart';
import 'package:npa_user/repositories/district/district.dart';
import 'package:npa_user/repositories/region/region.dart';
import 'package:npa_user/repositories/repositories.dart';
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
  Widget build(BuildContext context) {
    return BlocBuilder<AddressBloc, AddressState>(builder: (context, state) {
      if (state is AddressApiLoading) {
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
              SizedBox(
                height: 20,
              ),
              _buildStreetNameField(),
              SizedBox(
                height: 20,
              ),
              _buildResidentialAddressField(),
              SizedBox(
                height: 20,
              ),
              _buildDistrictField(dropdownMenuItems: districts),
              SizedBox(
                height: 20,
              ),
              _buildRegionsField(),
              SizedBox(
                height: 20,
              ),
              _buildGpsAddressField(),
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
                    'Save',
                    style: TextStyle(fontSize: 18),
                  ),
                  onPressed: () {
                    _formKey.currentState.save();

                    if (!_formKey.currentState.validate()) {
                      return;
                    } else {
                      Navigator.pop(context);
                    }
                  },
                ),
              ),
            ],
          ),
        );
      }
    });
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
      decoration: BoxDecoration(
          border: Border.all(color: colorPrimaryYellow, width: 2),
          borderRadius: BorderRadius.all(Radius.circular(2)),
          shape: BoxShape.rectangle),
      padding: EdgeInsets.symmetric(
        horizontal: 10.0,
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
        if (value.trim().isEmpty)
          return 'Please enter Residential/Street Address.';
        return null;
      },
      style: formTextStyle,
      textInputAction: TextInputAction.done,
      keyboardType: TextInputType.text,
      decoration: inputDecoration("Residential/Street Address"),
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
