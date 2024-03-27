import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_maps/maps.dart';

class Map extends StatefulWidget {
  @override
  _MapState createState() => _MapState();
}

class _MapState extends State<Map> {
  // Variables to store the toggle state of each type of bin
  bool displayBlackBins = true;
  bool displayGreenBins = true;
  bool displayYellowBins = true;
  bool displayBlueBins = true;

  late MapZoomPanBehavior _zoomPanBehavior;

  @override
  void initState() {
    _zoomPanBehavior = MapZoomPanBehavior(
        minZoomLevel: 4.0,
        zoomLevel: 15.0,
        maxZoomLevel: 16.0,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SfMaps(
        layers: <MapTileLayer>[
          MapTileLayer(
            urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
            initialZoomLevel: 15, // não parece mudar nada
            initialFocalLatLng: const MapLatLng(41.1780, -8.5957), // Coordinates for FEUP, Porto, Portugal
            zoomPanBehavior: _zoomPanBehavior,
            initialMarkersCount: 1,
            markerBuilder: (BuildContext context, int index) {
              return const MapMarker(
                latitude: 41.1780,
                longitude: -8.5957,
                child: Icon(Icons.location_on, color: Colors.black),
              );
            },
            markerTooltipBuilder: (BuildContext context, int index) {
              return Container(
                width: 250,
                padding: EdgeInsets.all(16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.delete, color: Colors.black),
                        SizedBox(width: 8.0),
                        Text('Black bin'),
                      ],
                    ),
                    SizedBox(height: 8.0),
                    Row(
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            // Add your onPressed logic here
                          },
                          child: Text('Directions'),
                        ),
                      ],
                    ),
                    SizedBox(height: 8.0),
                    Row(
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            // Add your onPressed logic here
                          },
                          child: Row(
                            children: [
                              Icon(Icons.thumb_up, color: Colors.green),
                              SizedBox(width: 8.0),
                              Text('15'),
                            ],
                          ),
                        ),
                        SizedBox(width: 16.0),
                        ElevatedButton(
                          onPressed: () {
                            // Add your onPressed logic here
                          },
                          child: Row(
                            children: [
                              Icon(Icons.thumb_down, color: Colors.red),
                              SizedBox(width: 8.0),
                              Text('5'),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
            tooltipSettings: MapTooltipSettings(
              color: Colors.white,
              strokeColor: Colors.black,
              strokeWidth: 1.0,
            ),
          ),
        ],
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
        currentIndex: 1,
        selectedItemColor: Colors.blue,
        onTap: (int index) {
          if (index == 0) {
            Navigator.pushNamed(context, '/profile');
          } else if (index == 1) {
            // do nothing, already on the map screen
          } else if (index == 2) {
            Navigator.pushNamed(context, '/search');
          }
        },
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              FloatingActionButton(
                onPressed: () {
                  // [TODO] Add a new bin
                },
                child: Icon(Icons.add),
                backgroundColor: Colors.white,
              ),
            ],
          ),
          SizedBox(height: 16.0),
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
