import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  FirebaseFirestore db = FirebaseFirestore.instance;
  Future<String?> addUser({
    required String fullName,
    required String email,
    required String foodallergy,
    required String foodpref,
  }) async {
    try {
      // CollectionReference users =
      //     FirebaseFirestore.instance.collection('Users');
      final users = db.collection("Users");
      // Call the user's CollectionReference to add a new user
      final data1 = <String, dynamic>{
        'full_name': fullName,
        'email': email,
        'food_allergy': foodallergy,
        'food_pref': foodpref,
      };
      users.doc("Users").set(data1);
      return 'success';
    } catch (e) {
      return 'Error adding user';
    }
  }

  getUser() async {
    // try {
    //   CollectionReference users =
    //       FirebaseFirestore.instance.collection('Users');

    //   final snapshot = await users.doc("Users").get();
    //   final data = snapshot.data() as Map<String, dynamic>;
    //   return data['full_name'];
    // } catch (e) {
    //   return 'Error fetching user';
    // }

    final docRef = db.collection("Users").doc("Users");
    docRef.get().then(
      (DocumentSnapshot doc) {
        final data = doc.data() as Map<String, dynamic>;
        return data['full_name'];
      },
      onError: (e) => print("Error getting document: $e"),
    );
  }
}
