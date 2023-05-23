import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

final FirebaseAuth auth = FirebaseAuth.instance;
User? currentUser;
firestore(snapshot) async {
  snapshot = await FirebaseFirestore.instance.collection('sessions').get();
}

User? getCurrentUser() {
  return auth.currentUser;
}

User? setCurrentUser(currentUser1) {
  currentUser = currentUser1.user;
}

Future<User?> update_User() async {
  await auth.currentUser!.reload();
  currentUser = await auth.currentUser;
}
