import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';

var userName;
var userEmail;
var photoUrl;
var userId;
FirebaseUser user;
FirebaseUser appUser;
final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
final GoogleSignIn googleSignIn = GoogleSignIn();

Future<FirebaseUser> signInWithGoogle() async {
  final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
  final GoogleSignInAuthentication googleSignInAuthentication =
      await googleSignInAccount.authentication;
  final AuthCredential credential = GoogleAuthProvider.getCredential(
      idToken: googleSignInAuthentication.idToken,
      accessToken: googleSignInAuthentication.accessToken);
  final AuthResult authResult =
      await _firebaseAuth.signInWithCredential(credential);
  user = authResult.user;
  assert(await user.getIdToken() != null);
  final FirebaseUser currentUser = await _firebaseAuth.currentUser();
  assert(user.uid == currentUser.uid);
  userName = currentUser.displayName;
  userEmail = currentUser.email;
  photoUrl = currentUser.photoUrl;
  userId = currentUser.uid;
  return currentUser;
}

checkForUser() async {
  appUser = await _firebaseAuth.currentUser();
  if (appUser != null) {
    userName = appUser.displayName;
    userEmail = appUser.email;
    photoUrl = appUser.photoUrl;
    userId = appUser.uid;
    user = appUser;
  } else {
    return null;
  }
}

signOutGoogle() async {
  googleSignIn.signOut();
}
