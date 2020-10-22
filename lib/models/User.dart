import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String id;
  final String first_name;
  final String last_name;
  final String profileImageUrl;
  final String email;
  // final List<Habit> habits;

  User({
    this.id,
    this.first_name,
    this.last_name,
    this.profileImageUrl,
    this.email,
    // this.habits,
  });

  // factory User.fromDoc(DocumentSnapshot doc) {
  //   return User(
  //     id: doc.documentID,
  //     name: doc['name'],
  //     profileImageUrl: doc['profileImageUrl'],
  //     email: doc['email'],
  //     bio: doc['bio'] ?? '',
  //   );
  // }
}
