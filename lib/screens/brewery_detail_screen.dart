import 'package:brewery/provider/brewery_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class BreweryDetailsScreen extends StatelessWidget {
  BreweryDetailsScreen({Key? key}) : super(key: key);

  static const Color _whiteColor = Colors.white;

  @override
  Widget build(BuildContext context) {
    final _breweryProvider = context.read<BreweryProvider>();
    final _width = MediaQuery.of(context).size.width;
    final _height = MediaQuery.of(context).size.height;
    String _name = _breweryProvider.brewery.name.toString();
    String _type = _breweryProvider.brewery.breweryType.toString();
    String _obid = _breweryProvider.brewery.obdbId.toString();
    String? _address = _breweryProvider.brewery.address2;
    String? _address2 = _breweryProvider.brewery.address3;
    String? _street = _breweryProvider.brewery.street;
    String? _city = _breweryProvider.brewery.city;
    String? _state = _breweryProvider.brewery.state;
    String? _county_province = _breweryProvider.brewery.countyProvince;
    String? _postal_code = _breweryProvider.brewery.postalCode;
    String? _country = _breweryProvider.brewery.country;
    String? _longitude = _breweryProvider.brewery.longitude;
    String? _latitude = _breweryProvider.brewery.latitude;
    String? _phone = _breweryProvider.brewery.phone;
    String? _website_url = _breweryProvider.brewery.websiteUrl;
    String? _updated_at = _breweryProvider.brewery.updatedAt;
    String? _created_at = _breweryProvider.brewery.createdAt;
    String _creationDate = _created_at.toString().split('T')[0];
    String _dateupdated = _updated_at.toString().split('T')[0];

    final _date = _creationDate;
    final _updateDate = _dateupdated;
    return Hero(
        tag: 'Details',
        child: Scaffold(
            backgroundColor: Colors.blue,
            appBar: AppBar(
              elevation: 0.0,
              backgroundColor: Colors.transparent,
            ),
            body: ListView(
              children: <Widget>[
                const SizedBox(
                  height: 12,
                ),
                const Icon(
                  Icons.business_rounded,
                  size: 150.0,
                  color: _whiteColor,
                ),
                const SizedBox(
                  height: 25.0,
                ),
                Center(
                  child: Text(
                    _name,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: _width / 15,
                        color: _whiteColor),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      top: _height / 30, left: _width / 8, right: _width / 8),
                  child: Column(
                    children: [
                      Text(
                        _type,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: _whiteColor),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(3.0),
                        child: Text(
                          'Created on: ' + _date.toString(),
                          style: const TextStyle(color: _whiteColor),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(3.0),
                        child: Text('Updated on: ' + _updateDate.toString(),
                            style: const TextStyle(color: _whiteColor)),
                      )
                    ],
                  ),
                ),
                Divider(
                  height: _height / 30,
                  color: _whiteColor,
                ),
                Column(
                  children: <Widget>[
                    ListTile(
                      leading: const Icon(
                        Icons.qr_code,
                        color: _whiteColor,
                      ),
                      title: Text(_obid,
                          style: const TextStyle(color: _whiteColor)),
                    ),
                    ListTile(
                      leading: const Icon(
                        Icons.phone,
                        color: _whiteColor,
                      ),
                      title: Text(_phone ?? '',
                          style: const TextStyle(color: _whiteColor)),
                    ),
                    ListTile(
                      leading: const Icon(
                        Icons.location_on,
                        color: _whiteColor,
                      ),
                      title: Column(
                        children: [
                          Row(
                            children: [
                              Text(_street ?? '' '',
                                  style: const TextStyle(color: _whiteColor)),
                              Text(_address ?? '' '',
                                  style: const TextStyle(color: _whiteColor)),
                              Text(_address2 ?? '' '',
                                  style: const TextStyle(color: _whiteColor)),
                            ],
                          ),
                          Row(
                            children: [
                              Text(_postal_code ?? '' ' ',
                                  style: const TextStyle(color: _whiteColor)),
                              Text(_city ?? '' ' ',
                                  style: const TextStyle(color: _whiteColor)),
                              Text(_county_province ?? '' ' ',
                                  style: const TextStyle(color: _whiteColor)),
                              Text(_country ?? '' ' ',
                                  style: const TextStyle(color: _whiteColor)),
                            ],
                          ),
                        ],
                      ),
                    ),
                    ListTile(
                      leading: const Icon(
                        Icons.map,
                        color: _whiteColor,
                      ),
                      title: Text(_longitude ?? '',
                          style: const TextStyle(color: _whiteColor)),
                    ),
                    ListTile(
                      leading: const Icon(
                        Icons.map_outlined,
                        color: _whiteColor,
                      ),
                      title: Text(_latitude ?? '',
                          style: const TextStyle(color: _whiteColor)),
                    )
                  ],
                ),
                Divider(height: _height / 30, color: _whiteColor),
              ],
            )));
  }
}
