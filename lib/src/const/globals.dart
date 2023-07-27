import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

Map? currentUser;

Map? getCurrentUser() {
  return currentUser;
}

Map? setCurrentUser(currentUser1) {
  currentUser = currentUser1;
}
