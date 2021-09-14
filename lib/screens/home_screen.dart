// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:async';
import 'dart:convert';

import 'package:brewery/provider/brewery_provider.dart';
import 'package:brewery/screens/brewery_detail_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

import 'package:brewery/model/brewery_list.dart';

class MyHomeScreen extends StatefulWidget {
  const MyHomeScreen({Key? key}) : super(key: key);

  @override
  _MyHomeScreenState createState() => _MyHomeScreenState();
}

class _MyHomeScreenState extends State<MyHomeScreen> {
  TextEditingController _controller = TextEditingController();
  late String _searchText;
  static const Color _whiteColor = Colors.white;

  @override
  void initState() {
    //initState to perform all task before page loads...
    Future.microtask(() async => {
          Provider.of<BreweryProvider>(context, listen: false)
              .apiCall(http.Client()), //provider to call API and update data....
        });
    _controller.addListener(
      () {
        setState(() {
          _searchText = _controller.text;
        });
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: 'Main',
      child: Scaffold(
        backgroundColor: Colors.blue,
        appBar: AppBar(
          title: Center(child: Text('Brewery')),
          elevation: 0.0,
        ),
        body: Column(
          children: <Widget>[
            Container(
              color: Theme.of(context).primaryColor,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: ListTile(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    leading: Icon(Icons.search),
                    title: TextField(
                      controller: _controller,
                      decoration: InputDecoration(
                        hintText: 'search brewery...',
                        border: InputBorder.none,
                      ),
                      onChanged: (value) => {
                        Provider.of<BreweryProvider>(context, listen: false)
                            .changeSearchString(value)
                      },
                    ),
                    trailing: _controller.text.isNotEmpty
                        ? IconButton(
                            icon: Icon(Icons.cancel),
                            onPressed: () {
                              _controller.clear();
                              Provider.of<BreweryProvider>(context,
                                      listen: false)
                                  .changeSearchString('');
                              FocusScope.of(context).unfocus();
                            },
                          )
                        : SizedBox.shrink(),
                  ),
                ),
              ),
            ),
            Expanded(
              child: RefreshIndicator(
                onRefresh: () async {
                  await Future.microtask(() async => {
                        Provider.of<BreweryProvider>(context, listen: false)
                            .apiCall(http.Client()), //provider to call API and update data....
                      });
                },
                child: Consumer<BreweryProvider>(
                    builder: (context, myModel, child) {
                  return ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: myModel.brew == null ? 0 : myModel.brew.length,
                    itemBuilder: (BuildContext context, int index) {
                      return context.watch<BreweryProvider>().isLoading
                          ? const Center(
                              child: CircularProgressIndicator(
                                color: Color(0xFF0862CD),
                              ),
                            )
                          : Card(
                              color: Color(0xFF0862CD),
                              elevation: 10,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: ListTile(
                                contentPadding: const EdgeInsets.all(15.0),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                leading: Icon(
                                  Icons.business_rounded,
                                  color: _whiteColor,
                                ),
                                title: Text(
                                  Provider.of<BreweryProvider>(context,
                                          listen: false)
                                      .brew[index]
                                      .name
                                      .toString(),
                                  style: const TextStyle(color: _whiteColor),
                                ),
                                trailing: Icon(
                                  Icons.arrow_right,
                                  color: _whiteColor,
                                ),
                                onTap: () {
                                  Provider.of<BreweryProvider>(context,
                                              listen: false)
                                          .brewery =
                                      context
                                          .read<BreweryProvider>()
                                          .brew[index];
                                  Navigator.of(context).push(
                                    PageRouteBuilder(
                                      transitionDuration:
                                          Duration(milliseconds: 500),
                                      pageBuilder: (BuildContext context,
                                          Animation<double> animation,
                                          Animation<double>
                                              secondaryAnimation) {
                                        return BreweryDetailsScreen();
                                      },
                                      transitionsBuilder: (BuildContext context,
                                          Animation<double> animation,
                                          Animation<double> secondaryAnimation,
                                          Widget child) {
                                        return Align(
                                          child: FadeTransition(
                                            opacity: animation,
                                            child: child,
                                          ),
                                        );
                                      },
                                    ),
                                  );
                                  /* Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        BreweryDetailsScreen()));*/
                                },
                              ),
                              margin: const EdgeInsets.all(10.0),
                            );
                    },
                  );
                }),
              ),
            ),
          ],
        ),
      ),
    );

    /*floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            key: Key('decrement_floating_buton'),
            onPressed: () => context.read<Counter>().decrement(),
            tooltip: 'Decrement',
            child: Icon(Icons.remove),
          ),
          SizedBox(
            width: 10.0,
          ),
          FloatingActionButton(
            key: Key('reset_floating_buton'),
            onPressed: () => context.read<Counter>().reset(),
            tooltip: 'Reset',
            child: Icon(Icons.exposure_zero),
          ),

          SizedBox(
            width: 10.0,
          ),
          FloatingActionButton(
            key: Key('increment_floatng_buton'),
            onPressed: () => context.read<Counter>().increment(),
            tooltip: 'Increment',
            child: Icon(Icons.add),
          ),
        ],
      ),*/
  }

/*  onSearchTextChanged(String text) async {
    _searchResult.clear();
    if (text.isEmpty) {
      setState(() {});
      return;
    }

    for (var brewery in _brewery) {
      if (brewery.name.toString().toLowerCase().contains(text.toLowerCase())) {
        _searchResult.add(brewery);
      }
    }

    setState(() {});
  }

  Future<List<Brewery>> fetchBreweryList() async {
    final response =
        await http.get(Uri.parse('https://api.openbrewerydb.org/breweries'));
    final parsed = jsonDecode(response.body).cast<Map<String, dynamic>>();
    return parsed.map<Brewery>((json) => Brewery.fromJson(json)).toList();
  }*/
}
