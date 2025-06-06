import 'package:another_carousel_pro/another_carousel_pro.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo/Components/location_in_map.dart';
import 'package:demo/Components/my_icon_button.dart';
import 'package:demo/Components/star_rating.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/favourite_provider.dart';

class PlaceDetailScreen extends StatefulWidget {
  final DocumentSnapshot<Object?> place;
  const PlaceDetailScreen({super.key, required this.place});

  @override
  State<PlaceDetailScreen> createState() => _PlaceDetailScreenState();
}

class _PlaceDetailScreenState extends State<PlaceDetailScreen> {
  int currentIndex =0;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final provider = FavoriteProvider.of(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            detailImageandIcon(size, context,provider),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 25, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.place['title'],
                    maxLines: 2,
                    style: TextStyle(
                      fontSize: 25,
                      height: 1.2,
                      fontWeight: FontWeight.bold,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  SizedBox(height: size.height*0.11,),
                  Text(
                    "Room in ${widget.place['address']}",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    widget.place['bedAndBathroom'],
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
            widget.place["isActive"] == true
                ? ratingAndStarTrue()
                : ratingAndStarFalse(),
            SizedBox(height: size.height*0.02,),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 25,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Divider(),
                  propertyList(
                      size,
                      "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS6Jyu3eHjWsF5TYtLFg9WuLoXYXDxy354oRQ&s",
                      "This is a rare find",
                      "${widget.place['vendor']}'s is usually booked",
                  ),
                  Divider(),
                  propertyList(
                    size,
                    widget.place['vendorProfile'],
                    "Stay with ${widget.place['vendor']}",
                    "Superhost . ${widget.place['yearOfHostin']} years hosting.",
                  ),
                  Divider(),
                  propertyList(
                    size,
                    "https://t4.ftcdn.net/jpg/02/77/19/21/360_F_277192157_0btAp9C8TbXPz7vHRBMbxhgoe7XiZtcQ.jpg",
                    "Room in a rental unit",
                    "Your own room in a home, plus access \nto shared spaces.",
                  ),
                  Divider(),
                  propertyList(
                    size,
                    // "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS6Jyu3eHjWsF5TYtLFg9WuLoXYXDxy354oRQ&s",
                    "https://static.vecteezy.com/system/resources/thumbnails/004/438/097/small/coworking-space-linear-icon-meeting-room-establishing-community-freelance-professionals-businessmen-thin-line-illustration-contour-symbol-isolated-outline-drawing-editable-stroke-vector.jpg",
                    "Shared common space",
                    "You will share parts of the home with the host.",
                  ),
                  Divider(),
                  propertyList(
                    size,
                    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT6mW-UCCoJQ6WXakQ-cdEQubllVBMH1Ul7jw&s",
                    "Shared bathroom",
                    "You will share the bathroom with others. ",
                  ),
                  Divider(),
                  SizedBox(height: size.height*0.02,),
                  Text(
                    "About this place",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                    ),
                  ),
                  Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."),
                  Divider(),
                  Text(
                    "Where you will be",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    widget.place['address'],
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                  SizedBox(
                    height: 400,
                    width: size.width,
                    child: LocationInMap(
                        place: widget.place,
                    ),
                  ),
                  SizedBox(height: 100,),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomSheet: priceAndReserve(size),
    );
  }
  
  Container priceAndReserve(Size size){
    return Container(
      height: size.height * 0.1,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.black12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              RichText(
                text: TextSpan(
                  text: "\$${widget.place['price']}",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontSize: 18,
                  ),
                  children: [
                    TextSpan(
                      text: "night",
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                widget.place['date'],
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  decoration: TextDecoration.underline,
                ),
              ),
            ],
          ),
          SizedBox(width: size.width * 0.3,),
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: 35,
              vertical: 15,
            ),
            decoration: BoxDecoration(
              color: Colors.pink,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Text(
              "Reserve",
              style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.bold
              ),
            ),
          ),
        ],
      ),
    );
  }

  Padding propertyList(Size size, image, title, subtitle){
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 15),
      child: Row(
        children: [
          Divider(),
          CircleAvatar(
            backgroundColor: Colors.white,
            backgroundImage: NetworkImage(image),
            radius: 29,
          ),
          SizedBox(
            width: size.width * 0.05,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  subtitle,
                  softWrap: true,
                  overflow: TextOverflow.visible,
                  style: TextStyle(
                    fontSize: size.width * 0.0346,
                    color: Colors.grey.shade700,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Padding ratingAndStarFalse() => Padding(
    padding: EdgeInsets.symmetric(horizontal: 25),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(Icons.star),
        SizedBox(width: 5,),
        Text(
          "${widget.place['rating'].toString()} .",
          style: TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          "${widget.place['review'].toString()}reviews",
          style: TextStyle(
            fontSize: 17,
            decoration: TextDecoration.underline,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    ),
  );

  Container ratingAndStarTrue(){
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: 13,
        vertical: 5,
      ),
      padding: EdgeInsets.symmetric(
        horizontal: 8,
        vertical: 15,
      ),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.black26,
        ),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        children: [
          Column(
            children: [
              Text(
                widget.place['rating'].toString(),
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                  height: 1,
                ),
              ),
              StarRating(rating: widget.place['rating']),
            ],
          ),
          Stack(
            children: [
              Image.network(
                "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS6Jyu3eHjWsF5TYtLFg9WuLoXYXDxy354oRQ&s",
                height: 50,
                width: 130,
                color: Colors.amber,
              ),
              Positioned(
                left: 35,
                child: Text(
                  "Guest\nFavourite",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    height: 1.2,
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),
          Column(
            children: [
              Text(
                widget.place['review'].toString(),
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 17,
                ),
              ),
              Text(
                "Reviews",
                style: TextStyle(
                  height: 0.7,
                  color: Colors.black,
                  decoration: TextDecoration.underline,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Stack detailImageandIcon(Size size, BuildContext context, provider){
    return Stack(
      children: [
        SizedBox(
          height: size.height*0.35,
          child: AnotherCarousel(
            images: widget.place['imageUrls'].map((url)=>NetworkImage(url)).toList(),
            showIndicator: false,
            dotBgColor: Colors.transparent,
            onImageChange: (p0,p1){
              setState(() {
                currentIndex = p1;
              });
            },
            autoplay: true,
            boxFit: BoxFit.contain,
          ),
        ),
        Positioned(
          bottom: 10,
          right: 20,
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: 15,
              vertical: 5,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.black54,
            ),
            child: Text(
              "${currentIndex + 1} / ${widget.place['imageUrls'].length}",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ),
        Positioned(
          right: 0,
          left: 0,
          top: 25,
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: (){
                    Navigator.pop(context);
                  },
                  child: MyIconButton(
                    icon: Icons.arrow_back_ios_new,
                  ),
                ),
                SizedBox(width: size.width*0.55,),
                MyIconButton(icon: Icons.share_outlined),
                SizedBox(width: 20,),
                InkWell(
                  onTap: (){
                    provider.toggleFavorite(widget.place);
                  },
                  child: MyIconButton(
                    icon: provider.isExist(widget.place) ? Icons.favorite : Icons.favorite_border,
                    iconsColor: provider.isExist(widget.place) ? Colors.red : Colors.black,
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
