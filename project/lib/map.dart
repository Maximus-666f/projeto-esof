import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:flutter_map_location_marker/flutter_map_location_marker.dart';
import 'package:flutter_compass/flutter_compass.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter_map_marker_popup/flutter_map_marker_popup.dart';

class Map extends StatefulWidget {
  @override
  _MapState createState() => _MapState();
}

enum BinType {
  Black,
  Green,
  Yellow,
  Blue,
}

class StructMarkerItem {
  final int id; // needed to keep track of the bin that was selected in the search page
  final BinType bintype;
  final double latitude;
  final double longitude;
  final int distance;
  final int likes;
  final int dislikes;

  StructMarkerItem(this.id, this.bintype, this.latitude, this.longitude, this.distance, this.likes, this.dislikes);
}


class _MapState extends State<Map> {
  // Variables to store the toggle state of each type of bin
  bool displayBlackBins = true;
  bool displayGreenBins = true;
  bool displayYellowBins = true;
  bool displayBlueBins = true;

  bool activated_display_black_bins_button = false;
  bool activated_display_green_bins_button = false;
  bool activated_display_yellow_bins_button = false;
  bool activated_display_blue_bins_button = false;

  List<StructMarkerItem> searchResults = [
    new StructMarkerItem(1, BinType.Black, 41.173000, -8.599700, 20, 10, 2),
    new StructMarkerItem(2, BinType.Green, 41.165000, -8.599700, 30, 5, 1),
    new StructMarkerItem(3, BinType.Yellow, 41.178000, -8.586700, 40, 3, 0),
    new StructMarkerItem(4, BinType.Blue, 41.172000, -8.594700, 50, 1, 0),
    new StructMarkerItem(5, BinType.Black, 41.177000, -8.569700, 70, 15, 7),
    new StructMarkerItem(6, BinType.Green, 41.171000, -8.596700, 80, 20, 5),
    new StructMarkerItem(7, BinType.Yellow, 41.172000, -8.597700, 90, 25, 3),
    new StructMarkerItem(8, BinType.Blue, 41.173000, -8.599200, 100, 30, 2),
    new StructMarkerItem(9, BinType.Black, 41.174000, -8.593700, 120, 35, 10),
    new StructMarkerItem(10, BinType.Green, 41.175000, -8.594700, 130, 40, 8),
    new StructMarkerItem(11, BinType.Yellow, 41.176000, -8.598700, 140, 45, 5),
    new StructMarkerItem(12, BinType.Black, 41.177000, -8.591700, 150, 50, 3),
    new StructMarkerItem(13, BinType.Black, 41.178000, -8.559700, 170, 55, 15),
    new StructMarkerItem(14, BinType.Blue, 41.179000, -8.569700, 180, 60, 12),
    new StructMarkerItem(15, BinType.Green, 41.174000, -8.579700, 190, 65, 10),
    // Add search results here
  ];


  // LocationPermission permission = await Geolocator.checkPermission();
  // if (permission == LocationPermission.denied) {
  //   permission = await Geolocator.requestPermission();
  // }

  MapController mapController = MapController();
  LatLng currentCenter = LatLng(41.178000, -8.595700);

  // desnecessario pq o package dos pop-ups ja tem para focar
  // void _focusOnCoordinate(LatLng coordinate) {
  //   mapController.move(coordinate, 13.0);
  //   setState(() {
  //     currentCenter = coordinate;
  //   });
  // }

  Stream<LocationMarkerPosition> _positionStream = const Stream.empty();

  Future<void> _initPositionStream() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    while (!serviceEnabled) {
      // Force them to enable location services
      serviceEnabled = await Geolocator.openLocationSettings();
      serviceEnabled = await Geolocator.isLocationServiceEnabled();
    }

