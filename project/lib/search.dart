import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:geolocator/geolocator.dart';

class Search extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}

enum BinType {
  Black,
  Green,
  Yellow,
  Blue,
}

class StructSearchItem {
  final String id; // needed to then navigate to the bin in the map
  final BinType bintype;
  final int distance;
  final bool is_favorite;

  StructSearchItem(this.id, this.bintype, this.distance, this.is_favorite);
}

class _SearchState extends State<Search> {
  final database = FirebaseDatabase.instance.ref();
  String user_id = FirebaseAuth.instance.currentUser!.uid!;

  // Variables to store the toggle state of each type of bin
  bool displayBlackBins = true;
  bool displayGreenBins = true;
  bool displayYellowBins = true;
  bool displayBlueBins = true;

  bool activated_display_black_bins_button = false;
  bool activated_display_green_bins_button = false;
  bool activated_display_yellow_bins_button = false;
  bool activated_display_blue_bins_button = false;

  List<StructSearchItem> searchResults = [];
  // List<StructSearchItem> searchResults = [
  //   new StructSearchItem(1, BinType.Black, 20, 10, 2, true),
  //   new StructSearchItem(2, BinType.Green, 30, 5, 1, false),
  //   new StructSearchItem(3, BinType.Yellow, 40, 3, 0, false),
  //   new StructSearchItem(4, BinType.Blue, 50, 1, 0, false),
  //   new StructSearchItem(5, BinType.Black, 70, 15, 7, true),
  //   new StructSearchItem(6, BinType.Green, 80, 20, 5, false),
  //   new StructSearchItem(7, BinType.Yellow, 90, 25, 3, true),
  //   new StructSearchItem(8, BinType.Blue, 100, 30, 2, false),
  //   new StructSearchItem(9, BinType.Black, 120, 35, 10, true),
  //   new StructSearchItem(10, BinType.Green, 130, 40, 8, false),
  //   new StructSearchItem(11, BinType.Yellow, 140, 45, 5, true),
  //   new StructSearchItem(12, BinType.Black, 150, 50, 3, false),
  //   new StructSearchItem(13, BinType.Black, 170, 55, 15, false),
  //   new StructSearchItem(14, BinType.Blue, 180, 60, 12, true),
  //   new StructSearchItem(15, BinType.Green, 190, 65, 10, false),
  //   new StructSearchItem(0, BinType.Yellow, 200, 70, 7, true),
  //   // Add search results here
  // ];

  bool skip_next_divider = false;

  Future<List<StructSearchItem>> _initializeSearchResults() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    while (!serviceEnabled) {
      // Force them to enable location services
      serviceEnabled = await Geolocator.openLocationSettings();
      serviceEnabled = await Geolocator.isLocationServiceEnabled();
    }

