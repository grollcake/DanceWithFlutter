import 'package:country_selectable/services/fetch_country_list.dart';
import 'package:flutter/material.dart';
import 'package:searchfield/searchfield.dart';

void main() => runApp(SearchFieldApp());

class SearchFieldApp extends StatelessWidget {
  const SearchFieldApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CountrySearch',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: CountrySearchScreen(),
    );
  }
}

class CountrySearchScreen extends StatefulWidget {
  const CountrySearchScreen({Key? key}) : super(key: key);

  @override
  _CountrySearchScreenState createState() => _CountrySearchScreenState();
}

class _CountrySearchScreenState extends State<CountrySearchScreen> {
  List<String> _countryList = ['Fetching country list..'];

  late TextEditingController _controller;
  String? _selectedCountry;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();

    _controller.addListener(() {
      String? newSelectedCountry;

      print('current value is ${_controller.text}');
      if (_controller.text.isNotEmpty) {
        for (var country in _countryList) {
          if (country.toLowerCase() == _controller.text.toLowerCase()) {
            newSelectedCountry = country;
            break;
          }
        }
      }
      if (_selectedCountry != newSelectedCountry) {
        _selectedCountry = newSelectedCountry;
        setState(() {});
      }
    });

    FetchCountryList().getCountryList().then((result) {
      setState(() {
        _countryList = result;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Country search', style: TextStyle(color: Colors.deepPurple)),
        centerTitle: true,
        elevation: 0.0,
        backgroundColor: Colors.transparent,
      ),
      body: Center(
        child: Column(
          children: [
            Expanded(
              flex: 8,
              child: Container(
                padding: EdgeInsets.all(20),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.transparent,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Select a country', style: TextStyle(fontSize: 18, color: Colors.blueGrey)),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.shade200,
                            blurRadius: 10,
                            offset: Offset(0, 10),
                          ),
                        ],
                      ),
                      child: SearchField(
                        controller: _controller,
                        onTap: (value) {
                          setState(() {
                            _selectedCountry = value;
                          });
                        },
                        suggestions: _countryList,
                        searchInputDecoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(horizontal: 8),
                          hintText: 'Where do you want to go?',
                          hintStyle: TextStyle(color: Colors.blueGrey.shade200),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              color: Colors.blueGrey,
                              width: 1.5,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              color: Colors.blue,
                              width: 2,
                            ),
                          ),
                        ),
                        itemHeight: 40,
                        maxSuggestionsInViewPort: 6,
                        suggestionsDecoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.2),
                              blurRadius: 10,
                              offset: Offset(5, 5),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.transparent,
                ),
                child: AnimatedSwitcher(
                  duration: Duration(milliseconds: 300),
                  child: _selectedCountry == null
                      ? Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Please select a country',
                            style: TextStyle(fontSize: 16, color: Colors.blueGrey.shade200),
                          ),
                        )
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              _selectedCountry ?? 'Please select a country',
                              style: TextStyle(fontSize: 18, color: Colors.blueGrey, fontWeight: FontWeight.w600),
                            ),
                            SizedBox(
                              width: 48,
                              child: MaterialButton(
                                onPressed: () {},
                                shape: CircleBorder(),
                                padding: EdgeInsets.all(8),
                                color: Colors.blueGrey,
                                child: Icon(
                                  Icons.arrow_forward_ios,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
