import 'package:cantwait28/models/item_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ItemsRepository {
  Stream<List<ItemModel>> getItemStream() {
    return FirebaseFirestore.instance
        .collection('items')
        .orderBy('release_date')
        .snapshots()
        .map(
      (querruSnapshot) {
        return querruSnapshot.docs.map((doc) {
          return ItemModel(
            id: doc.id,
            title: doc['title'],
            imageURL: doc['image_url'],
            relaseDate: (doc['release_date'] as Timestamp).toDate(),
          );
        }).toList();
      },
    );
  }

  Future<void> delete({required String id}) {
    return FirebaseFirestore.instance.collection('items').doc(id).delete();
  }

  Future<void> add(
    String title,
    String imageURL,
    DateTime releaseDate,
  ) async {
    await FirebaseFirestore.instance.collection('items').add(
      {
        'title': title,
        'image_url': imageURL,
        'release_date': releaseDate,
      },
    );
  }
}
