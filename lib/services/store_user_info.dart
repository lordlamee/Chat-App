import 'package:chat_app/services/sign_in_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final Firestore fireStore = Firestore.instance;

storeUserDetails() async {
  await fireStore.collection("users").add({
    "name": userName,
    "email": userEmail,
    "photoUrl": photoUrl,
  });
}
