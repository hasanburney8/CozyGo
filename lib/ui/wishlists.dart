import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo/provider/favourite_provider.dart';
import 'package:flutter/material.dart';

class Wishlists extends StatefulWidget {
  const Wishlists({super.key});

  @override
  State<Wishlists> createState() => _WishlistsState();
}

class _WishlistsState extends State<Wishlists> {
  @override
  Widget build(BuildContext context) {
    final provider = FavoriteProvider.of(context);
    final favoriteItems = provider.favorites;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        bottom: false,
        child: Padding(
          padding: EdgeInsets.all(15),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    "Edit",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
                SizedBox(height: 35),
                Text(
                  "WishLists",
                  style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 5),
                favoriteItems.isEmpty
                    ? Text(
                      "No Favourite items yet",
                      style: TextStyle(fontSize: 19, fontWeight: FontWeight.w600),
                    )
                    : SizedBox(
                      height: MediaQuery.of(context).size.height * 0.68,
                      child: GridView.builder(
                        itemCount: favoriteItems.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 8,
                          mainAxisSpacing: 8,
                        ),
                        itemBuilder: (context, index) {
                          String favorite = favoriteItems[index];
                          return FutureBuilder(
                            future:
                                FirebaseFirestore.instance
                                    .collection("myAppCollection")
                                    .doc(favorite)
                                    .get(),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return Center(child: CircularProgressIndicator());
                              }
                              if (!snapshot.hasData || snapshot.data == null) {
                                return Center(
                                  child: Text("Error loading favorites"),
                                );
                              }
                              var favoriteItems = snapshot.data!;
                              return Stack(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: NetworkImage(
                                          favoriteItems['image'],
                                        ),
                                      ),
                                    ),
                                  ),
                                  //favorite icon in the top right corner
                                  Positioned(
                                    top: 8,
                                    right: 8,
                                    child: Icon(
                                      Icons.favorite,
                                      color: Colors.red,
                                    ),
                                  ),
                                  //title of favorite item
                                  Positioned(
                                    bottom: 8,
                                    left: 8,
                                    right: 8,
                                    child: Container(
                                      color: Colors.black.withOpacity(0.6),
                                      padding: EdgeInsets.all(4),
                                      child: Text(
                                        favoriteItems['title'],
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                      ),
                    ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
