import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class FavoriteProvider extends ChangeNotifier {
  List<String> _favoriteIds = [];

  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  List<String> get favorites => _favoriteIds;

  FavoriteProvider(){
    loadFavorite();
  }

  // Toggle favourite state
  void toggleFavourite(DocumentSnapshot place) async {
    String placeId = place.id;

    if (_favoriteIds.contains(placeId)) {
      _favoriteIds.remove(placeId);
      await _removeFavorite(placeId);
    } else {
      _favoriteIds.add(placeId); // add to favorite
      await _addFavorites(placeId);
    }

    notifyListeners();
  }

  // check if a place is a favorite
  bool isExist(DocumentSnapshot place) {
    return _favoriteIds.contains(place.id);
  }

  // addd favorite items to firestore
  Future<void> _addFavorites(String placeId) async {
    try {
      await firebaseFirestore
          .collection("userFavourites")
          .doc(placeId)
          .set({'isFavourite': true});
    } catch (e) {
      print(e.toString());
    }
  }

  //remove favorite items from firestore
  Future<void> _removeFavorite(String placeId) async {
    try {
      // create userFavorite collection and add items as favorites in firestore
      await firebaseFirestore.collection("userFavourites").doc(placeId).delete();
    } catch (e) {
      print(e.toString());
    }
  }

  //load favorites items from firestore (if user make some items then load those items)
  Future<void> loadFavorite()async{
    try{
      QuerySnapshot snapshot = await firebaseFirestore.collection("userFavorites").get();
      _favoriteIds = snapshot.docs.map((doc) => doc.id).toList();
    } catch(e){
      print(e.toString());
    }
    notifyListeners();
  }

  // Static method to access the provider from any context
  static FavoriteProvider of(BuildContext context, {bool listen = true}) {
    return Provider.of<FavoriteProvider>(context, listen : listen) ;
  }

}
