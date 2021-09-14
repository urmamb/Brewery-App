import 'dart:async';
import 'dart:collection';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:brewery/model/brewery_list.dart';
import 'package:http/http.dart' as http;

class BreweryProvider extends ChangeNotifier {

  bool isLoading = true;
  List<Brewery> _breweryList = <Brewery>[];
  Brewery _brewery = Brewery();

  Brewery get brewery => _brewery;
  String _searchString = "";

  List<Brewery> get breweryData => _breweryList;

  UnmodifiableListView<Brewery> get brew => _searchString.isEmpty
      ? UnmodifiableListView(breweryData)
      : UnmodifiableListView(breweryData
          .where((brewery) =>
              brewery.name!.toLowerCase().contains(_searchString.toLowerCase()))
          .toList());

  set brewery(Brewery brew) {
    _brewery = brew;
    notifyListeners();
  }

  set breweryData(List<Brewery> value) {
    _breweryList = value;
    isLoading = false;
    notifyListeners();
  }

  BreweryProvider() {
    _breweryList = <Brewery>[];
  }

  Future<List<Brewery>> apiCall(http.Client client) async {
    String url = 'https://api.openbrewerydb.org/breweries';
    try {
      final response = await client.get(Uri.parse(url), headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      });
      if (200 == response.statusCode) {
        final parsed = jsonDecode(response.body).cast<Map<String, dynamic>>();
        final List<Brewery> finalList =
            parsed.map<Brewery>((json) => Brewery.fromJson(json)).toList();
        breweryData = finalList;
        return finalList;
      } else {
        return <Brewery>[];
      }
    } catch (e) {
      print(e);
      return <Brewery>[];
    }
  }

  void changeSearchString(String searchString) {
    _searchString = searchString;
    print(_searchString);
    notifyListeners();
  }
}
