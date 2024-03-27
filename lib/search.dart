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
  final BinType bintype;
  final int distance;
  final int likes;
  final int dislikes;

  StructSearchItem(this.bintype, this.distance, this.likes, this.dislikes);
}

class _SearchState extends State<Search> {
  // Variables to store the toggle state of each type of bin
  bool displayBlackBins = true;
  bool displayGreenBins = true;
  bool displayYellowBins = true;
  bool displayBlueBins = true;

  List<StructSearchItem> searchResults = [
    new StructSearchItem(BinType.Black, 20, 10, 2),
    new StructSearchItem(BinType.Green, 30, 5, 1),
    new StructSearchItem(BinType.Yellow, 40, 3, 0),
    new StructSearchItem(BinType.Blue, 50, 1, 0),
    new StructSearchItem(BinType.Black, 70, 15, 7),
    new StructSearchItem(BinType.Green, 80, 20, 5),
    new StructSearchItem(BinType.Yellow, 90, 25, 3),
    new StructSearchItem(BinType.Blue, 100, 30, 2),
    new StructSearchItem(BinType.Black, 120, 35, 10),
    new StructSearchItem(BinType.Green, 130, 40, 8),
    new StructSearchItem(BinType.Yellow, 140, 45, 5),
    new StructSearchItem(BinType.Black, 150, 50, 3),
    new StructSearchItem(BinType.Black, 170, 55, 15),
    new StructSearchItem(BinType.Blue, 180, 60, 12),
    new StructSearchItem(BinType.Green, 190, 65, 10),
    // Add search results here
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView.builder(
          itemCount: searchResults.length * 2 - 1, // Double the itemCount to add dividers
          itemBuilder: (BuildContext context, int index) {
            // Check if it's an odd or even index
            if (index.isOdd) {
              return Divider(
                color: Colors.black,
                thickness: 1.0,
                height: 1.0,
              );
            } else {
              // Calculate the actual index in the searchResults list
              final int resultIndex = index ~/ 2;
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
            Navigator.pushNamed(context, '/profile');
          } else if (index == 1) {
            Navigator.pushNamed(context, '/map');
          } else if (index == 2) {
            // do nothing, already in search screen
          }
        },
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            // mainAxisSize: MainAxisSize.max,
            children: [
              FloatingActionButton(
                onPressed: () {
                  setState(() {
                    displayBlackBins = !displayBlackBins;
                  });
                },
                child: Icon(Icons.delete, color: displayBlackBins ? Colors.black : Colors.white),
                backgroundColor: displayBlackBins ? Colors.white : Colors.black,
              ),
              FloatingActionButton(
                onPressed: () {
                  setState(() {
                    displayGreenBins = !displayGreenBins;
                  });
                },
                child: Icon(Icons.delete, color: displayGreenBins ? Colors.green : Colors.white),
                backgroundColor: displayGreenBins ? Colors.white : Colors.green,
              ),
              FloatingActionButton(
                onPressed: () {
                  setState(() {
                    displayYellowBins = !displayYellowBins;
                  });
                },
                child: Icon(Icons.delete, color: displayYellowBins ? Colors.yellow : Colors.white),
                backgroundColor: displayYellowBins ? Colors.white : Colors.yellow,
              ),
              FloatingActionButton(
                onPressed: () {
                  setState(() {
                    displayBlueBins = !displayBlueBins;
                  });
                },
                child: Icon(Icons.delete, color: displayBlueBins ? Colors.blue : Colors.white),
                backgroundColor: displayBlueBins ? Colors.white : Colors.blue,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
