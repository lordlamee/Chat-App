import 'package:chat_app/services/store_user_info.dart';
import 'package:chat_app/utilities/widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class ChatsData extends ChangeNotifier{
  List allChatDocs = List();
  List searchResults = List();
  bool loading = true;
  getUsers() async {
    QuerySnapshot snap = await fireStore
        .collection("users").getDocuments();
    List<DocumentSnapshot> userDocs = snap.documents;
    allChatDocs = userDocs;
    searchResults = userDocs;
    loading = false;
    notifyListeners();
  }
  search(String query) {
    if(query == ""){
      searchResults = allChatDocs;
    }else{
      List userSearch = allChatDocs.where((userDoc){
        Map user = userDoc.data;
        String userName = user['name'];
        return userName.toLowerCase().contains(query.toLowerCase());
      }).toList();
      searchResults = userSearch;
    }
    notifyListeners();
  }
}