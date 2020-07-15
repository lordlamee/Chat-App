import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';

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
  return 'Sign In of $user success';
}

signOutGoogle() async {
  googleSignIn.signOut();
}
