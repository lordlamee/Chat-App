import 'package:chat_app/services/sign_in_service.dart';
import 'package:chat_app/services/store_user_info.dart';

 getChats()async{
   final chats =  fireStore.collection("users").snapshots();

   await for (var user in chats){
     for(var  name in user.documents){
      print(name.data["name"]);
    }
   }
   final test = fireStore.collection("chats").where("users",arrayContains: userId);
 print(test);
   }
  searchUser(String name){
   fireStore.collection("users").where("name", isEqualTo: name).getDocuments();
  }