    LocationPermission permission = await Geolocator.checkPermission();
    while (permission != LocationPermission.always &&
        permission != LocationPermission.whileInUse) {
      // Request permission to access the device's location
      permission = await Geolocator.requestPermission();
    }
    // Get a stream of the device's location
    Stream<Position?> aux = Geolocator.getPositionStream(
      locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.best,
        distanceFilter: 5,
      ),
    );
    Position aux_position = await Geolocator.getCurrentPosition();
    searchResults = [];
    final snapshot = await database.child('/bins_coordinates/').get();
    final data = snapshot.value as Map<dynamic, dynamic>;
    data.forEach((key, value) {
      int distance = Geolocator.distanceBetween(aux_position.latitude, aux_position.longitude, value['latitude'], value['longitude']).toInt();
      searchResults.add(StructSearchItem(key, value['type'] == 'black' ? BinType.Black : value['type'] == 'green' ? BinType.Green : value['type'] == 'yellow' ? BinType.Yellow : BinType.Blue, distance, false));
    });
    // order the searchResults by distance
    searchResults.sort((a, b) => a.distance.compareTo(b.distance));
    searchResults.add(StructSearchItem("0", BinType.Yellow, 200, false));
    return searchResults;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      ////////
      // BODY
      ////////
      body: FutureBuilder(
        future: _initializeSearchResults(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (!snapshot.hasData) {
              return Center(
                child: Text(
                  "No bins found",
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.black,
                  ),
                ),
              );
            }
            if (snapshot.hasError) {
              return Center(
                child: Text(
                  "Error: ${snapshot.error}",
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.black,
                  ),
                ),
              );
            }

            return ListView.builder(
              itemCount: searchResults.length * 2 - 1, // Double the itemCount to add dividers
              itemBuilder: (BuildContext context, int index) {
                // Check if it's an odd or even index
                if (index.isOdd) {
                  if (skip_next_divider) {
                    skip_next_divider = false;
                    return Container();
                  }
                  return Divider(
                    color: Colors.white,
                    thickness: 1.0,
                    height: 1.0,
                  );
                } else {
                  // Calculate the actual index in the searchResults list
                  final int resultIndex = index ~/ 2;
                  // Check if the bin type should be displayed
                  if ((searchResults[resultIndex].bintype == BinType.Black && !displayBlackBins) ||
                      (searchResults[resultIndex].bintype == BinType.Green && !displayGreenBins) ||
                      (searchResults[resultIndex].bintype == BinType.Yellow && !displayYellowBins) ||
                      (searchResults[resultIndex].bintype == BinType.Blue && !displayBlueBins)) {
                    skip_next_divider = true;
                    return Container();
                  }
                  if (searchResults[resultIndex].id == "0") {
                    return Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height / 6,
                      color: Colors.white,
                    );
                  }
                  return Padding(
                    padding: EdgeInsets.symmetric(vertical: 0, horizontal: 0),
                    child: Container(
                      width: MediaQuery.of(context).size.width, // Span across the screen width
                      child: Material(
                        color: searchResults[resultIndex].is_favorite? Colors.amber[700] : Colors.green[300], // Background color of the button
                        child: InkWell(
                          onTap: () {
                            Navigator.pushReplacementNamed(context, '/map', arguments: {                      // ){
                              'bin_id': searchResults[resultIndex].id,
                            });
                          },
                          child: Padding(
                            padding: EdgeInsets.all(16.0),
                            child: StreamBuilder(
                              stream: database.child('bins_votes').child(searchResults[resultIndex].id).onValue,
                              builder: (BuildContext context, AsyncSnapshot snapshot) {
                              if (snapshot.connectionState == ConnectionState.active) {
                                final data = Map<String, dynamic>.from(snapshot.data!.snapshot.value);
                                return Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Icon(
                                      Icons.delete,
                                      color: searchResults[resultIndex].bintype == BinType.Black ? Colors.black : searchResults[resultIndex].bintype == BinType.Green ? Colors.green : searchResults[resultIndex].bintype == BinType.Yellow ? Colors.yellow : Colors.blue,
                                    ),
                                    Text(
                                      "Distance: ${searchResults[resultIndex].distance}m",
                                      style: TextStyle(
                                        fontSize: 20.0,
                                        color: Colors.black,
                                      ),
                                    ),
                                    Icon(
                                      Icons.thumb_up,
                                      color: Colors.green,
                                    ),
                                    Text(
                                      "${data['likes']}",
                                      style: TextStyle(
                                        fontSize: 20.0,
                                        color: Colors.black,
                                      ),
                                    ),
                                    Icon(
                                      Icons.thumb_down,
                                      color: Colors.red,
                                    ),
                                    Text(
                                      "${data['dislikes']}",
                                      style: TextStyle(
                                        fontSize: 20.0,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ],
                                );
                              }
                              else {
                                return Center(
                                  child: CircularProgressIndicator(
                                    valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
                                  ),
                                );
                              }
                            },
                          ),
                        ),
                      ),
                    ),
                    ),
                  );
                }
              },
            );
          }
          else {
            return Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
              ),
            );
          };
        },
      ),

      ////////
      // FLOATING ACTION BUTTON
      ////////
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          FloatingActionButton(
            onPressed: () {
              setState(() {
                activated_display_black_bins_button = !activated_display_black_bins_button;
                // case where this is the only one that is activated
                if (activated_display_black_bins_button && !activated_display_green_bins_button && !activated_display_yellow_bins_button && !activated_display_blue_bins_button) {
                  displayBlackBins = true;
                  displayGreenBins = false;
                  displayYellowBins = false;
                  displayBlueBins = false;
                }
                else if (activated_display_black_bins_button) {
                  displayBlackBins = true;
                }
                else { // case where activated_display_black_bins_button is false
                  displayBlackBins = false;
                }
                // case where all the buttons are deactivated
                if (!activated_display_black_bins_button && !activated_display_green_bins_button && !activated_display_yellow_bins_button && !activated_display_blue_bins_button) {
                  displayBlackBins = true;
                  displayGreenBins = true;
                  displayYellowBins = true;
                  displayBlueBins = true;
                }
              });
            },
            child: Icon(Icons.delete, color: !activated_display_black_bins_button ? Colors.black : Colors.white),
            backgroundColor: !activated_display_black_bins_button ? Colors.white : Colors.black,
          ),
          FloatingActionButton(
            onPressed: () {
              setState(() {
                activated_display_green_bins_button = !activated_display_green_bins_button;
                // case where this is the only one that is activated
                if (!activated_display_black_bins_button && activated_display_green_bins_button && !activated_display_yellow_bins_button && !activated_display_blue_bins_button) {
                  displayBlackBins = false;
                  displayGreenBins = true;
                  displayYellowBins = false;
                  displayBlueBins = false;
                }
                else if (activated_display_green_bins_button) {
                  displayGreenBins = true;
                }
                else { // case where activated_display_green_bins_button is false
                  displayGreenBins = false;
                }
                // case where all the buttons are deactivated
                if (!activated_display_black_bins_button && !activated_display_green_bins_button && !activated_display_yellow_bins_button && !activated_display_blue_bins_button) {
                  displayBlackBins = true;
                  displayGreenBins = true;
                  displayYellowBins = true;
                  displayBlueBins = true;
                }
              });
            },
            child: Icon(Icons.delete, color: !activated_display_green_bins_button ? Colors.green : Colors.white),
            backgroundColor: !activated_display_green_bins_button ? Colors.white : Colors.green,
          ),
          FloatingActionButton(
            onPressed: () {
              setState(() {
                activated_display_yellow_bins_button = !activated_display_yellow_bins_button;
                // case where this is the only one that is activated
                if (!activated_display_black_bins_button && !activated_display_green_bins_button && activated_display_yellow_bins_button && !activated_display_blue_bins_button) {
                  displayBlackBins = false;
                  displayGreenBins = false;
                  displayYellowBins = true;
                  displayBlueBins = false;
                }
                else if (activated_display_yellow_bins_button) {
                  displayYellowBins = true;
                }
                else { // case where activated_display_yellow_bins_button is false
                  displayYellowBins = false;
                }
                // case where all the buttons are deactivated
                if (!activated_display_black_bins_button && !activated_display_green_bins_button && !activated_display_yellow_bins_button && !activated_display_blue_bins_button) {
                  displayBlackBins = true;
                  displayGreenBins = true;
                  displayYellowBins = true;
                  displayBlueBins = true;
                }
              });
            },
            child: Icon(Icons.delete, color: !activated_display_yellow_bins_button ? Colors.yellow : Colors.white),
            backgroundColor: !activated_display_yellow_bins_button ? Colors.white : Colors.yellow,
          ),
          FloatingActionButton(
            onPressed: () {
              setState(() {
                activated_display_blue_bins_button = !activated_display_blue_bins_button;
                // case where this is the only one that is activated
                if (!activated_display_black_bins_button && !activated_display_green_bins_button && !activated_display_yellow_bins_button && activated_display_blue_bins_button) {
                  displayBlackBins = false;
                  displayGreenBins = false;
                  displayYellowBins = false;
                  displayBlueBins = true;
                }
                else if (activated_display_blue_bins_button) {
                  displayBlueBins = true;
                }
                else { // case where activated_display_blue_bins_button is false
                  displayBlueBins = false;
                }
                // case where all the buttons are deactivated
                if (!activated_display_black_bins_button && !activated_display_green_bins_button && !activated_display_yellow_bins_button && !activated_display_blue_bins_button) {
                  displayBlackBins = true;
                  displayGreenBins = true;
                  displayYellowBins = true;
                  displayBlueBins = true;
                }
              });
            },
            child: Icon(Icons.delete, color: !activated_display_blue_bins_button ? Colors.blue : Colors.white),
            backgroundColor: !activated_display_blue_bins_button ? Colors.white : Colors.blue,
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,

      ////////
      // BOTTOM NAVIGATION BAR
      ////////
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.green,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
            backgroundColor: Color(0xFF81C784),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.map),
            label: 'Map',
            backgroundColor: Color(0xFF81C784),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'List',
            backgroundColor: Color(0xFF81C784),
          ),
        ],
        currentIndex: 2,
        selectedItemColor: Colors.white,
        onTap: (int index) {
          if (index == 0) {
            Navigator.pushReplacementNamed(context, '/profile');
          } else if (index == 1) {
            Navigator.pushReplacementNamed(context, '/map');
          } else if (index == 2) {
            // do nothing, already in search screen
          }
        },
      ),
    );
  }
}
