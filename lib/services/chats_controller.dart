import 'package:chat_app/models/models.dart';
import 'package:chat_app/services/sign_in_service.dart';
import 'package:chat_app/services/store_user_info.dart';
import 'package:chat_app/utilities/widgets.dart';
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
  DocumentReference users = await fireStore.collection("chats").add({
    "users": [recipientId, userId]
  });
  // add message to the firebase collection
  DocumentReference messageRef = await fireStore
      .collection("chats")
      .document(users.documentID)
      .collection("messages")
      .add({
    "content": message,
    "senderId": userId,
    "timestamp": Timestamp.now()
  });
  return messageRef.documentID;
}
 sendMessage(message,chatId,recipientId,senderId,recipientName)async{
   if (message != null && message.trim() != "") {
     if (chatId == "new chat") {
       if (recipientId != null) {
         await sendFirstMessage(
             recipientId, senderId, message);
       } else {
         //generate recipient Id just in case
         var generatedRecipientId = await generateRecipientId(recipientName);
         await sendFirstMessage(
             generatedRecipientId, userId, message);
//                              setState(() {
//                                widget.chatId = generatedChatId;
//                              });
       }
     } else {
       await fireStore
           .collection("chats")
           .document(chatId)
           .collection("messages")
           .add({
         "content": message,
         "senderId": senderId,
         "timestamp": Timestamp.now()
       });
     }
   }
 }
newChatSearch(String searchFilter, List<ChatTile> chatTileList) {
  if (searchFilter != null && searchFilter != "") {
    chatTileList = chatTileList
        .where((element) =>
            element.name.toLowerCase().contains(searchFilter.toLowerCase()))
        .toList();
  }
}

generateRecipientId(name) async {
  QuerySnapshot documentQuery = await fireStore
      .collection("users")
      .where("name", isEqualTo: name)
      .getDocuments();
  List<DocumentSnapshot> documents = documentQuery.documents;
  String generatedRecipientId = documents[0].documentID;
  return generatedRecipientId;
}
