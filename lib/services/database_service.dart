import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final String? uid;
  DatabaseService ({this.uid});

  final CollectionReference userCollection = FirebaseFirestore.instance.collection("users");
  final CollectionReference groupsCollection = FirebaseFirestore.instance.collection("groups");
  final CollectionReference activitiesCollection = FirebaseFirestore.instance.collection("activities");

  Future savingUserData(String fullName, String email) async {
    return await userCollection.doc(uid).set({
      "fullname" : fullName,
      "email" : email,
      "groups" : [],
      "profilepic" : ""
    });
  }

  Future gettingUserData(String email) async {
    QuerySnapshot snapshot = await userCollection.where("email", isEqualTo: email).get();
    return snapshot;
  }

  getUserGroups() async {
    return userCollection.doc(uid).snapshots();
  }
}