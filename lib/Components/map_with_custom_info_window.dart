import 'package:another_carousel_pro/another_carousel_pro.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:custom_info_window/custom_info_window.dart';
import 'package:demo/Components/my_icon_button.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapWithCustomInfoWindows extends StatefulWidget {
  const MapWithCustomInfoWindows({super.key});

  @override
  State<MapWithCustomInfoWindows> createState() =>
      _MapWithCustomInfoWindowsState();
}

class _MapWithCustomInfoWindowsState extends State<MapWithCustomInfoWindows> {
  LatLng myCurrentLocation = const  LatLng(27.7172, 85.3240);
  //Creating a variable to hold a marker icon.
  BitmapDescriptor customIcon = BitmapDescriptor.defaultMarker;
  late GoogleMapController googleMapController;
  //add custom info window package in pubspec.yaml
  final CustomInfoWindowController _customInfoWindowController = CustomInfoWindowController();
  // firebase collection to load latlng of place
  final CollectionReference placeCollection = FirebaseFirestore.instance.collection("myAppCollection");

  List<Marker> markers = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadMarkers();
  }
  //for custom marker
  Future<void> _loadMarkers()async{
    customIcon = await BitmapDescriptor.asset(
      const ImageConfiguration(), "asset/images/marker.png",
      height: 40, width: 30
    );
    Size size = MediaQuery.of(context).size;

    placeCollection.snapshots().listen((QuerySnapshot streamSnapshot){
      if(streamSnapshot.docs.isNotEmpty){
        final List allMarkers = streamSnapshot.docs;
        List<Marker> myMarker = [];
        for(final marker in allMarkers){
          final dat = marker.data();
          final data = (dat) as Map;
          myMarker.add(
            Marker(
              markerId: MarkerId(
                data['address'],
              ),
              position: LatLng(data['latitude'], data['longitude']),
              onTap: (){
                _customInfoWindowController.addInfoWindow!(
                  Container(
                    height: size.height * 0.32,
                    width: size.width * 0.8,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: Column(
                      children: [
                        Stack(
                          children: [
                            SizedBox(
                              height: size.height*0.203,
                              child: ClipRRect(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(25),
                                  topRight: Radius.circular(25),
                                ),
                                child: AnotherCarousel(
                                  images: data['imageUrls']
                                      .map((url)=>NetworkImage(url))
                                      .toList(),
                                  dotSize: 5, indicatorBgPadding: 5, dotBgColor: Colors.transparent,
                                ),
                              ),
                            ),
                            Positioned(
                              top: 10,
                              left: 14,
                              right: 14,
                              child: Row(
                                children: [
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                      vertical: 5,
                                      horizontal: 12,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                    child: Text(
                                      "Guest Favourite",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  Spacer(),
                                  MyIconButton(
                                    icon: Icons.favorite_border,
                                    radius: 15,
                                  ),
                                  SizedBox(width: 13,),
                                  InkWell(
                                    onTap: (){
                                      _customInfoWindowController
                                          .hideInfoWindow!();
                                    },
                                    child: MyIconButton(
                                      icon: Icons.close,
                                      radius: 15,
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 8,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    data["address"],
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Spacer(),
                                  Icon(Icons.star),
                                  SizedBox(width: 5,),
                                  Text(data['rating'].toString(),)
                                ],
                              ),
                              Text(
                                "3066 m elevation",
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.black54,
                                ),
                              ),
                              Text(
                                data["date"],
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.black54,
                                ),
                              ),
                              Text.rich(
                                TextSpan(
                                  text: '\$${data['price']}',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  children: [
                                    TextSpan(
                                      text: "night",
                                      style: TextStyle(
                                        fontWeight: FontWeight.normal,
                                      )
                                    )
                                  ]
                                )
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  LatLng(data['latitude'], data['longitude']),
                );
              },
            ),
          );
        }
        setState(() {
          markers = myMarker;
        });
      }
    });

  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return FloatingActionButton.extended(
      backgroundColor: Colors.transparent,
      elevation: 0,
      onPressed: () {
        showModalBottomSheet(
          clipBehavior: Clip.none,
          isScrollControlled: true,
          backgroundColor: Colors.transparent,
          context: context,
          builder: (BuildContext context){
            return Container(
              color: Colors.white,
              height: size.height * 0.77,
              width: size.width,
              child: Stack(
                children: [
                  SizedBox(
                    height: size.height * 0.77,
                    child: GoogleMap(
                      initialCameraPosition: CameraPosition(target: myCurrentLocation),
                      onMapCreated: (GoogleMapController controller){
                        googleMapController = controller;
                        _customInfoWindowController.googleMapController = controller;
                      },
                      onTap: (argument){
                        _customInfoWindowController.hideInfoWindow!();
                      },
                      onCameraMove: (position){
                        _customInfoWindowController.onCameraMove!();
                      },
                      markers: markers.toSet(),
                    ),
                  ),
                  CustomInfoWindow(
                    controller: _customInfoWindowController,
                    height: size.height * 0.34,
                    width: size.width * 0.85,
                    offset: 50,
                  ),
                  GestureDetector(
                    onTap: (){
                      Navigator.pop(context);
                    },
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 170,
                        vertical: 5,
                      ),
                      child: Container(
                        height: 5,
                        width: 50,
                        decoration: BoxDecoration(
                          color: Colors.black54,
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            );
          }
        );
      },



      label: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Row(
          children: [
            SizedBox(width: 5),
            Text(
              "Map",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            SizedBox(width: 5),
            Icon(Icons.map_outlined, color: Colors.white),
          ],
        ),
      ),
    );
  }
}


