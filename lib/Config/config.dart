import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_storage/firebase_storage.dart';

class FourgreenApp {
  
  static const String appName ='FourGreen App';

  static SharedPreferences sharedPreferences;
  static FirebaseUser user;
  static FirebaseAuth auth;
  static Firestore firestore;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  static String collectionUser = "users";
  static String collectionOrders = "orders";

  static final String userName = 'name';
  static final String userEmail = 'email';
  static final String userUID = 'uid';
  static final String userPhone = 'phone';

  static StorageReference storageReferences;

}