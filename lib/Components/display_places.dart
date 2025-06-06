import 'package:another_carousel_pro/another_carousel_pro.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo/provider/favourite_provider.dart';
import 'package:demo/ui/place_detail_screen.dart';
import 'package:flutter/material.dart';

class DisplayPlaces extends StatefulWidget {
  const DisplayPlaces({super.key});

  @override
  State<DisplayPlaces> createState() => _DisplayPlacesState();
}

class _DisplayPlacesState extends State<DisplayPlaces> {
  // collection for place items
  final CollectionReference placeCollection = FirebaseFirestore.instance
      .collection("myAppCollection");

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final provider = FavoriteProvider.of(context);
    return StreamBuilder(
      stream: placeCollection.snapshots(),
      builder: (context, streamSnapshot) {
        if (streamSnapshot.hasData) {
          return ListView.builder(
            shrinkWrap: true,
            padding: EdgeInsets.zero,
            physics: NeverScrollableScrollPhysics(),
            itemCount: streamSnapshot.data!.docs.length,
            itemBuilder: (context, index) {
              final place = streamSnapshot.data!.docs[index];
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_)=>PlaceDetailScreen(place: place) ),
                    );
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: SizedBox(
                              height: 375,
                              width: double.infinity,
                              child: AnotherCarousel(
                                images:
                                    place['imageUrls']
                                        .map((url) => NetworkImage(url))
                                        .toList(),
                                dotSize: 6,
                                indicatorBgPadding: 5,
                                dotBgColor: Colors.transparent,
                              ),
                            ),
                          ),
                          Positioned(
                            top: 20,
                            left: 15,
                            right: 15,
                            child: Row(
                              children: [
                                place['isActive'] == true
                                    ? Container(
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(40),
                                      ),
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 15,
                                          vertical: 5,
                                        ),
                                        child: Text(
                                          "Guest Favourite",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    )
                                    : SizedBox(
                                      width:
                                          MediaQuery.of(context).size.width *
                                          0.03,
                                    ),
                                Spacer(),
                                //for favourite button
                                Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    Icon(
                                      Icons.favorite_outline_rounded,
                                      size: 34,
                                      color: Colors.white,
                                    ),
                                    InkWell(
                                      onTap: (){
                                        provider.toggleFavourite(place);
                                      },
                                      child: Icon(
                                        Icons.favorite,
                                        size: 30,
                                        color: provider.isExist(place) ? Colors.red : Colors.black,
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                          //for vendor profile
                          vendorProfile(place),
                        ],
                      ),
                      SizedBox(
                        height: size.height * 0.01,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  place['address'],
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              Icon(Icons.star, size: 18),
                              SizedBox(width: 5),
                              Text(place['rating'].toString()),
                            ],
                          ),
                          SizedBox(height: 4),
                          Text(
                            "Stay with ${place['vendor']} . ${place['vendorProfession']}",
                            style: TextStyle(
                              color: Colors.black45,
                              fontSize: 16.5,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(height: 4),
                          Text(
                            place['date'],
                            style: TextStyle(
                              fontSize: 16.5,
                              color: Colors.black45,
                            ),
                          ),
                          SizedBox(height: size.height * 0.007),
                          RichText(
                            text: TextSpan(
                              text: "\$${place['price']} ",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                                fontSize: 16,
                              ),
                              children: [
                                TextSpan(
                                  text: "night",
                                  style: TextStyle(
                                    fontWeight: FontWeight.normal,
                                    color: Colors.black,
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: size.height * 0.04),
                        ],
                      )


                    ],
                  ),
                ),
              );
            },
          );
        }
        return Center(child: CircularProgressIndicator());
      },
    );
  }



  Positioned vendorProfile(QueryDocumentSnapshot<Object?>place){
    return Positioned(
      bottom: 11,
      left: 10,
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(15),
              topLeft: Radius.circular(15),
            ),
            child: Icon(
              Icons.book,
            ),
            // child: Image.asset(
            //   "asset/images/book_cover.png",
            //   height: 60,
            //   width: 60,
            //   fit: BoxFit.cover,
            // ),
          ),
          Positioned(
            top: 10,
            left: 10,
            child: CircleAvatar(
              backgroundImage: NetworkImage(
                place['vendorProfile'],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
