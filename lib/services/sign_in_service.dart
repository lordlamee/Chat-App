import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
var userName;
var userEmail;
var photoUrl;
var userId;
FirebaseUser appUser;
final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
final GoogleSignIn googleSignIn = GoogleSignIn();
Future<String> signInWithGoogle() async {
  final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
  final GoogleSignInAuthentication googleSignInAuthentication =
      await googleSignInAccount.authentication;
  final AuthCredential credential = GoogleAuthProvider.getCredential(
      idToken: googleSignInAuthentication.idToken,
      accessToken: googleSignInAuthentication.accessToken);
  final AuthResult authResult =
      await _firebaseAuth.signInWithCredential(credential);
  final FirebaseUser user = authResult.user;
  assert(await user.getIdToken() != null);
  final FirebaseUser currentUser = await _firebaseAuth.currentUser();
  assert(user.uid == currentUser.uid);
  userName = currentUser.displayName;
  userEmail = currentUser.email;
  photoUrl = currentUser.photoUrl;
  userId = currentUser.uid;
  appUser = currentUser;
  return "Sign in Successful";
}

signOutGoogle() async {
  googleSignIn.signOut();
}
