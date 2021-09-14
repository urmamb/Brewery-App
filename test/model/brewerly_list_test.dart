
import 'package:brewery/model/brewery_list.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('test bewery class', () {
    // The model should be able to receive the following data:
    final bewery = Brewery(
      id: 1,
      obdbId: '',
      name: '',
      breweryType: '',
      street: '',
      address2: '',
      address3: '',
      city: '',
      state: '',
      countyProvince: '',
      postalCode: '',
      country: '',
      longitude: '',
      latitude: '',
      phone: '',
      websiteUrl: '',
      updatedAt: '',
      createdAt: '',
    );

    expect(bewery.id, 1);
    expect(bewery.obdbId, '');
    expect(bewery.name, '');
    expect(bewery.breweryType, '');
    expect(bewery.street, '');
    expect(bewery.address2, '');
    expect(bewery.address3, '');
    expect(bewery.city, '');
    expect(bewery.state, '');
    expect(bewery.countyProvince, '');
    expect(bewery.postalCode, '');
    expect(bewery.country, '');
    expect(bewery.longitude, '');
    expect(bewery.latitude, '');
    expect(bewery.phone, '');
    expect(bewery.websiteUrl, '');
    expect(bewery.updatedAt, '');
    expect(bewery.createdAt, '');
  });
}