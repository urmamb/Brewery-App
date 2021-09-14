import 'dart:io';

import 'package:brewery/model/brewery_list.dart';
import 'package:brewery/provider/brewery_provider.dart';
import 'package:brewery/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';

class MockClient extends Mock implements http.Client {}

late BreweryProvider breweryList;

Widget createBrewery() => ChangeNotifierProvider<BreweryProvider>(
  create: (context) {
    breweryList = BreweryProvider();
    return breweryList;
  },
  child: const MaterialApp(
    home: MyHomeScreen(),
  ),
);

void addItems(Brewery brew) {
    breweryList.brewery = brew;
}


@GenerateMocks([http.Client])
void main() {
  group('fetchBrewery', () async {
    test('returns Brewery if the http call completes successfully', () async {
      final client = MockClient();

      when(client
          .get(Uri.parse('https://api.openbrewerydb.org/breweries')))
          .thenAnswer((_) async =>
          http.Response(File('test/test_resources/random_bewery.json').readAsStringSync(), 200));

      expect(await breweryList.apiCall(client), isA<Brewery>());
    });

    test('throws an exception if the http call completes with an error', () {
      final client = MockClient();

      when(client
          .get(Uri.parse('https://api.openbrewerydb.org/breweries')))
          .thenAnswer((_) async => http.Response('Not Found', 404));

      expect(breweryList.apiCall(client), throwsException);
    });
  });
}