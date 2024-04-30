import 'package:flutter/material.dart';

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
  final int id; // needed to then navigate to the bin in the map
  final BinType bintype;
  final int distance;
  final int likes;
  final int dislikes;

  StructSearchItem(this.id, this.bintype, this.distance, this.likes, this.dislikes);
}

class _SearchState extends State<Search> {
  // Variables to store the toggle state of each type of bin
  bool displayBlackBins = true;
  bool displayGreenBins = true;
  bool displayYellowBins = true;
  bool displayBlueBins = true;

  bool activated_display_black_bins_button = false;
  bool activated_display_green_bins_button = false;
  bool activated_display_yellow_bins_button = false;
  bool activated_display_blue_bins_button = false;

  List<StructSearchItem> searchResults = [
    new StructSearchItem(1, BinType.Black, 20, 10, 2),
    new StructSearchItem(2, BinType.Green, 30, 5, 1),
    new StructSearchItem(3, BinType.Yellow, 40, 3, 0),
    new StructSearchItem(4, BinType.Blue, 50, 1, 0),
    new StructSearchItem(5, BinType.Black, 70, 15, 7),
    new StructSearchItem(6, BinType.Green, 80, 20, 5),
    new StructSearchItem(7, BinType.Yellow, 90, 25, 3),
    new StructSearchItem(8, BinType.Blue, 100, 30, 2),
    new StructSearchItem(9, BinType.Black, 120, 35, 10),
    new StructSearchItem(10, BinType.Green, 130, 40, 8),
    new StructSearchItem(11, BinType.Yellow, 140, 45, 5),
    new StructSearchItem(12, BinType.Black, 150, 50, 3),
    new StructSearchItem(13, BinType.Black, 170, 55, 15),
    new StructSearchItem(14, BinType.Blue, 180, 60, 12),
    new StructSearchItem(15, BinType.Green, 190, 65, 10),
    // Add search results here
  ];

  bool skip_next_divider = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      ////////
      // BODY
      ////////
      body: ListView.builder(
        itemCount: searchResults.length * 2 - 1, // Double the itemCount to add dividers
        itemBuilder: (BuildContext context, int index) {
          // Check if it's an odd or even index
          if (index.isOdd) {
            if (skip_next_divider) {
              skip_next_divider = false;
              return Container();
            }
            return Divider(
              color: Colors.black,
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
            return Padding(
              padding: EdgeInsets.symmetric(vertical: 0, horizontal: 0),
              child: Container(
                width: MediaQuery.of(context).size.width, // Span across the screen width
                child: Material(
                  color: Colors.grey, // Background color of the button
                  child: InkWell(
                    onTap: () {
                      // Handle button tap here
                      // [TODO] Navigate to map screen and show the selected bin
                      print("Button ${searchResults[resultIndex]} tapped");
                    },
                    child: Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Row(
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
                            "${searchResults[resultIndex].likes}",
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
                            "${searchResults[resultIndex].dislikes}",
                            style: TextStyle(
                              fontSize: 20.0,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      )
                    ),
                  ),
                ),
              ),
            );
          }
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
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.map),
            label: 'Map',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
        ],
        currentIndex: 2,
        selectedItemColor: Colors.blue,
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