    LocationPermission permission = await Geolocator.checkPermission();
    while(permission != LocationPermission.always &&
          permission != LocationPermission.whileInUse) {
      // Request permission to access the device's location
      permission = await Geolocator.requestPermission();
    }
    // Get a stream of the device's location
    Stream<LocationMarkerPosition?> aux = const LocationMarkerDataStreamFactory()
        .fromGeolocatorPositionStream(
      stream: Geolocator.getPositionStream(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.best,
          distanceFilter: 5,
        ),
      ),
    );
    _positionStream = await aux.map((e) => e!); // _positionStream = await aux.where((element) => element != null).map((e) => e!);
  }

  final PopupController _popupLayerController = PopupController();

  @override
  Widget build(BuildContext context) {
    _initPositionStream();

    // for debug check if its empty stream [TODO] remove this
    if (_positionStream == null) {
      return Scaffold(
        body: Text('_positionStream is null'),
      );
    }
    //

    return Scaffold(
      /////////
      // BODY
      /////////
      body: FlutterMap(
        mapController: mapController,
        options: MapOptions(
          initialCenter: currentCenter,
          initialZoom: 13.0,
        ),
        children: [
          TileLayer(
            urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
            userAgentPackageName: 'BinFinder',
          ),
          PopupMarkerLayer(
            options: PopupMarkerLayerOptions(
              markers: <Marker>[
                for (var item in searchResults)
                  if ((item.bintype == BinType.Black && displayBlackBins) ||
                      (item.bintype == BinType.Green && displayGreenBins) ||
                      (item.bintype == BinType.Yellow && displayYellowBins) ||
                      (item.bintype == BinType.Blue && displayBlueBins))
                    Marker(
                      point: LatLng(item.latitude, item.longitude),
                      width: 80.0,
                      height: 80.0,
                      child: Icon(
                        Icons.delete,
                        color: item.bintype == BinType.Black
                            ? Colors.black
                            : item.bintype == BinType.Green
                            ? Colors.green
                            : item.bintype == BinType.Yellow
                            ? Colors.yellow
                            : Colors.blue,
                      ),
                    ),
              ],
              popupController: _popupLayerController,
              popupDisplayOptions: PopupDisplayOptions(
                builder: (_, Marker marker) {
                  final StructMarkerItem item = searchResults.firstWhere(
                    (element) =>
                        element.latitude == marker.point.latitude &&
                        element.longitude == marker.point.longitude,
                  );
                  return SizedBox(
                    width: 4/10 * MediaQuery.of(context).size.width,
                    height: 2/10 * MediaQuery.of(context).size.height,
                    child: Card(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.delete,
                            color: item.bintype == BinType.Black
                                ? Colors.black
                                : item.bintype == BinType.Green
                                ? Colors.green
                                : item.bintype == BinType.Yellow
                                ? Colors.yellow
                                : Colors.blue,
                          ),
                          Text('Distance: ${item.distance}m'),
                          ElevatedButton(
                            child: Row(
                                children: [
                                  Icon(Icons.directions),
                                  Text('Directions')
                                ]
                            ),
                            onPressed: () {
                              // [TODO] open google maps and show the directions to the bin
                            },
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Expanded(
                                child: MaterialButton(
                                  child: Row(
                                    children: [
                                      Icon(Icons.thumb_up),
                                      Text('${item.likes}'),
                                    ],
                                  ),
                                  onPressed: () {
                                    // [TODO] like the bin
                                  },
                                ),
                              ),
                              Expanded(
                                child: MaterialButton(
                                  child: Row(
                                    children: [
                                      Icon(Icons.thumb_down),
                                      Text('${item.dislikes}'),
                                    ],
                                  ),
                                  onPressed: () {
                                    // [TODO] dislike the bin
                                  },
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
              markerCenterAnimation: MarkerCenterAnimation(
                curve: Curves.ease,
                duration: const Duration(milliseconds: 500),
              ),
            ),
          ),
          CurrentLocationLayer(
            positionStream: _positionStream,
            alignPositionOnUpdate: AlignOnUpdate.never,
            alignDirectionOnUpdate: AlignOnUpdate.never,
            style: LocationMarkerStyle(
              marker: const DefaultLocationMarker(
                child: Icon(
                  Icons.navigation,
                  color: Colors.white,
                ),
              ),
              markerSize: const Size(40, 40),
              markerDirection: MarkerDirection.heading,
            ),
          ),
        ],
      ),

      ///////////
      // FLOATING ACTION BUTTON
      ///////////
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
              SizedBox(width: MediaQuery.of(context).size.width * 1 / 12),
            ],
          ),
          SizedBox(height: MediaQuery.of(context).size.width * 1 / 30),
          Row(
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
        currentIndex: 1,
        selectedItemColor: Colors.blue,
        onTap: (int index) {
          if (index == 0) {
            Navigator.pushReplacementNamed(context, '/profile');
          } else if (index == 1) {
            // do nothing, already on the map screen
          } else if (index == 2) {
            Navigator.pushReplacementNamed(context, '/search');
          }
        },
      ),
    );
  }
}
