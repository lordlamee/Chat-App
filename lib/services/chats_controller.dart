import 'package:chat_app/models/models.dart';
import 'package:chat_app/services/store_user_info.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


Future<Map<String, String>> getRecipientDetails(String recipientId) async {
  QuerySnapshot usersQuery = await fireStore.collection("users").getDocuments();
  List<DocumentSnapshot> documents = usersQuery.documents;
  List recipientDocumentList =
      documents.where((element) => element.documentID == recipientId).toList();
  DocumentSnapshot recipientDocument = recipientDocumentList[0];
  return {
    "name": recipientDocument["name"],
    "photoUrl": recipientDocument["photoUrl"]
  };
}

sendFirstMessage(recipientId, userId, message) async {
  DocumentReference users =
  await fireStore.collection("chats").add({
    "users": [recipientId, userId]
  });
  // add message to the firebase collection
  fireStore
      .collection("chats")
      .document(users.documentID)
      .collection("messages")
      .add({
    "content": message,
    "senderId": userId,
    "timestamp": Timestamp.now()
  });
}



